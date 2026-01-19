import 'dart:async';
import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;
import 'package:uuid/uuid.dart';
import 'package:vtn_flutter_pdf/pdf.dart';

import '../../../module/admob/utils/inter_file_back_tab_util.dart';
import '../../../module/admob/utils/utils.dart';
import '../../../module/file_system/enum/file_system_type.dart';
import '../../config/navigation/app_router.dart';
import '../../data/model/file_model.dart';
import '../enum/app_enum.dart';

class FileUtils {
  FileUtils._();

  static Future<void> openFileRoute(
    BuildContext context,
    FileModel file,
    TabBarType type,
    bool showAds, [
    bool isImage = false,
  ]) async {
    if (showAds) {
      await InterFileBackTabUtil.instance.show(
        enable: InterFileBackTabUtil.instance.config.interViewFile,
        nativeFullConfig: adUnitsConfig.nativeFullInterViewFile,
      );
    }
    if (!context.mounted) {
      return;
    }
    if (isImage) {
      if (showAds) {
        context.pushRoute(ViewImageRoute(fileModel: file));
        return;
      }
      context.replaceRoute(
        ViewImageRoute(
          fileModel: file,
          fromReload: true,
        ),
      );
      return;
    }

    if (context.mounted) {
      switch (type) {
        case TabBarType.ppt:
        case TabBarType.excel:
        case TabBarType.word:
          if (Platform.isIOS) {
            context.pushRoute(IOSFileReaderRoute(
                fileModel: file, type: type, file: file.file));
          } else {
            if (showAds) {
              context.pushRoute(
                  ViewFileRoute(fileModel: file, type: type, file: file.file));
            } else {
              context.replaceRoute(
                ViewFileRoute(
                  fileModel: file,
                  type: type,
                  file: file.file,
                  fromReload: true,
                ),
              );
            }
          }
        case TabBarType.pdf:
          if (showAds) {
            context.pushRoute(ViewPdfRoute(pdfFile: file));
          } else {
            context.replaceRoute(
              ViewPdfRoute(pdfFile: file, fromReload: true),
            );
          }
        case TabBarType.all:
          return;
      }
    }
  }

  static Future<bool> isPdfPassword(String filePath) async {
    try {
      final List<int> bytes = await File(filePath).readAsBytes();
      final PdfDocument document = PdfDocument(inputBytes: bytes);
      return document.security.userPassword.isNotEmpty ||
          document.security.ownerPassword.isNotEmpty;
    } catch (e) {
      return true;
    }
  }
}

void openFile(String filePath, BuildContext context) {
  final file = File(filePath);
  if (!file.existsSync()) {
    context.replaceRoute(const ShellRoute());
    return;
  }
  final fileExtension = path.extension(file.path).toLowerCase();
  if (fileExtension == '.pdf') {
    context.replaceRoute(ViewPdfRoute(
        pdfFile: FileModel(id: const Uuid().v1(), file: file),
        fromReload: true));
    return;
  }
  if (imagesExtension.contains(fileExtension)) {
    context.replaceRoute(
      ViewImageRoute(
        fileModel: FileModel(file: file, id: ''),
      ),
    );
    return;
  }
  if (isSupportFile(fileExtension)) {
    context.replaceRoute(
      ViewFileRoute(
        file: file,
        fileModel: FileModel(file: file, id: ''),
        type: TabBarType.ppt,
        fromReload: true,
      ),
    );
    return;
  }
  if (!isSupportFile(fileExtension)) {
    context.replaceRoute(const ShellRoute());
  }
}
