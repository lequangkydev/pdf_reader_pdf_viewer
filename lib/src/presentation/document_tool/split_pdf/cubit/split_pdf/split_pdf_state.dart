part of 'split_pdf_cubit.dart';

@freezed
class SplitPdfState with _$SplitPdfState {
  const factory SplitPdfState.initial() = SplitPdfInitial;

  const factory SplitPdfState.loading() = SplitPdfLoading;

  const factory SplitPdfState.success({
    required File splitFile,
  }) = SplitPdfSuccess;

  const factory SplitPdfState.error({
    required String message,
  }) = SplitPdfError;
}
