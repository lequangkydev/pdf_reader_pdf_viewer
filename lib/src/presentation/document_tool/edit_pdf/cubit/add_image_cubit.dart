import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vtn_flutter_pdf/pdf.dart';

import '../../../../data/model/file_model.dart';
import '../model/add_image_state.dart';

class AddImageCubit extends Cubit<AddImageState> {
  AddImageCubit() : super(const AddImageState());

  void initReset() {
    emit(const AddImageState());
  }

  void changeImage(File image) {
    emit(state.copyWith(image: image));
  }

  void changeSignature(bool value) {
    emit(state.copyWith(isSignature: value));
  }

  void onResize(Size newSize) {
    emit(state.copyWith(size: newSize));
  }

  Future<void> _saveImageToPdf({
    required PdfDocument document,
    required int pageIndex,
    required Size pageSize,
    required Offset position,
    required Size widgetImageSize,
    required File imageFile,
  }) async {
    final PdfPage pdfPage = document.pages[pageIndex];
    final Size pdfSize = Size(
      pdfPage.getClientSize().width,
      pdfPage.getClientSize().height,
    );

    // scale factor
    final double factor = pdfSize.width / pageSize.width;

    // toạ độ & kích thước trong PDF
    final double pdfX = (position.dx + 18) * factor;
    final double pdfY = (position.dy + 18) * factor;
    final double pdfW = widgetImageSize.width * factor;
    final double pdfH = widgetImageSize.height * factor;

    final PdfBitmap image = PdfBitmap(imageFile.readAsBytesSync());

    pdfPage.graphics.drawImage(
      image,
      Rect.fromLTWH(pdfX, pdfY, pdfW, pdfH),
    );
  }

  Future<FileModel?> onSavePressed({
    required FileModel pdfFile,
    required int currentPage,
    required Offset position,
    Size? currentPageSize,
    String? password,
  }) async {
    if (currentPageSize == null || state.image == null) {
      emit(state.copyWith(
          isLoading: false, errorMessage: 'Không có kích thước page'));
      return null;
    }
    emit(state.copyWith(isLoading: true, isSuccess: false, errorMessage: null));
    try {
      final document = PdfDocument(
        inputBytes: pdfFile.file.readAsBytesSync(),
        password: password,
      );

      final Size widgetImageSize = state.size;

      await _saveImageToPdf(
        document: document,
        pageIndex: currentPage - 1,
        pageSize: currentPageSize,
        position: position,
        widgetImageSize: widgetImageSize,
        imageFile: state.image!,
      );

      final outBytes = await document.save();
      await pdfFile.file.writeAsBytes(outBytes);
      document.dispose();
      emit(state.copyWith(isLoading: false, isSuccess: true));
      return pdfFile;
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
      return null;
    }
  }
}
