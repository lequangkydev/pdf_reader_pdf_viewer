import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vtn_flutter_pdfviewer/pdfviewer.dart';

class PdfSearchState {
  PdfSearchState({
    required this.searchResult,
    required this.pdfController,
    this.isSearching = false,
    this.hasText = false,
  });
  final PdfTextSearchResult searchResult;
  final PdfViewerController pdfController;
  final bool isSearching;
  final bool hasText;

  PdfSearchState copyWith({
    PdfTextSearchResult? searchResult,
    PdfViewerController? pdfController,
    bool? isSearching,
    bool? hasText,
  }) {
    return PdfSearchState(
      searchResult: searchResult ?? this.searchResult,
      pdfController: pdfController ?? this.pdfController,
      isSearching: isSearching ?? this.isSearching,
      hasText: hasText ?? this.hasText,
    );
  }
}

class PdfSearchCubit extends Cubit<PdfSearchState> {
  PdfSearchCubit(super.initialState);

  void search(String text) {
    if (text.isEmpty) {
      clear();
      return;
    }

    final result = state.pdfController.searchText(text);
    result.addListener(() {
      emit(state.copyWith(searchResult: result));
    });

    emit(state.copyWith(
      searchResult: result,
      isSearching: true,
      hasText: true,
    ));
  }

  void clear() {
    state.searchResult.clear();
    state.pdfController.clearSelection();
    emit(state.copyWith(searchResult: PdfTextSearchResult()));
  }

  void next() {
    state.pdfController.clearSelection();
    state.searchResult.nextInstance();
    emit(state.copyWith());
  }

  void previous() {
    state.searchResult.previousInstance();
    emit(state.copyWith());
  }
}
