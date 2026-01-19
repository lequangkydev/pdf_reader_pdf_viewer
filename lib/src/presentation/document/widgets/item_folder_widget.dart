import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:path/path.dart' as path;

import '../../../../module/file_system/file_system_manage.dart';
import '../../../data/model/file_model.dart';
import '../../../gen/assets.gen.dart';
import '../../../shared/enum/app_enum.dart';
import '../../../shared/extension/context_extension.dart';
import '../../../shared/extension/datetime_extension.dart';
import '../../../shared/extension/number_extension.dart';
import '../../../shared/utils/style_utils.dart';

enum ItemFolderType { itemSave, itemCheckBox }

class ItemFolderWidget extends StatelessWidget {
  const ItemFolderWidget({
    super.key,
    required this.tabBarType,
    required this.onTapSaveOrCheckBox,
    this.onTapThreeDot,
    this.onTapOpenFile,
    required this.fileModel,
    required this.itemFolderType,
    this.isCheck = false,
    this.showThreeDot = true,
    this.isSample = false,
    this.isBookmark = false,
    this.inBottomSheet = false,
  });

  final TabBarType tabBarType;
  final ItemFolderType itemFolderType;
  final bool isCheck;
  final VoidCallback onTapSaveOrCheckBox;
  final VoidCallback? onTapOpenFile;
  final VoidCallback? onTapThreeDot;
  final FileModel fileModel;
  final bool showThreeDot;
  final bool isSample;
  final bool isBookmark;
  final bool inBottomSheet;

  @override
  Widget build(BuildContext context) {
    if (!fileModel.file.existsSync() && !isSample) {
      return const SizedBox();
    }
    return GestureDetector(
      onTap: itemFolderType == ItemFolderType.itemCheckBox
          ? onTapSaveOrCheckBox
          : onTapOpenFile,
      behavior: HitTestBehavior.opaque,
      child: Container(
        alignment: Alignment.topCenter,
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          children: [
            Expanded(
              child: Row(
                children: [
                  if (fileModel.isLock)
                    Assets.icons.file.pdfLock.svg(width: 44, height: 44)
                  else
                    SvgPicture.asset(
                      tabBarType == TabBarType.all
                          ? FileSystemManager.instance
                              .getTypeFile(fileModel.file)
                              .valueSVG
                          : tabBarType.valueSVG,
                      width: 44,
                      height: 44,
                      fit: BoxFit.fill,
                    ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          isSample
                              ? '${context.l10n.sampleFile}${tabBarType.valueTypeFile}'
                              : path.basename(fileModel.file.path),
                          style: StyleUtils.style.s14.medium.b75,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Row(
                          children: [
                            Builder(
                              builder: (context) {
                                String displayText = '';
                                try {
                                  final modifiedTime = fileModel.file
                                      .lastModifiedSync()
                                      .convertDate;
                                  final fileSize =
                                      fileModel.file.lengthSync().convertByte;
                                  displayText = '$modifiedTime • $fileSize';
                                } catch (e) {
                                  displayText = '';
                                }
                                return Text(
                                  isSample
                                      ? '${DateTime.now().convertDate} • 403KB'
                                      : displayText,
                                  style: StyleUtils.style.s12.regular.b25,
                                );
                              },
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(width: 16),
            if (itemFolderType == ItemFolderType.itemCheckBox)
              fileModel.isSelect
                  ? Assets.icons.icCheckBoxOn.svg()
                  : Assets.icons.icCheckBoxOff.svg()
            else
              Row(
                children: [
                  if (inBottomSheet)
                    IconButton(
                      onPressed: onTapSaveOrCheckBox,
                      icon: fileModel.isBookmark || isBookmark
                          ? Assets.icons.bookmarkFill.svg()
                          : Assets.icons.bookmark.svg(),
                    ),
                  if (!inBottomSheet && (fileModel.isBookmark || isBookmark))
                    IconButton(
                      onPressed: onTapSaveOrCheckBox,
                      icon: Assets.icons.bookmarkFill.svg(),
                    ),
                  Visibility(
                    visible: showThreeDot,
                    child: IconButton(
                      onPressed: onTapThreeDot,
                      icon: Assets.icons.icThreeDot.svg(),
                    ),
                  ),
                ],
              )
          ],
        ),
      ),
    );
  }
}
