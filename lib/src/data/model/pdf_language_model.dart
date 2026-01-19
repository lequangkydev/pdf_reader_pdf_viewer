import 'package:freezed_annotation/freezed_annotation.dart';

part 'pdf_language_model.freezed.dart';
part 'pdf_language_model.g.dart';

@freezed
class PdfLanguageResponse with _$PdfLanguageResponse {
  const factory PdfLanguageResponse({
    required Status status,
    required List<PdfLanguage> data,
  }) = _PdfLanguageResponse;

  factory PdfLanguageResponse.fromJson(Map<String, dynamic> json) =>
      _$PdfLanguageResponseFromJson(json);
}

@freezed
class Status with _$Status {
  const factory Status({
    required String code,
    required String message,
    required String label,
    String? requestId,
  }) = _Status;

  factory Status.fromJson(Map<String, dynamic> json) => _$StatusFromJson(json);
}

@freezed
class PdfLanguage with _$PdfLanguage {
  const factory PdfLanguage({
    required String code,
    required String name,
    String? flagUrl,
    String? app,
  }) = _PdfLanguage;

  factory PdfLanguage.fromJson(Map<String, dynamic> json) =>
      _$PdfLanguageFromJson(json);
}
