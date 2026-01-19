import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'base_action_pdf_state.dart';

part 'add_watermark_state.freezed.dart';

@freezed
class AddWatermarkState with _$AddWatermarkState implements BaseActionPDFState {
  const factory AddWatermarkState({
    @Default('') String text,
    @Default(Colors.black) Color colorText,
    @Default(24) double fontSize,
    @Default(-0.7) double rotation,
    @Default(false) bool isLoading,
    @Default(false) bool isSuccess,
    String? errorMessage,
  }) = _AddWatermarkState;
}
