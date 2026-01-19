import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;

import '../../../gen/assets.gen.dart';
import '../../../shared/utils/date_time_util.dart';

class PdfItem extends StatelessWidget {
  const PdfItem({
    super.key,
    required this.pdfFile,
    this.leading,
    this.trailing,
    this.isLock = false,
  });

  final File pdfFile;
  final Widget? leading;
  final Widget? trailing;
  final bool isLock;

  @override
  Widget build(BuildContext context) {
    if (!pdfFile.existsSync()) {
      return const SizedBox();
    }
    return ListTile(
      key: Key(pdfFile.path),
      title: Text(
        path.basename(pdfFile.path),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        '${DateTimeUtil.formatToDayMonthYear(pdfFile.lastModifiedSync())} • ${pdfFile.lengthSync() ~/ 1024} KB',
        style: const TextStyle(
          color: Color(0xffBFBFBF),
          fontSize: 12,
          fontWeight: FontWeight.w400,
        ),
      ),
      leading: leading ??
          (isLock
              ? Assets.icons.file.pdfLock.svg(width: 44)
              : Assets.icons.file.pdf.svg(width: 44)),
      trailing: trailing,
    );
  }
}
