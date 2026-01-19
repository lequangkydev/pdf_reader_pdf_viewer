// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../gen/colors.gen.dart';
import '../../constants/app_colors.dart';
import '../../extension/context_extension.dart';
import '../../utils/style_utils.dart';
import '../button_widget.dart';

class RequestPermissionDialog extends StatelessWidget {
  const RequestPermissionDialog({
    super.key,
    required this.context,
    required this.title,
    required this.contentText,
    this.onClosed,
    this.buttonText,
    this.onButtonTap,
    this.pathImage,
    this.showMainBtn = true,
    this.heightBtn = 56,
    this.hideClose = false,
    this.widgetAction,
    this.heightImage,
  });

  final BuildContext context;
  final String title;
  final String contentText;
  final VoidCallback? onClosed;
  final String? buttonText;
  final VoidCallback? onButtonTap;
  final String? pathImage;
  final bool? showMainBtn;
  final bool? hideClose;
  final int? heightBtn;
  final List<Widget>? widgetAction;
  final double? heightImage;

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(builder: (context, orientation) {
      return Dialog(
        backgroundColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
        child: Container(
          padding: EdgeInsets.all(16.h),
          decoration: BoxDecoration(
              color: AppColors.divider,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: Colors.white,
            ),
          ),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  12.verticalSpace,
                  if (pathImage != null) ...[
                    Image.asset(
                      pathImage!,
                      height: heightImage ?? 120.h,
                      width: heightImage ?? 120.w,
                    ),
                    //16.verticalSpace,
                  ],
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: StyleUtils.style.s18.semiBold.black,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: 4.h, left: 10.w, right: 10.w, bottom: 24.h),
                    child: Text(
                      contentText,
                      textAlign: TextAlign.center,
                      style: StyleUtils.style.s16.black,
                    ),
                  ),
                  Column(
                    children: widgetAction ??
                        [
                          if (showMainBtn != null && showMainBtn!)
                            ButtonWidget(
                              onTap: onButtonTap ?? () => openAppSettings(),
                              child: Text(
                                buttonText ?? context.l10n.goToSetting,
                                style: StyleUtils.style.white.bold.s16,
                              ),
                            )
                        ],
                  )
                ],
              ),
              Positioned(
                top: 12.h,
                right: 12.w,
                child: hideClose != null && !hideClose!
                    ? GestureDetector(
                        onTap: onClosed ??
                            () {
                              context.maybePop();
                            },
                        child: const Icon(
                          Icons.close_rounded,
                          color: MyColors.p25,
                        ),
                      )
                    : const SizedBox(),
              ),
            ],
          ),
        ),
      );
    });
  }
}
