import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vtn_flutter_pdf/pdf.dart';

import '../model/brush_point.dart';
import 'brush_pdf_state.dart';

class BrushPdfCubit extends Cubit<BrushPdfState> {
  BrushPdfCubit() : super(const BrushPdfState());

  double screenWidth = 0;
  double displayHeight = 0;

  Future<void> getPageSize(
    String pdfPath,
    double screenWidthUpdate, [
    String? password,
  ]) async {
    screenWidth = screenWidthUpdate;
    final List<Size> pageSizes = [];
    final file = File(pdfPath);
    final bytes = await file.readAsBytes();
    final document = PdfDocument(inputBytes: bytes, password: password);

    for (int i = 0; i < document.pages.count; i++) {
      final pageSize = document.pages[i].size;
      pageSizes.add(Size(pageSize.width, pageSize.height));
    }

    document.dispose();

    final aspectRatio = pageSizes[0].height / pageSizes[0].width;
    final height = screenWidth * aspectRatio;
    displayHeight = height;

    emit(state.copyWith(pageSizes: pageSizes));
  }

  void updateFocusedIndex(int index) {
    emit(state.copyWith(focusedPage: index));
  }

  void saveBrushState() {
    emit(state.copyWith(
      undoStack: [...state.undoStack, List.from(state.brushPoints)],
      redoStack: [],
    ));
  }

  void brushPoint(int currentPage, Offset position, double displayHeight) {
    final List<BrushPoint> brushPoints =
        List<BrushPoint>.from(state.brushPoints);
    final index = brushPoints.indexWhere((p) => p.currentPage == currentPage);

    final pageSize = state.pageSizes[currentPage];
    final scaleX = pageSize.width / screenWidth;
    final scaleY = pageSize.height / displayHeight;

    final double clampedX = position.dx.clamp(0, screenWidth);
    final double clampedY =
        position.dy.clamp(0, displayHeight - (state.strokeWidth / 2));

    final pdfX = clampedX * scaleX;
    final pdfY = clampedY * scaleY;

    if (index != -1) {
      brushPoints[index] = brushPoints[index].copyWith(
        points: [
          ...brushPoints[index].points,
          BrushOffsetState(
            point: Offset(clampedX, clampedY),
            color: state.color,
            strokeWidth: state.strokeWidth,
          )
        ],
        pdfPoints: [...brushPoints[index].pdfPoints, Offset(pdfX, pdfY)],
      );
    } else {
      brushPoints.add(
        BrushPoint(
          points: [
            BrushOffsetState(
              point: Offset(clampedX, clampedY),
              color: state.color,
              strokeWidth: state.strokeWidth,
            )
          ],
          pdfPoints: [Offset(pdfX, pdfY)],
          currentPage: currentPage,
          id: DateTime.now().millisecondsSinceEpoch.toString(),
        ),
      );
    }

    emit(state.copyWith(brushPoints: brushPoints));
  }

  void undo() {
    if (state.undoStack.isNotEmpty) {
      final undoStack = List<List<BrushPoint>>.from(state.undoStack);
      final redoStack = List<List<BrushPoint>>.from(state.redoStack);

      final lastState = undoStack.removeLast();
      redoStack.add(List.from(state.brushPoints));

      emit(state.copyWith(
        brushPoints: List.from(lastState),
        undoStack: undoStack,
        redoStack: redoStack,
      ));
    }
  }

  void redo() {
    if (state.redoStack.isNotEmpty) {
      final redoStack = List<List<BrushPoint>>.from(state.redoStack);
      final undoStack = List<List<BrushPoint>>.from(state.undoStack);

      final lastState = redoStack.removeLast();
      undoStack.add(List.from(state.brushPoints));

      emit(state.copyWith(
        brushPoints: List.from(lastState),
        undoStack: undoStack,
        redoStack: redoStack,
      ));
    }
  }

  void onChangeColor(Color color) {
    emit(state.copyWith(color: color));
  }

  void onChangeStrokeWidth(double strokeWidth) {
    emit(state.copyWith(strokeWidth: strokeWidth));
  }

  Future<void> saveBrushToPdf(File pdfFile, String? password) async {
    final bytes = await pdfFile.readAsBytes();
    final pdfDocument = PdfDocument(inputBytes: bytes, password: password);

    for (final brushPoint in state.brushPoints) {
      final page = pdfDocument.pages[brushPoint.currentPage];
      final graphics = page.graphics;

      for (int i = 0; i < brushPoint.pdfPoints.length - 1; i++) {
        final pointColor = brushPoint.points[i].color;
        final pointStrokeWidth = brushPoint.points[i].strokeWidth;

        final pen = PdfPen(
          PdfColor(
            pointColor.red,
            pointColor.green,
            pointColor.blue,
            (pointColor.opacity * 255).toInt(),
          ),
          width: pointStrokeWidth,
        );
        if (brushPoint.pdfPoints[i] != Offset.zero &&
            brushPoint.pdfPoints[i + 1] != Offset.zero) {
          graphics.drawLine(
            pen,
            Offset(brushPoint.pdfPoints[i].dx, brushPoint.pdfPoints[i].dy),
            Offset(
                brushPoint.pdfPoints[i + 1].dx, brushPoint.pdfPoints[i + 1].dy),
          );
        }
      }
    }

    final modifiedPdfBytes = await pdfDocument.save();
    await pdfFile.writeAsBytes(modifiedPdfBytes);
    pdfDocument.dispose();
  }
}
