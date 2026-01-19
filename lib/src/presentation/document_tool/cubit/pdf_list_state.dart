part of 'pdf_list_cubit.dart';

@freezed
class PdfListState with _$PdfListState {
  const factory PdfListState.initial() = InitialState;

  const factory PdfListState.loading() = LoadingState;

  const factory PdfListState.loaded(List<FileModel> data) = Loaded;

  const factory PdfListState.error(String message) = ErrorState;
}
