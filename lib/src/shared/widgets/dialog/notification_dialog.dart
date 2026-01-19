import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../flavors.dart';
import '../../../config/di/di.dart';
import '../../../config/navigation/app_router.dart';
import '../../../gen/assets.gen.dart';
import '../../constants/app_colors.dart';
import '../../extension/context_extension.dart';
import '../../helpers/permission_util.dart';
import '../custom_switch.dart';

class NotificationPermissionDialog extends StatefulWidget {
  const NotificationPermissionDialog({super.key});

  static Future<bool?> show() {
    return showDialog<bool>(
      context: getIt<AppRouter>().navigatorKey.currentContext!,
      builder: (context) => const NotificationPermissionDialog(),
    );
  }

  @override
  State<NotificationPermissionDialog> createState() =>
      _NotificationPermissionDialogState();
}

class _NotificationPermissionDialogState
    extends State<NotificationPermissionDialog> with TickerProviderStateMixin {
  late final AnimationController _animationController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 500),
    lowerBound: 1,
    upperBound: 1.05,
  )
    ..addListener(
      () {
        if (_animationController.isCompleted) {
          _animationController.reverse();
        } else if (_animationController.isDismissed) {
          _animationController.forward();
        }
      },
    )
    ..forward();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: 320.w, // 👈 nhỏ chiều rộng
          maxHeight: 450.h, // 👈 giới hạn chiều cao
        ),
        child: Container(
          padding: const EdgeInsets.all(8.0).r,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.r),
              border: Border.all(color: const Color(0xff454545))),
          margin: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12).h,
                child: Text(
                  context.l10n.enableNotification,
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 4).h,
                      child: Assets.images.megaphone.image(
                        width: 16.r,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        context.l10n.neverMiss,
                        style: TextStyle(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.color40,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
              Stack(
                children: [
                  Align(child: Assets.images.phoneFrame.image(height: 250)),
                  Column(
                    children: [
                      40.verticalSpace,
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          children: [
                            40.horizontalSpace,
                            Assets.images.logo.roundedLogo.image(width: 36),
                            12.horizontalSpace,
                            Expanded(
                              child: Text(
                                F.title,
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.color40,
                                  fontSize: 14.sp,
                                ),
                              ),
                            ),
                            40.horizontalSpace,
                          ],
                        ),
                      ),
                      20.verticalSpace,
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            color: AppColors.pr,
                            width: 1.5,
                          ),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(15),
                          ),
                        ),
                        child: Row(
                          children: [
                            Assets.icons.notification.svg(),
                            6.horizontalSpace,
                            Text(
                              context.l10n.notification,
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 13.sp,
                              ),
                            ),
                            const Spacer(),
                            CustomSwitch(
                              value: true,
                              onChanged: (value) {},
                            )
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 36.w),
                child: AnimatedBuilder(
                  animation: _animationController,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: _animationController.value,
                      child: FilledButton(
                        style: FilledButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                              vertical: 14,
                            ).w,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.r),
                            )),
                        onPressed: requestPermission,
                        child: Text(
                          context.l10n.continuePer,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16.sp,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              TextButton(
                onPressed: context.maybePop,
                child: Text(
                  context.l10n.later,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    decoration: TextDecoration.underline,
                    color: const Color(0xffA6A6A6),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> requestPermission() async {
    context.maybePop();
    PermissionUtil.instance
        .requestPermissionNotificationDefault(openSetting: true);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
