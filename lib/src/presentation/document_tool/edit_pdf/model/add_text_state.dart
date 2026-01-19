import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'base_action_pdf_state.dart';

part 'add_text_state.freezed.dart';

@freezed
class AddTextState with _$AddTextState implements BaseActionPDFState {
  const factory AddTextState({
    @Default('') String text,
    @Default(Colors.black) Color colorText,
    @Default(24) double fontSize,
    @Default(false) bool isLoading,
    @Default(false) bool isSuccess,
    String? errorMessage,
  }) = _AddTextState;
}
