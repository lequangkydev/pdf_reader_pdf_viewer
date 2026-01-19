import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:path/path.dart' as path;

import '../../../config/di/di.dart';
import '../../../config/navigation/app_router.dart';
import '../../extension/context_extension.dart';
import '../../extension/datetime_extension.dart';
import '../../extension/number_extension.dart';
import '../../utils/style_utils.dart';

class FileDetailsBottomSheet extends StatefulWidget {
  const FileDetailsBottomSheet({super.key, required this.file});

  final File file;

  @override
  _FileDetailsBottomSheetState createState() => _FileDetailsBottomSheetState();
}

class _FileDetailsBottomSheetState extends State<FileDetailsBottomSheet> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            context.l10n.detail,
            style: StyleUtils.style.semiBold.s16.b75,
          ),
          16.verticalSpace,
          itemAction(
            context.l10n.fileName,
            path.basename(widget.file.path),
          ),
          itemAction(
            context.l10n.storagePath,
            widget.file.path,
          ),
          itemAction(
            context.l10n.lastView,
            widget.file.lastAccessedSync().convertDateTime,
          ),
          itemAction(
            context.l10n.lastModified,
            widget.file.lastModifiedSync().convertDateTime,
          ),
          itemAction(
            context.l10n.size,
            widget.file.lengthSync().convertByte,
          ),
          24.verticalSpace,
        ],
      ),
    );
  }

  Widget itemAction(
    String title,
    String description,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: StyleUtils.style.medium.s14.b75,
            ),
          ),
          16.horizontalSpace,
          Flexible(
            flex: 3,
            child: Text(
              description,
              style: StyleUtils.style.medium.s14.b25,
            ),
          ),
        ],
      ),
    );
  }
}

Future<String?> showFileDetailsBottomSheet(File file) async {
  final currentCtx = getIt<AppRouter>().navigatorKey.currentContext;
  if (currentCtx == null) {
    return null;
  }
  return showModalBottomSheet<String>(
    context: currentCtx,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
    ),
    isScrollControlled: true,
    builder: (context) {
      return Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: FileDetailsBottomSheet(
          file: file,
        ),
      );
    },
  );
}
