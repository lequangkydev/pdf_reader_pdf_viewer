import 'dart:io';
import 'dart:isolate';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart'; // (Có thể thay bằng: import 'dart:ui' show Offset; nếu chỉ cần Offset trong isolate)
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:printing/printing.dart';
import 'package:vtn_flutter_pdf/pdf.dart';

import '../../../../../global/global.dart';
import 'pdf_grid_state.dart';

/// Hàm top-level chạy trong Isolate:
/// Nhận bytes PDF (TransferableTypedData) + password, tạo ra bản PDF "unlocked"
/// để gỡ yêu cầu password/hạn chế in/chỉnh sửa. Trả về bytes bằng TransferableTypedData
/// nhằm tránh copy bộ nhớ lớn giữa isolates.
TransferableTypedData unlockPdfTTD(
  TransferableTypedData ttd,
  String? password,
) {
  // Lấy lại Uint8List từ TTD (zero-copy ở ranh giới isolate)
  final original = ttd.materialize().asUint8List();

  // Mở tài liệu nguồn (có thể cần password)
  final src = PdfDocument(inputBytes: original, password: password);

  // Tạo doc mới để "vẽ lại" từng trang -> bản không còn password
  final unlocked = PdfDocument();
  final count = src.pages.count;

  for (var i = 0; i < count; i++) {
    final p = src.pages[i];
    final tpl = p.createTemplate();
    final size = p.getClientSize(); // Giữ đúng kích thước trang gốc
    final dst = unlocked.pages.add();
    // Vẽ template lên trang mới ở (0,0) với đúng size để tránh méo/crop
    dst.graphics.drawPdfTemplate(tpl, Offset.zero, size);
  }

  // Lưu doc đã unlock ra bytes (List<int>) rồi bọc thành Uint8List
  final Uint8List out = Uint8List.fromList(unlocked.saveSync());

  // Giải phóng
  unlocked.dispose();
  src.dispose();

  // Gói lại thành TTD để gửi về main isolate (tránh copy lớn)
  return TransferableTypedData.fromList([out]);
}

/// Cubit quản lý quy trình: chuẩn bị bytes làm việc (unlock khi cần),
/// render từng lô (batch) -> ghi PNG ra thư mục tạm -> cập nhật UI.
class PdfGridCubit extends Cubit<PdfGridState> {
  PdfGridCubit() : super(PdfGridState.initial());

  bool _canceled = false; // Cờ dừng tải (khi dispose/cleanup)
  bool _auto = false; // Bật chế độ tự nạp tiếp sau mỗi batch

  /// Chuẩn bị: nếu password == null → dùng bytes gốc;
  /// nếu có password → unlock trong Isolate để tránh đơ UI.
  /// Sau đó tạo thư mục tạm cho phiên và phát “ready”.
  Future<void> prepare({
    required Uint8List original,
    String? password,
    double dpi = 100,
    int batchSize = 3, // Mỗi lô 3 trang
    bool autoStart = true, // Tự chạy nạp tiếp đến khi hết trang
  }) async {
    emit(state.copyWith(
      status: PdfGridStatus.preparing,
      dpi: dpi,
      batchSize: batchSize,
    ));

    try {
      Uint8List workingBytes;
      int pageCount;

      if (password == null) {
        // ✅ File không khoá: mở trực tiếp để lấy số trang, không cần unlock (nhẹ hơn)
        final doc = PdfDocument(inputBytes: original);
        pageCount = doc.pages.count;
        doc.dispose();
        workingBytes = original;
      } else {
        // 🔒 Có password: unlock ở isolate (tránh block main isolate)
        final ttdIn = TransferableTypedData.fromList([original]);
        final ttdOut = await Isolate.run(() => unlockPdfTTD(ttdIn, password));
        workingBytes = ttdOut.materialize().asUint8List();

        // Lấy pageCount CHÍNH XÁC từ bytes đã unlock (đầu vào thật của raster)
        final reopened = PdfDocument(inputBytes: workingBytes);
        pageCount = reopened.pages.count;
        reopened.dispose();
      }

      // Tạo thư mục tạm riêng cho phiên (để ghi file PNG từng trang)
      final tmp = Global.instance.temporaryPath;
      final dir = Directory(
        '$tmp/pdf_session_${DateTime.now().millisecondsSinceEpoch}',
      );
      if (!dir.existsSync()) {
        await dir.create(recursive: true);
      }

      // Phát trạng thái sẵn sàng: chưa có trang nào render, nextPageIndex = 0
      emit(state.copyWith(
        status: PdfGridStatus.ready,
        pageCount: pageCount,
        pages: <PageModel>[],
        // danh sách trang đã render (filePath + metadata)
        nextPageIndex: 0,
        isLoading: false,
        sessionDir: dir,
        unlockedBytes: workingBytes, // có thể là bytes gốc (nếu không khoá)
      ));

      // Bắt đầu auto-loading nếu bật
      if (autoStart) {
        startAutoLoading();
      }
    } catch (e) {
      emit(state.copyWith(
        status: PdfGridStatus.error,
        error: e.toString(),
      ));
    }
  }

  /// Bật vòng lặp tự nạp: cứ xong batch này thì gọi batch kế,
  /// cho đến khi hết trang hoặc bị huỷ/dừng.
  void startAutoLoading() {
    if (_auto) return;
    _auto = true;
    _pumpAuto();
  }

  /// Dừng auto-loading (ví dụ khi rời màn hình)
  void stopAutoLoading() => _auto = false;

