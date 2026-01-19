import 'dart:io';

import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart' as p;

import '../../../data/local/shared_preferences_manager.dart';
import '../../../data/model/file_model.dart';

abstract class BaseFileCubit extends Cubit<List<FileModel>> {
  BaseFileCubit() : super([]);

  void addFile(FileModel fileModel) {
    final exists = state.any((f) => f.file.path == fileModel.file.path);
    if (!exists) {
      final updatedList = [...state, fileModel];
      emit(updatedList);
    }
  }

  FileModel? findFileByName(String filePath) {
    final targetName = p.basename(filePath);

    try {
      return state.firstWhereOrNull(
        (f) => p.basename(f.file.path) == targetName,
      );
    } catch (_) {
      return null;
    }
  }

  void updateFile(FileModel updatedFile) {
    final index = state.indexWhere(
        (f) => f.file.path == updatedFile.file.path || f.id == updatedFile.id);
    if (index == -1) {
      return;
    }
    final updatedList = List<FileModel>.from(state)..[index] = updatedFile;
    emit(updatedList);
  }

  /// Xoá 1 item theo model
  Future<void> deleteFile(FileModel model) async {
    final index = state.indexWhere((f) => f.file.path == model.file.path);
    if (index == -1) {
      return;
    }

    // Cập nhật bookmark trong SharedPreferences
    final bookmarkedPaths = SharedPreferencesManager.instance.getSaveList();
    if (bookmarkedPaths.remove(model.file.path)) {
      SharedPreferencesManager.instance.setSaveList(bookmarkedPaths);
    }
    final updatedList = List<FileModel>.from(state)..removeAt(index);
    emit(updatedList);
  }

  void checkAll() {
    final updatedList = state.map((fileModel) {
      return fileModel.copyWith(isSelect: true);
    }).toList();
    emit(updatedList);
  }

  void uncheckAll() {
    final updatedList = state.map((fileModel) {
      return fileModel.copyWith(isSelect: false);
    }).toList();
    emit(updatedList);
  }

  void toggleCheckAll() {
    final areAllSelected = state.every((fileModel) => fileModel.isSelect);
    if (areAllSelected) {
      uncheckAll();
    } else {
      checkAll();
    }
  }

  void toggleSelection(int index) {
    final updatedList = state.map((fileModel) {
      if (state.indexOf(fileModel) == index) {
        return fileModel.copyWith(isSelect: !fileModel.isSelect);
      }
      return fileModel;
    }).toList();
    emit(updatedList);
  }

  Future<void> toggleBookmark(File file) async {
    final index = state.indexWhere((f) => f.file.path == file.path);
    final bookmarkedPaths = SharedPreferencesManager.instance.getSaveList();
    // Không tìm thấy file
    if (index == -1) {
      return;
    }
    final currentFile = state[index];
    final updatedBookmark = !currentFile.isBookmark;

    // Update SharedPreferences
    if (updatedBookmark) {
      bookmarkedPaths.add(file.path);
    } else {
      bookmarkedPaths.remove(file.path);
    }
    SharedPreferencesManager.instance.setSaveList(bookmarkedPaths);

    final updatedList = List<FileModel>.from(state)
      ..[index] = currentFile.copyWith(isBookmark: updatedBookmark);

    emit(updatedList);
  }

  bool get isCheckAll {
    return state.isNotEmpty && state.every((fileModel) => fileModel.isSelect);
  }

  int get selectedFileCount {
    return state.where((fileModel) => fileModel.isSelect).length;
  }

  void resetSelection() {
    final updatedList = state.map((fileModel) {
      return fileModel.copyWith(isSelect: false);
    }).toList();
    emit(updatedList);
  }

  void clear() {
    emit([]);
  }
}
