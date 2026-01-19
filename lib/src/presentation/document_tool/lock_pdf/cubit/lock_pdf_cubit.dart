import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:vtn_flutter_pdf/pdf.dart';

import '../../../../data/model/file_model.dart';
import '../../../../shared/cubit/value_cubit.dart';

Future<FileModel?> _setPasswordWorker(Map<String, dynamic> args) async {
  final file = File(args['path']);
  final password = args['password'] as String;

  final PdfDocument document = PdfDocument(
    inputBytes: await file.readAsBytes(),
  );
  final PdfSecurity security = document.security;
  security.userPassword = password;

  await file.writeAsBytes(await document.save());
  document.dispose();

  return (args['fileModel'] as FileModel).copyWith(isLock: true);
}

class LockPdfCubit extends ValueCubit<FileModel?> {
  LockPdfCubit() : super(null);

  Future<FileModel?> setPasswordPdf(String password) async {
    if (state == null) {
      return null;
    }
    try {
      return await compute(
        _setPasswordWorker,
        {'path': state!.file.path, 'password': password, 'fileModel': state!},
      );
    } catch (e) {
      throw Exception(e);
    }
  }
}
