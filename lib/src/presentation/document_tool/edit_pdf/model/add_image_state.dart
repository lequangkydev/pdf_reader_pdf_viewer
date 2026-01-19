import 'dart:io';

import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'base_action_pdf_state.dart';

part 'add_image_state.freezed.dart';

@freezed
class AddImageState with _$AddImageState implements BaseActionPDFState {
  const factory AddImageState({
    File? image,
    @Default(Size(100, 100)) Size size,
    @Default(false) bool isLoading,
    String? errorMessage,
    @Default(false) bool isSuccess,
    @Default(false) bool isSignature,
  }) = _AddImageState;
}
