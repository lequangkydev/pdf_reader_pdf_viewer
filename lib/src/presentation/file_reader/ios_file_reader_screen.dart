import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;

import '../../../module/tracking_screen/loggable_widget.dart';
import '../../data/model/file_model.dart';
import '../../gen/assets.gen.dart';
import '../../shared/constants/app_colors.dart';
import '../../shared/enum/app_enum.dart';
import '../../shared/extension/string_extension.dart';
import '../../shared/widgets/app_bar/custom_appbar.dart';
import '../../shared/widgets/bottom_sheet/action_file_bottom_sheet.dart';
import 'flutter_ios_file_reader.dart';

@RoutePage()
class IOSFileReaderScreen extends StatefulLoggableWidget {
  const IOSFileReaderScreen({
    super.key,
    required this.fileModel,
    required this.type,
    required this.file,
  });

  final FileModel fileModel;
  final File file;
  final TabBarType type;

  @override
  State<IOSFileReaderScreen> createState() => _IOSFileReaderScreenState();
}

class _IOSFileReaderScreenState extends State<IOSFileReaderScreen> {
  late FileModel fileUpdate;

  @override
  void initState() {
    fileUpdate = widget.fileModel;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        color: AppColors.divider,
        title: path
            .basenameWithoutExtension(fileUpdate.file.path)
            .shortenFileName(path.extension(fileUpdate.file.path)),
        actionWidget: [
          IconButton(
            onPressed: () async {
              await showActionFileBottomSheet(
                  context: context,
                  file: fileUpdate,
                  tabType: widget.type,
                  callBack: (file) {
                    setState(() {
                      fileUpdate = file;
                    });
                  },
                  callBackDelete: () async {
                    await context.maybePop();
                  });
            },
            icon: Assets.icons.icThreeDot
                .svg(color: const Color(0xFF808080), width: 24, height: 24),
          )
        ],
      ),
      body: IOSFileReaderView(
        file: widget.file,
      ),
    );
  }
}
