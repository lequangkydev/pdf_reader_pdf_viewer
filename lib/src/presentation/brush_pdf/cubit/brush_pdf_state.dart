import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../shared/constants/app_colors.dart';
import '../model/brush_point.dart';

part 'brush_pdf_state.freezed.dart';

@freezed
class BrushPdfState with _$BrushPdfState {
  const factory BrushPdfState({
    @Default([]) List<BrushPoint> brushPoints,
    @Default([]) List<Size> pageSizes,
    @Default(0) int focusedPage,
    @Default(5) double strokeWidth,
    @Default(AppColors.pr) Color color,
    @Default([]) List<List<BrushPoint>> undoStack,
    @Default([]) List<List<BrushPoint>> redoStack,
  }) = _BrushPdfState;
}
