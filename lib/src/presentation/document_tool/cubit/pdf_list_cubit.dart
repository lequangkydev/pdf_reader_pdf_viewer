import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../config/di/di.dart';
import '../../../data/model/file_model.dart';
import '../../all_documents/cubit/pdf_cubit.dart';

part 'pdf_list_cubit.freezed.dart';
part 'pdf_list_state.dart';

class PdfListCubit extends Cubit<PdfListState> {
  PdfListCubit() : super(const PdfListState.initial());

  List<FileModel> _allPdfs = [];

  Future<void> fetchPdf(
      {bool all = true, bool unProtectedPdfs = true, File? file}) async {
    emit(const PdfListState.loading());
    await Future.delayed(const Duration(milliseconds: 150));
    final List<FileModel> allPdfs = getIt<PdfCubit>().state;
    if (all) {
      final resultList = List<FileModel>.from(allPdfs);
      emit(PdfListState.loaded(allPdfs));
      if (file != null) {
        final idx = resultList.indexWhere((e) => e.file.path == file.path);
        if (idx != -1) {
          final picked = resultList.removeAt(idx);
          resultList.insert(0, picked);
        }
      }

      _allPdfs = resultList;
      emit(PdfListState.loaded(resultList));
      return;
    }

    // Kiểm tra bảo vệ cho từng PDF
    final pdfProtectionResults =
        await Future.wait(allPdfs.map((pdfFileModel) async {
      return pdfFileModel.isLock ? pdfFileModel : null;
    }));

    // Tạo danh sách PDF không được bảo vệ và được bảo vệ
    final protectedPdfs = pdfProtectionResults.whereType<FileModel>().toList();
    final unprotectedPdfs = allPdfs
        .where((pdfFileModel) => !protectedPdfs.contains(pdfFileModel))
        .toList();

    List<FileModel> resultList;
    if (unProtectedPdfs) {
      resultList = List<FileModel>.from(unprotectedPdfs);
    } else {
      resultList = List<FileModel>.from(protectedPdfs);
    }

    // Nếu có truyền file thì đưa nó lên đầu nếu tồn tại
    if (file != null) {
      final idx = resultList.indexWhere((e) => e.file.path == file.path);
      if (idx != -1) {
        final picked = resultList.removeAt(idx);
        resultList.insert(0, picked);
      }
    }

    _allPdfs = resultList;
    emit(PdfListState.loaded(resultList));
  }

  void searchPdf({required String query, bool isDone = false}) {
    if (query.isEmpty) {
      emit(PdfListState.loaded(_allPdfs));
    } else {
      final filteredList = _allPdfs.where((fileModel) {
        return fileModel.file.path.toLowerCase().contains(query.toLowerCase());
      }).toList();
      emit(
        PdfListState.loaded(
            isDone && filteredList.isEmpty ? _allPdfs : filteredList),
      );
    }
  }
}
