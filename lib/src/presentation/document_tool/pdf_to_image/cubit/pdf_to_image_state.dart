import 'dart:io';
import 'dart:typed_data';

enum PdfToImageStatus { initial, loading, success, failure }

enum ImageOption { separate, long }

class PdfToImageState {
  PdfToImageState({
    this.imagePdfs = const [],
    this.pdfFile,
    this.imageOption = ImageOption.separate,
    this.status = PdfToImageStatus.initial,
    this.errorMessage,
    this.password,
  });
  final List<Uint8List> imagePdfs;
  final ImageOption imageOption;
  final PdfToImageStatus status;
  final File? pdfFile;
  final String? errorMessage;
  final String? password;

  PdfToImageState copyWith(
      {List<Uint8List>? imagePdfs,
      File? pdfFile,
      ImageOption? imageOption,
      PdfToImageStatus? status,
      String? errorMessage,
      String? password}) {
    return PdfToImageState(
      imagePdfs: imagePdfs ?? this.imagePdfs,
      pdfFile: pdfFile ?? this.pdfFile,
      imageOption: imageOption ?? this.imageOption,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      password: password ?? this.password,
    );
  }
}
