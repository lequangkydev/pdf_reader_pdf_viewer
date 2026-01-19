import 'dart:io';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vtn_flutter_pdf/pdf.dart';

import '../../../../../module/file_system/file_path_manager.dart';
import '../../../../shared/utils/toast_util.dart';
import 'merge_pdf_state.dart';

Future<String?> _mergePdfWorker(Map<String, dynamic> args) async {
  final List<PdfFileWithPassword> files =
      (args['files'] as List).cast<PdfFileWithPassword>();
  final String? fileName = args['fileName'] as String?;

  final PdfDocument newDocument = PdfDocument();
  PdfSection? section;

  for (final file in files) {
    final PdfDocument loadedDocument = PdfDocument(
      inputBytes: file.file.readAsBytesSync(),
      password: file.password,
    );

    for (int index = 0; index < loadedDocument.pages.count; index++) {
      final PdfTemplate template = loadedDocument.pages[index].createTemplate();
      if (section == null || section.pageSettings.size != template.size) {
        section = newDocument.sections!.add();
        section.pageSettings.size = template.size;
        section.pageSettings.margins.all = 0;
      }
      section.pages.add().graphics.drawPdfTemplate(template, Offset.zero);
    }
    loadedDocument.dispose();
  }

  final List<int> bytes = await newDocument.save();
  newDocument.dispose();

  final path = await FilePathManager.instance.saveBytesToDownloads(
    bytes,
    "${fileName ?? "merged_pdf_${DateTime.now().millisecondsSinceEpoch}"}.pdf",
  );

  final fileMerge = await File(path).writeAsBytes(bytes, flush: true);
  return fileMerge.path;
}

class MergePdfCubit extends Cubit<MergePdfState> {
  MergePdfCubit() : super(MergePdfState());

  bool isProtectPdf({required File file, String? password}) {
    try {
      final List<int> bytes = file.readAsBytesSync();
      PdfDocument(inputBytes: bytes, password: password);
      return false;
    } catch (e) {
      if (e is ArgumentError && e.message.contains('password')) {
        return true;
      }
      ToastUtil.showMess(mess: e.toString());
      rethrow;
    }
  }

  void toggleMerge() {
    emit(state.copyWith(isMerging: !state.isMerging));
  }

  PdfFileWithPassword? isExistFile(File file) {
    PdfFileWithPassword? existingFileWithPassword;
    try {
      existingFileWithPassword = state.selectedFiles.firstWhere(
        (pdfFileWithPassword) => pdfFileWithPassword.file.path == file.path,
      );
    } catch (e) {
      existingFileWithPassword = null;
    }
    return existingFileWithPassword;
  }

  void removeFile(File file) {
    if (isExistFile(file) != null) {
      final updatedSelectedFiles =
          List<PdfFileWithPassword>.from(state.selectedFiles);
      updatedSelectedFiles.remove(isExistFile(file));
      emit(state.copyWith(selectedFiles: updatedSelectedFiles));
    }
  }

  void toggleSelection({File? file, String? password, bool isFirst = false}) {
    if (file == null) {
      return;
    }
    final updatedSelectedFiles =
        List<PdfFileWithPassword>.from(state.selectedFiles);
    final existFile = isExistFile(file);
    if (existFile != null) {
      updatedSelectedFiles.remove(existFile);
    } else {
      final newFile = PdfFileWithPassword(file: file, password: password);

      if (isFirst) {
        // Thêm file mới vào đầu danh sách
        updatedSelectedFiles.insert(0, newFile);
      } else {
        // Thêm vào cuối danh sách như bình thường
        updatedSelectedFiles.add(newFile);
      }
    }
    emit(state.copyWith(selectedFiles: updatedSelectedFiles));
  }

  void reorderFiles(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    final selectedItem = state.selectedFiles.removeAt(oldIndex);
    state.selectedFiles.insert(newIndex, selectedItem);
    emit(state.copyWith(selectedFiles: List.from(state.selectedFiles)));
  }

  Future<File?> mergePDF(String? fileName) async {
    if (state.selectedFiles.isEmpty) {
      return null;
    }
    try {
      final resultPath = await compute<Map<String, dynamic>, String?>(
        _mergePdfWorker,
        {
          'files': state.selectedFiles,
          'fileName': fileName,
        },
      );

      if (resultPath == null) {
        return null;
      }
      return File(resultPath);
    } catch (e) {
      throw Exception('Error merge PDF:$e');
    }
  }
}
