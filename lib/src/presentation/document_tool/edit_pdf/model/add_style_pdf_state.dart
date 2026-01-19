import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'base_action_pdf_state.dart';

part 'add_style_pdf_state.freezed.dart';

@freezed
class AddStylePdfState with _$AddStylePdfState implements BaseActionPDFState {
  const factory AddStylePdfState({
    @Default(Colors.black) Color colorStyle,
    @Default(false) bool isLoading,
    @Default(false) bool isSuccess,
    @Default(false) bool hasChangeAnnotation,
    String? errorMessage,
  }) = _AddStylePdfState;
}
