import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vtn_flutter_pdf/pdf.dart';

import '../../../../data/model/file_model.dart';
import '../edit_pdf_screen.dart';
import '../model/add_text_state.dart';

class AddTextCubit extends Cubit<AddTextState> {
  AddTextCubit() : super(const AddTextState());

  void initReset() {
    emit(const AddTextState());
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

  Future<void> _saveTextToPdf({
    required PdfDocument document,
    required int pageIndex,
    required Size pageSize,
    required Offset textPosition,
    required Size textSize,
  }) async {
    final PdfPage pdfPage = document.pages[pageIndex];
    final Size pdfSize = Size(
      pdfPage.getClientSize().width,
      pdfPage.getClientSize().height,
    );

    // scale factor từ kích thước hiển thị sang PDF thật
    final double factor = pdfSize.width / pageSize.width;

    // +18 của padding & margin text box trên pdf
    // tọa độ trên PDF
    final double pdfX = (textPosition.dx + 18) * factor;
    final double pdfY = (textPosition.dy + 18) * factor;
    final double pdfW = textSize.width * factor;
    final double pdfH = textSize.height * factor;

    final PdfFont font = PdfStandardFont(
      PdfFontFamily.helvetica,
      state.fontSize * factor,
    );

    pdfPage.graphics.drawString(
      state.text,
      font,
      brush: PdfSolidBrush(
        PdfColor(
          (state.colorText.r * 255).round() & 0xff,
          (state.colorText.g * 255).round() & 0xff,
          (state.colorText.b * 255).round() & 0xff,
        ),
      ),
      bounds: Rect.fromLTWH(pdfX, pdfY, pdfW, pdfH),
    );
  }

  Future<FileModel?> onSavePressed({
    required FileModel pdfFile,
    Size? currentPageSize,
    required int currentPage,
    String? password,
    required Offset position,
  }) async {
    if (state.text.isEmpty || currentPageSize == null) {
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
      final RenderBox? textBox =
          positionToolKey.currentContext?.findRenderObject() as RenderBox?;
      final Size textSize = textBox?.size ?? const Size(100, 30);

      await _saveTextToPdf(
        document: document,
        pageIndex: currentPage - 1,
        pageSize: currentPageSize,
        textPosition: position,
        textSize: textSize,
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
