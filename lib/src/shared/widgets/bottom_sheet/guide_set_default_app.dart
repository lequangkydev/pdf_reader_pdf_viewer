import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../module/remote_config/remote_config.dart';
import '../../../config/navigation/app_router.dart';
import '../../../data/local/shared_preferences_manager.dart';
import '../../../data/model/file_model.dart';
import '../../../gen/assets.gen.dart';
import '../../../global/global.dart';
import '../../../services/default_app_checker.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_constants.dart';
import '../../enum/app_enum.dart';
import '../../extension/context_extension.dart';
import '../../extension/number_extension.dart';

List<TextSpan> highlightKeywordInText(
  String fullText,
  String keyword,
  TextStyle highlightStyle,
) {
  final spans = <TextSpan>[];
  final keywordIndex = fullText.indexOf(keyword);

  if (keywordIndex == -1) {
    // Nếu không tìm thấy thì trả nguyên văn
    spans.add(TextSpan(text: fullText));
    return spans;
  }

  final before = fullText.substring(0, keywordIndex);
  final highlighted = keyword;
  final after = fullText.substring(keywordIndex + keyword.length);

  if (before.isNotEmpty) {
    spans.add(TextSpan(text: before));
  }

  spans.add(TextSpan(text: highlighted, style: highlightStyle));

  if (after.isNotEmpty) {
    spans.add(TextSpan(text: after));
  }

  return spans;
}

Future<void> showGuideAppDefaultBottomSheet({
  required BuildContext context,
  required FileModel file,
  required TabBarType type,
}) async {
  final typeDefaultPermission =
      RemoteConfigManager.instance.appConfig.screenFlow.typeDefaultPermission;
  final countOpenFile = SharedPreferencesManager.instance.countOpenFile();
  if (Global.instance.sharedFiles != null) {
    return;
  }
  final shouldShow = switch (typeDefaultPermission) {
    0 => countOpenFile == 1,
    1 => (countOpenFile % 2) == 1, // 1,3,5...
    2 => (countOpenFile % 3) == 1, // 1,4,7...
    _ => false,
  };
  if (!shouldShow) {
    SharedPreferencesManager.instance.setCountOpenFile(countOpenFile + 1);
    return;
  }

  final bool isDefault =
      await DefaultAppChecker.isDefaultPdfApp(file.file.path);

  if (isDefault) {
    return;
  }

  final result = await showModalBottomSheet<bool>(
    context: context,
    isScrollControlled: true,
    isDismissible: false,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (context) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 47),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            8.vSpace,
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.shade400,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            12.vSpace,
            Text(
              context.l10n.theFastestWay,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            12.vSpace,
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: const TextStyle(fontSize: 14, color: Colors.black),
                children: highlightKeywordInText(
                  context.l10n.textSetDefault,
                  AppConstants.appName,
                  const TextStyle(
                    color: AppColors.pr,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            16.vSpace,
            Container(
              decoration: BoxDecoration(
                color: const Color(0xffF4F4FD),
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  Assets.icons.tip.svg(width: 24),
                  8.hSpace,
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        text: '${context.l10n.tip}: ',
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppColors.pr,
                          fontWeight: FontWeight.w500,
                        ),
                        children: [
                          TextSpan(
                            text: context.l10n.subTip,
                            style: const TextStyle(
                              color: Color(0xff404040),
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            24.vSpace,
            Stack(
              alignment: Alignment.center,
              children: [
                // Grid layout of apps
                GridView.builder(
                  shrinkWrap: true,
                  itemCount: 8,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                  ),
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return SizedBox(
                        width: 50,
                        height: 50,
                        child: Assets.images.logo.roundedLogo.image(),
                      );
                    } else {
                      return Container(
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(12),
                        ),
                      );
                    }
                  },
                ),

                // Emoji or Image of pointing hand
                Positioned(
                  left: 15,
                  top: 10,
                  child: Assets.images.appDefault.tap.image(width: 100),
                ),
              ],
            ),
            24.vSpace,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      context.l10n.justOnce,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Color(0xffA6A6A6),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Assets.images.appDefault.circle.image(),
                        Text(
                          context.l10n.always,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            20.vSpace,
            SizedBox(
              width: double.infinity,
              height: 48.h,
              child: ElevatedButton(
                onPressed: () async {
                  Navigator.pop(context, true);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.pr,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  context.l10n.setAsDefault,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            4.vSpace,
            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: Text(
                context.l10n.notNow,
                style: const TextStyle(
                  color: Color(0xffBFBFBF),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            )
          ],
        ),
      );
    },
  );
  SharedPreferencesManager.instance.setCountOpenFile(countOpenFile + 1);
  if (result ?? false) {
    await DefaultAppChecker.openDefaultPdfSettings(file.file.path);
    final bool isDefault =
        await DefaultAppChecker.isDefaultPdfApp(file.file.path);
    if (isDefault && context.mounted) {
      if (Global.instance.sharedFiles != null) {
        Global.instance.sharedFiles = null;
      }
      context.router.replaceAll(
        [SplashRoute(isReload: true, file: file, type: type)],
        updateExistingRoutes: false,
      );
      return;
    }
  }
}
