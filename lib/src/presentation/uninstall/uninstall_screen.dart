import 'package:auto_route/auto_route.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ads/ads_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../flavors.dart';
import '../../../module/admob/utils/inter_ad_util.dart';
import '../../../module/admob/utils/utils.dart';
import '../../../module/admob/widget/ads/common_native_ad.dart';
import '../../../module/tracking_screen/loggable_widget.dart';
import '../../config/di/di.dart';
import '../../config/navigation/app_router.dart';
import '../../gen/assets.gen.dart';
import '../../shared/cubit/value_cubit.dart';
import '../../shared/extension/context_extension.dart';
import '../../shared/helpers/permission_util.dart';
import '../../shared/screen/cubit/bottom_tab_cubit.dart';
import '../../shared/widgets/custom_button.dart';
import '../../shared/widgets/custom_radio.dart';
import '../../shared/widgets/marquee_text.dart';
import '../all_documents/cubit/all_file_cubit.dart';

part 'widget/item_card.dart';
part 'widget/problem_page.dart';
part 'widget/uninstall_page.dart';

@RoutePage()
class UninstallScreen extends StatefulLoggableWidget {
  const UninstallScreen({super.key});

  @override
  State<UninstallScreen> createState() => _UninstallScreenState();
}

class _UninstallScreenState extends State<UninstallScreen> {
  final pageController = PageController();
  final pageCubit = ValueCubit<int>(0);

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          return;
        }
        context.replaceRoute(const ShellRoute());
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          scrolledUnderElevation: 0,
          shadowColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          automaticallyImplyLeading: false,
          leadingWidth: 56.r,
          leading: CustomButton(
            padding: EdgeInsets.symmetric(horizontal: 16.r, vertical: 5.r),
            onTap: () {
              if (pageCubit.state == 0) {
                context.router.maybePop();
              } else {
                pageController.previousPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              }
            },
            child: Assets.icons.arrowLeft.svg(
              width: 24.r,
              height: 24.r,
            ),
          ),
        ),
        body: SafeArea(
          top: false,
          child: PageView(
            controller: pageController,
            physics: const NeverScrollableScrollPhysics(),
            onPageChanged: (value) {
              pageCubit.update(value);
            },
            children: const [
              _ProblemPage(),
              _UninstallPage(),
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16).w,
          child: BlocBuilder<ValueCubit<int>, int>(
            bloc: pageCubit,
            builder: (context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  FilledButton(
                    style: FilledButton.styleFrom(
                      textStyle: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20).r,
                      ),
                    ),
                    onPressed: () {
                      if (state == 0) {
                        context.maybePop();
                      } else {
                        FirebaseAnalytics.instance
                            .logEvent(name: 'tap_uninstall_2');
                        MyAds.instance.appLifecycleReactor
                            ?.setIsExcludeScreen(true);
                        openAppSettings();
                      }
                    },
                    child: Text(
                      switch (state) {
                        0 => context.l10n.dontUninstallYet,
                        _ => context.l10n.stillWantToUninstall,
                      },
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  8.verticalSpace,
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color(0xff343434),
                      side: const BorderSide(
                        color: Color(0xffF7DCDC),
                      ),
                      textStyle: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20).r,
                      ),
                    ),
                    onPressed: () async {
                      if (state == 0) {
                        await InterAdUtil.instance.showInterWithNativeFull(
                          interAdConfig: adUnitsConfig.interUninstall,
                          nativeFullConfig:
                              adUnitsConfig.nativeFullInterUninstall,
                          forceShow: true,
                        );
                        pageController.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                        FirebaseAnalytics.instance
                            .logEvent(name: 'tap_uninstall_1');
                      } else {
                        context.router.maybePop();
                      }
                    },
                    child: Text(
                      switch (state) {
                        0 => context.l10n.stillWantToUninstall,
                        _ => context.l10n.cancel,
                      },
                    ),
                  ),
                  30.verticalSpace,
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
