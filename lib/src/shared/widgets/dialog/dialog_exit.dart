import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../module/admob/utils/utils.dart';
import '../../../../module/admob/widget/ads/common_native_ad.dart';
import '../../../../module/remote_config/key/ad_remote_key.dart';
import '../../constants/app_colors.dart';
import '../../extension/context_extension.dart';
import '../../utils/style_utils.dart';
import '../button_widget.dart';

class DialogWidgetExit extends StatelessWidget {
  const DialogWidgetExit({
    super.key,
    this.title,
    required this.contentWidget,
    this.confirmText,
    this.cancelText,
    required this.onConfirm,
    this.onCancel,
    this.padding,
    required this.oneButton,
    this.firstButtonHot = true,
  });

  final String? title;
  final bool oneButton;
  final Widget contentWidget;
  final String? confirmText;
  final String? cancelText;
  final VoidCallback onConfirm;
  final VoidCallback? onCancel;
  final EdgeInsetsGeometry? padding;
  final bool firstButtonHot;

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(builder: (context, orientation) {
      return Dialog(
        backgroundColor: AppColors.divider,
        shadowColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        /*    shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
        ),*/
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: Colors.white,
            ),
            color: Colors.white,
          ),
          child: SingleChildScrollView(
            padding: padding ?? EdgeInsets.fromLTRB(24.h, 24.h, 24.h, 16.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if ((title ?? '').isNotEmpty) ...{
                  Text(title ?? '', style: StyleUtils.style.b75.bold.s20),
                  SizedBox(height: 16.h),
                } else
                  const SizedBox(),
                contentWidget,
                const SizedBox(height: 16),
                if (!oneButton) ...{
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const SizedBox(width: 16),
                      Expanded(
                        child: ButtonWidget(
                          color: AppColors.b7,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          onTap: onCancel ?? context.maybePop,
                          child: Text(
                            cancelText ?? context.l10n.cancel,
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            style: StyleUtils.style.b25.semiBold.s16,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: ButtonWidget(
                          color: AppColors.pr,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          onTap: onConfirm,
                          child: Text(
                            confirmText ?? context.l10n.ok,
                            textAlign: TextAlign.center,
                            style: StyleUtils.style.white.semiBold.s16,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                    ],
                  ),
                } else ...{
                  ButtonWidget(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    onTap: onConfirm,
                    child: Text(
                      confirmText ?? context.l10n.ok,
                      style: StyleUtils.style.white.bold.s16,
                    ),
                  ),
                },
                CommonNativeAd(
                  adConfig: adUnitsConfig.nativeExit,
                  margin: EdgeInsets.only(top: 14.h),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  static Future<void> showDialogExit({
    required BuildContext context,
    String? title,
    required Widget contentWidget,
    String? confirmText,
    String? cancelText,
    required VoidCallback onConfirm,
    VoidCallback? onCancel,
    EdgeInsetsGeometry? padding,
    bool oneButton = false,
    bool firstButtonHot = true,
  }) {
    return showDialog<void>(
      context: context,
      builder: (context) {
        return DialogWidgetExit(
          title: title,
          contentWidget: contentWidget,
          confirmText: confirmText,
          cancelText: cancelText,
          onConfirm: onConfirm,
          onCancel: onCancel,
          padding: padding,
          oneButton: oneButton,
          firstButtonHot: firstButtonHot,
        );
      },
    );
  }
}
