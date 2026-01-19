import '../../gen/assets.gen.dart';
import '../../shared/utils/localization_util.dart';

class DocumentToolModel {
  DocumentToolModel({required this.iconPath, required this.title});

  String iconPath;
  String title;
}

enum DocumentToolItem {
  merge,
  split,
  imageToPdf,
  lock,
  unlock,
  scan,
  toImage,
  toLongImage,
}

extension DocumentToolItemExt on DocumentToolItem {
  String get name {
    return switch (this) {
      DocumentToolItem.imageToPdf => L10n.tr.imageToPdf,
      DocumentToolItem.merge => L10n.tr.mergePDF,
      DocumentToolItem.split => L10n.tr.splitPDF,
      DocumentToolItem.unlock => L10n.tr.unlockPDF,
      DocumentToolItem.lock => L10n.tr.lockPDF,
      DocumentToolItem.scan => L10n.tr.scanPDF,
      DocumentToolItem.toImage => L10n.tr.pdfToImages,
      DocumentToolItem.toLongImage => L10n.tr.pdfToLongImages,
    };
  }

  String get pathImage {
    return switch (this) {
      DocumentToolItem.imageToPdf => Assets.icons.tools.imageToPdf.path,
      DocumentToolItem.merge => Assets.icons.tools.mergePdf.path,
      DocumentToolItem.split => Assets.icons.tools.splitPdf.path,
      DocumentToolItem.unlock => Assets.icons.tools.unlockPdf.path,
      DocumentToolItem.lock => Assets.icons.tools.lockPdf.path,
      DocumentToolItem.scan => Assets.icons.tools.scanPdf.path,
      DocumentToolItem.toImage => Assets.icons.tools.pdfToImage.path,
      DocumentToolItem.toLongImage => Assets.icons.tools.pdfToLongImage.path,
    };
  }
}

extension DocumentToolList on DocumentToolItem {
  List<DocumentToolModel> get data {
    List<DocumentToolModel> dataList = [];
    dataList = DocumentToolItem.values
        .map((item) => DocumentToolModel(
              title: item.name,
              iconPath: item.pathImage,
            ))
        .toList();
    return dataList;
  }
}
