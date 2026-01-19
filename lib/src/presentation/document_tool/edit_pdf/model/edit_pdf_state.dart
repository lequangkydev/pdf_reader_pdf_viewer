import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'edit_pdf_state.freezed.dart';
part 'edit_pdf_state.g.dart';

@freezed
abstract class EditPdfState with _$EditPdfState {
  const factory EditPdfState({
    @SizeConverter() Size? currentPageSize,
    @Default(1) int currentPage,
    @Default(PdfLoadStatus.initial) PdfLoadStatus status,
    String? errorMessage,
  }) = _EditPdfState;

  factory EditPdfState.fromJson(Map<String, Object?> json) =>
      _$EditPdfStateFromJson(json);
}

class SizeConverter implements JsonConverter<Size?, Map<String, dynamic>?> {
  const SizeConverter();

  @override
  Size? fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return null;
    }
    return Size(
      (json['width'] as num).toDouble(),
      (json['height'] as num).toDouble(),
    );
  }

  @override
  Map<String, dynamic>? toJson(Size? size) {
    if (size == null) return null;
    return {
      'width': size.width,
      'height': size.height,
    };
  }
}

enum PdfLoadStatus { initial, loading, success, failure }
