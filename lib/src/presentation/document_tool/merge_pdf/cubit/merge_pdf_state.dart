import 'dart:io';

class MergePdfState {
  MergePdfState({
    this.isMerging = false,
    this.selectedFiles = const [],
  });

  bool isMerging;
  List<PdfFileWithPassword> selectedFiles;

  MergePdfState copyWith({
    bool? isMerging,
    List<PdfFileWithPassword>? selectedFiles,
  }) {
    return MergePdfState(
      isMerging: isMerging ?? this.isMerging,
      selectedFiles: selectedFiles ?? this.selectedFiles,
    );
  }
}

class PdfFileWithPassword {
  PdfFileWithPassword({required this.file, this.password});
  final File file;
  final String? password;
}
