import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/edit_pdf_state.dart';

class EditPdfCubit extends Cubit<EditPdfState> {
  EditPdfCubit() : super(const EditPdfState());

  void setLoading() {
    emit(state.copyWith(status: PdfLoadStatus.loading));
  }

  void setSuccess() {
    emit(state.copyWith(status: PdfLoadStatus.success));
  }

  void setFailure(String error) {
    emit(state.copyWith(status: PdfLoadStatus.failure, errorMessage: error));
  }

  void updatePage(int page) {
    emit(state.copyWith(currentPage: page));
  }

  void updatePageSize(Size pageSize) {
    emit(state.copyWith(currentPageSize: pageSize));
  }
}
