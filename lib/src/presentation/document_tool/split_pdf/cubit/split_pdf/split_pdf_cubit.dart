import 'dart:io';
import 'dart:isolate';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:vtn_flutter_pdf/pdf.dart';

import '../../../../../../module/file_system/file_path_manager.dart';
import '../pdf_grid/pdf_grid_state.dart';

part 'split_pdf_cubit.freezed.dart';
part 'split_pdf_state.dart';

class SplitPdfCubit extends Cubit<SplitPdfState> {
  SplitPdfCubit() : super(const SplitPdfState.initial());

  Future<File?> splitPdf({
    required String fileName,
    required Uint8List bytes,
    required List<PageModel> pages,
  }) async {
    emit(const SplitPdfState.loading());
    final selected = <int>[];
    for (final page in pages) {
      if (page.isSelected) {
        selected.add(page.originalIndex); // 0-based index của trang gốc
      }
    }
    if (selected.isEmpty) {
      return null; // không có trang nào được chọn
    }

    try {
      // Gọi isolate để tách trang (không block UI)
      final ttdIn = TransferableTypedData.fromList([bytes]);
      final ttdOut = await Isolate.run(
        () => splitPdfBytesTTD(ttdIn, Int32List.fromList(selected)),
      );
      final outBytes = ttdOut.materialize().asUint8List();

      // Ghi file vào thư mục Downloads
      final filePath = await FilePathManager.instance
          .saveBytesToDownloads(outBytes, '$fileName.pdf');
      final file = File(filePath);
      emit(SplitPdfState.success(splitFile: file));
      return File(filePath);
    } catch (e) {
      emit(SplitPdfState.error(message: e.toString()));
      return null; // trả về null nếu có lỗi
    }
  }
}

TransferableTypedData splitPdfBytesTTD(
  TransferableTypedData srcTTD,
  Int32List selectedIndices0, // 0-based
) {
  final srcBytes = srcTTD.materialize().asUint8List();

  // Mở PDF nguồn từ bytes (đã unlock hoặc bytes gốc nếu không khóa)
  final src = PdfDocument(inputBytes: srcBytes);

  // Dùng nhiều section để giữ đúng kích cỡ trang (nếu kích cỡ khác nhau)
  final out = PdfDocument();

  // Map kích thước -> section để tái sử dụng, tránh tạo section thừa
  final Map<String, PdfSection> sectionBySize = {};

  PdfSection sectionForSize(Size size) {
    final key = '${size.width}x${size.height}';
    final existed = sectionBySize[key];
    if (existed != null) {
      return existed;
    }

    final sec = out.sections!.add();
    sec.pageSettings.margins.all = 0;
    sec.pageSettings.size = size;
    sectionBySize[key] = sec;
    return sec;
  }

  for (final idx in selectedIndices0) {
    final page = src.pages[idx];
    final tpl = page.createTemplate();
    final size = page.getClientSize(); // giữ nguyên kích cỡ
    final sec = sectionForSize(size);
    sec.pages.add().graphics.drawPdfTemplate(tpl, Offset.zero, size);
  }

  final outBytes = Uint8List.fromList(out.saveSync());
  out.dispose();
  src.dispose();

  return TransferableTypedData.fromList([outBytes]);
}
