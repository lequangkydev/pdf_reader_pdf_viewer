import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vtn_flutter_pdf/pdf.dart';

import '../../../../data/model/file_model.dart';
import '../edit_pdf_screen.dart';
import '../model/add_watermark_state.dart';

class AddWatermarkCubit extends Cubit<AddWatermarkState> {
  AddWatermarkCubit() : super(const AddWatermarkState());

  void initReset() {
    emit(AddWatermarkState(text: ''));
  }

  // cập nhật text
  void onTextChanged(String value) {
    emit(state.copyWith(text: value));
  }

  // cập nhật màu
  void onColorChanged(Color color) {
    emit(state.copyWith(colorText: color));
  }

  // cập nhật size chữ
  void onFontSizeChanged(double size) {
    emit(state.copyWith(fontSize: size));
  }

  // cập nhật góc xoay
  void onRotationChanged(double angle) {
    emit(state.copyWith(rotation: angle));
  }

  Future<void> _saveWatermarkToPdf({
    required PdfDocument document,
    required int pageIndex,
    required Size pageSize, // kích thước hiển thị của page (từ pageBuilder)
    required Offset position, // vị trí (left, top) TRÊN PAGE (display coords)
    required Size watermarkSize, // kích thước widget watermark (display coords)
    required String watermarkText,
  }) async {
    final PdfPage pdfPage = document.pages[pageIndex];

    // kích thước thật của page (PDF units)
    final Size pdfSize = Size(
      pdfPage.getClientSize().width,
      pdfPage.getClientSize().height,
    );

    // scale X/Y (an toàn hơn dùng 1 factor duy nhất)
    final double xFactor = pdfSize.width / pageSize.width;
    final double yFactor = pdfSize.height / pageSize.height;

    // toạ độ & kích thước trong hệ PDF (trước khi xoay)
    final double pdfX = position.dx * xFactor;
    final double pdfY = position.dy * yFactor;
    final double pdfW = watermarkSize.width * xFactor;
    final double pdfH = watermarkSize.height * yFactor;

    // góc: state.rotation lưu theo ĐỘ (degree)
    final double angleRad = state.rotation;
    final double angleDeg = angleRad * 180.0 / math.pi;
    ;

    // tính AABB của rect sau xoay (dùng radian để cos/sin)
    final double absCos = math.cos(angleRad).abs();
    final double absSin = math.sin(angleRad).abs();
    final double bboxW = pdfW * absCos + pdfH * absSin;
    final double bboxH = pdfW * absSin + pdfH * absCos;

    // tâm watermark (ban đầu)
    double centerX = pdfX + pdfW / 2;
    double centerY = pdfY + pdfH / 2;

    // clamp tâm để AABB không vượt ra ngoài trang
    final double halfBw = bboxW / 2;
    final double halfBh = bboxH / 2;
    centerX = centerX.clamp(halfBw, pdfSize.width - halfBw);
    centerY = centerY.clamp(halfBh, pdfSize.height - halfBh);

    final PdfGraphics g = pdfPage.graphics;
    final PdfGraphicsState gState = g.save();

    // opacity
    g.setTransparency(0.5);

    // dịch tâm rồi xoay (xoay quanh tâm watermark)
    g.translateTransform(centerX, centerY);

    // CHÚ Ý: nhiều thư viện (ví dụ Syncfusion) nhận angle theo độ (degree).
    // Nếu thư viện của bạn cần radians thì truyền angleRad thay vì angleDeg.
    final double angleForPdf = angleDeg;
    g.rotateTransform(angleForPdf);

    // scale font cho khớp tỉ lệ hiển thị → dùng trung bình x/y để tránh méo chữ
    final double avgFactor = (xFactor + yFactor) / 2;
    final double fontSizePdf = (state.fontSize * avgFactor).clamp(6.0, 350.0);
    final PdfFont font = PdfStandardFont(PdfFontFamily.timesRoman, fontSizePdf);

    final PdfBrush brush = PdfSolidBrush(PdfColor(
      state.colorText.red,
      state.colorText.green,
      state.colorText.blue,
    ));

    // vẽ text trong rect centered tại origin (origin là center)
    // dùng PdfStringFormat (nếu thư viện hỗ trợ) để canh giữa
    final pdfStringFormat = PdfStringFormat(
      alignment: PdfTextAlignment.center,
      lineAlignment: PdfVerticalAlignment.middle,
    );

    g.drawString(
      state.text,
      font,
      brush: brush,
      bounds: Rect.fromLTWH(-pdfW / 2, -pdfH / 2, pdfW, pdfH),
      format: pdfStringFormat,
    );

    g.restore(gState);
  }

  Future<FileModel?> onSavePressed({
    required FileModel pdfFile,
    required int currentPage,
    required Offset position,
    Size? currentPageSize,
    String? password,
  }) async {
    if (currentPageSize == null) {
      emit(state.copyWith(isLoading: false, errorMessage: ''));
      return null;
    }
    emit(state.copyWith(isLoading: true, isSuccess: false, errorMessage: null));
    try {
      final document = PdfDocument(
        inputBytes: pdfFile.file.readAsBytesSync(),
        password: password,
      );

      // lấy kích thước của widget trên page pdf
      final RenderBox? watermarkBox =
          positionToolKey.currentContext?.findRenderObject() as RenderBox?;
      final Size watermarkSize = watermarkBox?.size ?? const Size(100, 30);

      await _saveWatermarkToPdf(
        document: document,
        pageIndex: currentPage - 1,
        position: position,
        pageSize: currentPageSize,
        watermarkSize: watermarkSize,
        watermarkText: state.text,
      );

      final List<int> outBytes = await document.save();
      await pdfFile.file.writeAsBytes(outBytes);
      document.dispose();

      emit(state.copyWith(isLoading: false, isSuccess: true));
      return pdfFile;
    } catch (error) {
      emit(state.copyWith(isLoading: false, errorMessage: error.toString()));
      return null;
    }
  }
}
