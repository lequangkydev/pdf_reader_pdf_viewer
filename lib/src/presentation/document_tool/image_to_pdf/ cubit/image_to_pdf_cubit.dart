import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vtn_flutter_pdf/pdf.dart';

import '../../../../../module/file_system/file_path_manager.dart';

class ImagePickerCubit extends Cubit<List<File>> {
  ImagePickerCubit() : super([]);

  void addImage(File image) {
    final updated = List<File>.from(state)..add(image);
    emit(updated);
  }

  void addListImage(List<File> images) {
    final updated = List<File>.from(state)..addAll(images);
    emit(updated);
  }

  void removeImage(File image) {
    final updated = List<File>.from(state)..remove(image);
    emit(updated);
  }

  void reorderImages(int oldIndex, int newIndex) {
    final updated = List<File>.from(state);
    final file = updated.removeAt(oldIndex);
    updated.insert(newIndex, file);
    emit(updated);
  }

  void clear() {
    emit([]);
  }

  Future<File?> convertImagesToPdf(String nameFile) async {
    try {
      // Chuyển toàn bộ list path sang isolate (vì File không thể serialize)
      final imagePaths = state.map((f) => f.path).toList();

      final bytes = await compute(_generatePdfFromImages, imagePaths);

      final path = await FilePathManager.instance
          .saveBytesToDownloads(bytes, '$nameFile.pdf');
      final fileConvert = await File(path).writeAsBytes(bytes, flush: true);
      return fileConvert;
    } catch (error, stack) {
      debugPrint('convertImagesToPdf error: $error\n$stack');
      return null;
    }
  }
}

/// ✅ Hàm chạy trong isolate (không truy cập UI hay cubit)
Future<List<int>> _generatePdfFromImages(List<String> imagePaths) async {
  final document = PdfDocument();

  for (final path in imagePaths) {
    final file = File(path);
    final bytes = await file.readAsBytes();
    final pdfImage = PdfBitmap(bytes);
    final page = document.pages.add();

    final pageSize = page.getClientSize();
    final imageWidth = pdfImage.width.toDouble();
    final imageHeight = pdfImage.height.toDouble();

    final pageAspect = pageSize.width / pageSize.height;
    final imageAspect = imageWidth / imageHeight;

    double drawWidth;
    double drawHeight;

    if (imageAspect > pageAspect) {
      drawWidth = pageSize.width;
      drawHeight = pageSize.width / imageAspect;
    } else {
      drawHeight = pageSize.height;
      drawWidth = pageSize.height * imageAspect;
    }

    final offsetX = (pageSize.width - drawWidth) / 2;
    final offsetY = (pageSize.height - drawHeight) / 2;

    page.graphics.drawImage(
      pdfImage,
      Rect.fromLTWH(offsetX, offsetY, drawWidth, drawHeight),
    );
  }

  final result = await document.save();
  document.dispose();
  return result;
}
