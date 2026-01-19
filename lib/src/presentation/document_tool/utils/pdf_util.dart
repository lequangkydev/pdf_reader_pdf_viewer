import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart' as pdf;
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:vtn_flutter_pdf/pdf.dart';

class PdfUtil {
  PdfUtil._();

  static Future<bool> isPdfProtected(File filePdf) async {
    try {
      final List<int> bytes = await filePdf.readAsBytes();
      PdfDocument(inputBytes: bytes);
      return false;
    } catch (e) {
      if (e is ArgumentError && e.message.contains('password')) {
        return true;
      }
      rethrow;
    }
  }

  static Future<File?> _updatePdfPassword({
    required File file,
    String? currentPassword,
    required String newPassword,
  }) async {
    try {
      final PdfDocument document = PdfDocument(
        inputBytes: file.readAsBytesSync(),
        password: currentPassword,
      );
      final PdfSecurity security = document.security;
      security.userPassword = newPassword;
      await file.writeAsBytes(await document.save());
      document.dispose();
      return file;
    } catch (e) {
      debugPrint('Error updating PDF password: $e');
      return null;
    }
  }

  static Future<File?> removePasswordPdf({
    required File file,
    required String password,
  }) async {
    return _updatePdfPassword(
      file: file,
      currentPassword: password,
      newPassword: '',
    );
  }

  static Future<File?> setPasswordPdf({
    required File file,
    required String password,
  }) async {
    return _updatePdfPassword(
      file: file,
      newPassword: password,
    );
  }

  static Future<List<Uint8List>?> convertPdfToImages({
    required File pdfFile,
    String? password,
  }) async {
    try {
      final PdfDocument document = PdfDocument(
        inputBytes: pdfFile.readAsBytesSync(),
        password: password,
      );
      final PdfSecurity security = document.security;
      security.userPassword = '';
      document.security.userPassword = '';
      final List<Uint8List> bytePages = [];

      final data = document.saveSync();
      await for (final page in Printing.raster(
        Uint8List.fromList(data),
        dpi: 100,
      )) {
        final imgBytes = await page.toPng();
        bytePages.add(imgBytes);
      }
      document.security.userPassword = password ?? '';
      document.saveSync();
      return bytePages;
    } catch (e) {
      return null;
    }
  }

  static Future<List<Uint8List>?> convertPdfToImagesWithIndex({
    required File pdfFile,
    String? password,
    required List<int> index,
  }) async {
    try {
      final PdfDocument document = PdfDocument(
        inputBytes: pdfFile.readAsBytesSync(),
        password: password,
      );
      final PdfSecurity security = document.security;
      security.userPassword = '';
      document.security.userPassword = '';
      final List<Uint8List> bytePages = [];

      final data = document.saveSync();
      int i = 0;
      await for (final page in Printing.raster(
        Uint8List.fromList(data),
        dpi: 100,
      )) {
        if (index.contains(i)) {
          final imgBytes = await page.toPng();
          bytePages.add(imgBytes);
        }
        i++;
      }
      document.security.userPassword = password ?? '';
      document.saveSync();
      return bytePages;
    } catch (e) {
      return null;
    }
  }

  //tạo mới 1 pdf từ file lock pdf
  static Future<Uint8List> lockPdfToUint8List(
      {required File file, required String password}) async {
    PdfSection? section;
    final PdfDocument newDocument = PdfDocument();
    final PdfDocument lockPdfDocument =
        PdfDocument(inputBytes: file.readAsBytesSync(), password: password);

    for (int index = 0; index < lockPdfDocument.pages.count; index++) {
      final PdfTemplate template =
          lockPdfDocument.pages[index].createTemplate();
      if (section == null || section.pageSettings.size != template.size) {
        section = newDocument.sections!.add();
        section.pageSettings.size = template.size;
        section.pageSettings.margins.all = 0;
      }
      section.pages.add().graphics.drawPdfTemplate(template, Offset.zero);
    }
    lockPdfDocument.dispose();
    final List<int> bytes = await newDocument.save();
    newDocument.dispose();
    return Uint8List.fromList(bytes);
  }

  static Future<void> printImage(File imageFile) async {
    try {
      final Uint8List imageBytes = await imageFile.readAsBytes();
      await Printing.layoutPdf(onLayout: (pdf.PdfPageFormat format) async {
        final pdf = pw.Document();
        final image = pw.MemoryImage(imageBytes);
        pdf.addPage(
          pw.Page(build: (pw.Context context) {
            return pw.Center(child: pw.Image(image));
          }),
        );
        return pdf.save();
      });
    } catch (e) {
      debugPrint('Error printing image: $e');
    }
  }

  static Future<void> printTxt(File txtFile) async {
    try {
      final String textContent = await txtFile.readAsString(encoding: utf8);
      await Printing.layoutPdf(onLayout: (pdf.PdfPageFormat format) async {
        final pdf = pw.Document();

        pdf.addPage(
          pw.Page(
            build: (pw.Context context) {
              return pw.Center(
                child: pw.Text(
                  textContent,
                  style: pw.TextStyle(fontSize: 12),
                ),
              );
            },
          ),
        );

        return pdf.save();
      });
    } catch (e) {
      debugPrint('Error printing TXT file: $e');
    }
  }

  static Future<void> printToPdf({required File file, String? password}) async {
    final isProtect = await isPdfProtected(file);
    if (isProtect && password != null) {
      final data = await lockPdfToUint8List(file: file, password: password);
      await Printing.layoutPdf(
        onLayout: (format) async {
          return data;
        },
      );
      return;
    }
    await Printing.layoutPdf(
      onLayout: (format) async {
        return file.readAsBytes();
      },
    );
    return;
  }
}

Future<File> _createTempPdfFile(List<int> data) async {
  final tempDir = await getTemporaryDirectory();
  final tempFile =
      File('${tempDir.path}/temp_${DateTime.now().millisecondsSinceEpoch}.pdf');
  return await tempFile.writeAsBytes(data, flush: true);
}