  /// Vòng lặp auto-loading: gọi loadNextBatch() rồi nhường khung hình
  Future<void> _pumpAuto() async {
    while (_auto && !_canceled && state.hasMore) {
      await loadNextBatch(); // mỗi lần 3 trang (tuỳ batchSize trong state)
      // Nhường khung hình để UI mượt & GC có thời gian dọn
      await Future.delayed(const Duration(milliseconds: 16));
    }
  }

  /// Render theo lô (0-based index) và ghi PNG ra thư mục tạm.
  /// Mỗi lần gọi sẽ xử lý [batchSize] trang: [start, endExclusive).
  Future<void> loadNextBatch() async {
    final s = state;

    // Chỉ chạy khi đang "ready" hoặc "loading" (đang nạp dở)
    if (!{PdfGridStatus.ready, PdfGridStatus.loading}.contains(s.status)) {
      return;
    }
    // Điều kiện đủ: còn trang, không bận, có bytes đầu vào & thư mục tạm
    if (!s.hasMore ||
        s.isLoading ||
        s.unlockedBytes == null ||
        s.sessionDir == null) {
      return;
    }

    emit(s.copyWith(status: PdfGridStatus.loading, isLoading: true));

    try {
      final start = s.nextPageIndex; // 0-based
      final endExclusive = (start + s.batchSize <= s.pageCount)
          ? start + s.batchSize
          : s.pageCount;

      // Không còn gì để nạp
      if (endExclusive <= start) {
        emit(state.copyWith(status: PdfGridStatus.ready, isLoading: false));
        return;
      }

      // Danh sách chỉ số trang 0-based cho batch này
      final pages0 = List<int>.generate(
        endExclusive - start,
        (i) => start + i,
      );

      // Gom các PageModel mới render xong để append vào state.pages
      final updated = <PageModel>[];
      var i = 0; // vị trí phần tử trong batch

      // Raster: LƯU Ý pages là 0-based để tránh "Invalid page index"
      await for (final raster in Printing.raster(
        s.unlockedBytes!,
        dpi: s.dpi,
        pages: pages0,
      )) {
        if (_canceled) break;

        final png = await raster.toPng();

        // Lấy ra index trang gốc từ vị trí trong batch
        final pageIdx0 = pages0[i];
        i++;

        // Ghi ra file tạm (mỗi trang một file PNG)
        final path = '${s.sessionDir!.path}/p${pageIdx0 + 1}.png';
        final f = File(path);
        if (!f.existsSync()) {
          await f.writeAsBytes(png, flush: true);
        }

        // Lưu metadata để UI hiển thị / chọn / reorder
        updated.add(PageModel(
          filePath: path,
          originalIndex: pageIdx0, // ghi nhận index gốc (0-based)
        ));
      }

      // Nhường khung hình (giảm giật, giúp GC dọn bitmap vừa raster)
      await Future.delayed(const Duration(milliseconds: 16));

      // Cập nhật tiến độ: tăng nextPageIndex, ghép các trang mới vào danh sách
      emit(state.copyWith(
        status: PdfGridStatus.ready,
        isLoading: false,
        nextPageIndex: endExclusive,
        pages: <PageModel>[...state.pages, ...updated],
      ));
    } catch (e) {
      // Nếu Cubit đã đóng (dispose) thì không emit nữa
      if (isClosed) {
        return;
      }

      emit(state.copyWith(
        status: PdfGridStatus.ready,
        isLoading: false,
        error: e.toString(),
      ));
    }
  }

  /// Đặt cờ huỷ để dừng vòng nạp & các tác vụ đang chạy
  void cancel() => _canceled = true;

  /// Dọn dẹp thư mục tạm + clear image cache để giải phóng RAM/GPU.
  Future<void> cleanup() async {
    _canceled = true;
    _auto = false;
    try {
      final dir = state.sessionDir;
      if (dir != null && await dir.exists()) {
        await dir.delete(recursive: true); // xoá toàn bộ ảnh tạm
      }
    } catch (_) {}

    // Dọn cache ảnh lớn của Flutter (tránh giữ bitmap không cần)
    PaintingBinding.instance.imageCache.clear();
    PaintingBinding.instance.imageCache.clearLiveImages();
    if (isClosed) {
      return;
    }
    // Đưa state về trạng thái đã đóng
    emit(state.copyWith(
      status: PdfGridStatus.disposed,
      pages: const [],
      pageCount: 0,
      nextPageIndex: 0,
    ));
  }

  /// Toggle chọn/bỏ chọn một trang (phục vụ split)
  void toggleSelection(int index) {
    final updated = List<PageModel>.of(state.pages);
    updated[index] = updated[index].copyWith(
      isSelected: !updated[index].isSelected,
    );
    emit(state.copyWith(pages: updated));
  }

  void toggleSelectAll() {
    final allSelected = state.pages.every((p) => p.isSelected);
    final updated =
        state.pages.map((p) => p.copyWith(isSelected: !allSelected)).toList();
    emit(state.copyWith(pages: updated));
  }

  /// Đổi vị trí trang trong danh sách đã render (drag & drop)
  void reorderPage(int oldIndex, int newIndex) {
    final updated = List<PageModel>.of(state.pages);
    if (oldIndex < 0 ||
        oldIndex >= updated.length ||
        newIndex < 0 ||
        newIndex >= updated.length) {
      return; // Bảo vệ chỉ số
    }

    final item = updated.removeAt(oldIndex);
    updated.insert(newIndex, item);

    emit(state.copyWith(pages: updated));
  }

  /// Khi Cubit đóng, đảm bảo dọn dẹp tài nguyên/thư mục tạm
  @override
  Future<void> close() {
    cleanup();
    return super.close();
  }
}
