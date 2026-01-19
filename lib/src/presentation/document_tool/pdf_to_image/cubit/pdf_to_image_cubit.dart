import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../split_pdf/cubit/pdf_grid/pdf_grid_state.dart';
import 'pdf_to_image_state.dart';

class PdfToImageCubit extends Cubit<PdfToImageState> {
  PdfToImageCubit() : super(PdfToImageState());

  void convert({
    required String fileName,
    required List<PageModel> pages,
    bool convertAll = false,
  }) {}

  Future<Uint8List?> convertPdfToLongImage({
    required String fileName,
    required List<PageModel> pages,
    bool convertAll = false,
  }) async {
    // Lấy danh sách các trang được chọn
    final selectedPages =
        convertAll ? pages : pages.where((p) => p.isSelected).toList();
    if (selectedPages.isEmpty) {
      return null;
    }
    try {
      // 1️⃣ Đọc tất cả file ảnh tạm từ các trang được chọn
      final List<Uint8List> imageBytesList = [];
      for (final page in selectedPages) {
        final bytes = await File(page.filePath).readAsBytes();
        imageBytesList.add(bytes);
      }
      // 2️⃣ Decode từng ảnh thành ui.Image
      final List<ui.Image> images = [];
      for (final bytes in imageBytesList) {
        final ui.Image image = await decodeImageFromList(bytes);
        images.add(image);
      }
      // 3️⃣ Merge tất cả ảnh thành 1 long image (chiều dọc)
      final ui.Image longImage = await mergeImages(images);

      // 4️⃣ Convert long image → bytes PNG
      final ByteData? pngBytes =
          await longImage.toByteData(format: ui.ImageByteFormat.png);

      if (pngBytes == null) {
        return null;
      }
      final Uint8List longImageBytes = pngBytes.buffer.asUint8List();
      return longImageBytes;
    } catch (error) {
      emit(state.copyWith(errorMessage: error.toString()));
    }
    return null;
  }

  Future<ui.Image> mergeImages(List<ui.Image> images) async {
    // Tính tổng chiều cao của tất cả các hình ảnh
    final int totalHeight = images.fold(0, (sum, img) => sum + img.height);
    // Tìm chiều rộng lớn nhất trong danh sách hình ảnh
    final int maxWidth =
        images.fold(0, (max, img) => img.width > max ? img.width : max);

    // Tạo một PictureRecorder để ghi hình
    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder,
        Rect.fromLTWH(0, 0, maxWidth.toDouble(), totalHeight.toDouble()));

    int currentY = 0;
    for (final image in images) {
      // Tính toán tỷ lệ để giữ nguyên kích thước hình ảnh
      double scaleFactor = maxWidth / image.width;
      int newHeight = (image.height * scaleFactor).toInt();
      // Vẽ hình ảnh với chiều cao đã tính toán
      canvas.drawImageRect(
        image,
        Rect.fromLTWH(0, 0, image.width.toDouble(),
            image.height.toDouble()), // Vùng vẽ hình ảnh gốc
        Rect.fromLTWH(0, currentY.toDouble(), maxWidth.toDouble(),
            newHeight.toDouble()), // Vùng vẽ trên canvas
        Paint(),
      );

      currentY += image.height;
    }

    final picture = recorder.endRecording();
    return picture.toImage(maxWidth, totalHeight);
  }

  Future<List<Uint8List>?> convertToSeparateImages({
    required String fileName,
    bool convertAll = false,
    required List<PageModel> pages,
  }) async {
    // Lấy danh sách trang được chọn
    final selectedPages =
        convertAll ? pages : pages.where((p) => p.isSelected).toList();
    if (selectedPages.isEmpty) {
      return null;
    }
    try {
      // Đọc toàn bộ file ảnh tạm (đã có sẵn trong PageModel)
      final List<Uint8List> result = [];
      for (final page in selectedPages) {
        final bytes = await File(page.filePath).readAsBytes();
        result.add(bytes);
      }

      return result;
    } catch (e) {
      debugPrint('❌ convertToSeparateImages error: $e');
      emit(state.copyWith(errorMessage: e.toString()));
      return null;
    }
  }
}
