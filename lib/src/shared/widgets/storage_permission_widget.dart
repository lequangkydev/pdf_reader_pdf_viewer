import 'package:flutter/material.dart';
import 'package:flutter_ads/ads_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../flavors.dart';
import '../../../module/log_event_app/shell_event.dart';
import '../../../module/tracking_screen/screen_logger.dart';
import '../../gen/assets.gen.dart';
import '../../global/global.dart';
import '../../presentation/all_documents/cubit/all_file_cubit.dart';
import '../../presentation/permission/cubit/storage_status_cubit.dart';
import '../../services/default_app_checker.dart';
import '../constants/app_colors.dart';
import '../extension/context_extension.dart';
import '../extension/number_extension.dart';
import '../helpers/permission_util.dart';
import '../mixin/permission_mixin.dart';

class StoragePermissionWidget extends StatefulWidget {
  const StoragePermissionWidget({super.key, this.hideWelcomeText = false});

  final bool hideWelcomeText;

  @override
  State<StoragePermissionWidget> createState() =>
      _StoragePermissionWidgetState();
}

class _StoragePermissionWidgetState extends State<StoragePermissionWidget>
    with PermissionMixin, WidgetsBindingObserver, TickerProviderStateMixin {
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    MyAds.instance.appLifecycleReactor?.setShouldShow(true);
    super.initState();
  }

  Future<void> checkStoragePermission() async {
    final bool status = await PermissionUtil.instance.checkStoragePermission();
    if (mounted) {
      context.read<StoragePermissionCubit>().update(status);
    }
    if (status) {
      PermissionUtil.instance.requestPermissionNotificationDefault();
    }
  }

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
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16).w,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (!widget.hideWelcomeText) 40.vSpace,
            if (!widget.hideWelcomeText)
              Text(
                context.l10n.welcomeTo,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: AppColors.color40,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            if (!widget.hideWelcomeText)
              Text(
                F.title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.pr,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            35.vSpace,
            SizedBox(
              width: 256,
              child: Stack(
                children: [
                  Align(child: Assets.images.phoneFrame.image(height: 250)),
                  Column(
                    children: [
                      40.verticalSpace,
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          children: [
                            50.horizontalSpace,
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
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(16),
                              child: Row(
                                children: [
                                  Assets.icons.folder.svg(
                                    width: 24,
                                    colorFilter: const ColorFilter.mode(
                                      AppColors.pr,
                                      BlendMode.srcIn,
                                    ),
                                  ),
                                  8.horizontalSpace,
                                  Expanded(
                                    child: Text(
                                      context.l10n.allowAccessTo,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 13.sp,
                                      ),
                                    ),
                                  ),
                                  120.horizontalSpace,
                                ],
                              ),
                            ),
                            if (context.isRTL)
                              Positioned(
                                left: 15,
                                child: Assets.lotties.switchToggle
                                    .lottie(width: 50.r),
                              )
                            else
                              Positioned(
                                right: 15,
                                child: Assets.lotties.switchToggle
                                    .lottie(width: 50.r),
                              )
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            16.verticalSpace,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20).w,
              child: Text.rich(
                TextSpan(text: context.l10n.toContinuePleaseGrant, children: [
                  TextSpan(
                    text: ' ${F.title} ',
                    style: const TextStyle(
                      color: AppColors.pr,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  TextSpan(
                    text: context.l10n.acceptToYourFile,
                  ),
                ]),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Color(0xff262626),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            32.verticalSpace,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: AnimatedBuilder(
                  animation: _animationController,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: _animationController.value,
                      child: FilledButton(
                        style: FilledButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                              vertical: 14,
                              horizontal: 70,
                            ).w,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.r),
                            )),
                        onPressed: () async {
                          DefaultAppChecker.blockNotify();
                          MyAds.instance.appLifecycleReactor
                              ?.setIsExcludeScreen(!Global.instance.isFullAds);
                          final status = await PermissionUtil.instance
                              .requestStoragePermission();
                          AnalyticLogger.instance.logEventWithScreen(
                              event: ShellEvent.Enter_FROM_PER_AllFile);
                          if (status && context.mounted) {
                            context.read<AllFileCubit>().reloadFile();
                          }
                          DefaultAppChecker.unBlockNotify();
                        },
                        child: Text(
                          context.l10n.continuePer,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16.sp,
                          ),
                        ),
                      ),
                    );
                  }),
            ),
            35.vSpace,
          ],
        ),
      ),
    );
  }

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      checkStoragePermission();
      // context.read<AllFileCubit>().reloadFile();
    }
  }

  @override
  void dispose() {
    MyAds.instance.appLifecycleReactor?.setShouldShow(true);
    WidgetsBinding.instance.removeObserver(this);
    _animationController.dispose();
    super.dispose();
  }
}
