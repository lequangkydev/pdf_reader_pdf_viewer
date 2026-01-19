import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ads/ads_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../module/admob/model/ad_config/ad_config.dart';
import '../../../module/admob/utils/cached_banner_ad_util.dart';
import '../../../module/admob/utils/inter_ad_util.dart';
import '../../../module/admob/utils/preload_ads_util.dart';
import '../../../module/admob/utils/utils.dart';
import '../../../module/log_event_app/onboarding_event.dart';
import '../../../module/log_event_app/shell_event.dart';
import '../../../module/remote_config/remote_config.dart';
import '../../../module/tracking_screen/screen_logger.dart';
import '../../config/navigation/app_router.dart';
import '../../data/local/shared_preferences_manager.dart';
import '../../global/global.dart';
import '../../shared/constants/app_colors.dart';
import '../../shared/extension/context_extension.dart';
import '../../shared/extension/number_extension.dart';
import '../../shared/helpers/permission_util.dart';
import '../../shared/utils/file_utils.dart';
import 'cubit/swipe_page_cubit.dart';
import 'widgets/full_screen_native_page.dart';
import 'widgets/indicator.dart';
import 'widgets/page_widget.dart';

part 'widgets/page_action.dart';

@RoutePage()
class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen>
    with WidgetsBindingObserver {
  final PageController _pageController = PageController();

  Widget buildFullScreenAd(NativeAdController controller) {
    return FullScreenNativePage(
      controller: controller,
      onClose: () {
        _pageController.nextPage(
          duration: const Duration(milliseconds: 200),
          curve: Curves.ease,
        );
      },
      onLoadFail: () {
        if (PreloadAdsUtil.instance.ctrlIntro2 == controller) {
          PreloadAdsUtil.instance.ctrlIntro2 = null;
        }
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) {
            setState(() {});
          }
        });
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _setupAdClickHandlers();
    PreloadAdsUtil.instance.ctrlIntro2?.preloadAd();
    WidgetsBinding.instance.addObserver(this);
    // InterFileBackTabUtil.instance.init();
    if (!RemoteConfigManager.instance.appConfig.screenFlow.showLanguage &&
        SharedPreferencesManager.instance.isFirstUseApp()) {
      Future.delayed(
        Duration.zero,
        () {
          PermissionUtil.instance.requestPermissionNotificationDefault();
        },
      );
    }
  }

  final List<bool> _clickedAds = List.filled(4, false);
  final onboardEventClickAds = [
    OnboardingEvent.click_nativeintro1,
    OnboardingEvent.click_nativeintro2,
    OnboardingEvent.click_nativeintro3,
    OnboardingEvent.click_nativeintro4,
  ];
  final onboardEventReopenAfterClick = [
    OnboardingEvent.reopen_after_ads_intro1,
    OnboardingEvent.reopen_after_ads_intro2,
    OnboardingEvent.reopen_after_ads_intro3,
    OnboardingEvent.reopen_after_ads_intro4,
  ];

  void _setupAdClickHandlers() {
    final controllers = [
      PreloadAdsUtil.instance.ctrlIntro1,
      PreloadAdsUtil.instance.ctrlIntro2,
      PreloadAdsUtil.instance.ctrlIntro3,
    ];

    for (int i = 0; i < controllers.length; i++) {
      final controller = controllers[i];
      controller?.onAdClicked = (_) {
        _clickedAds[i] = true;
        AnalyticLogger.instance.logEventWithScreen(
          event: onboardEventClickAds[i],
        );
      };
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      for (int i = 0; i < _clickedAds.length; i++) {
        if (_clickedAds[i]) {
          AnalyticLogger.instance
              .logEventWithScreen(event: onboardEventReopenAfterClick[i]);
          _clickedAds[i] = false;
        }
      }
    }
  }

  final onboardingEventSwipe = [
    OnboardingEvent.swipe_intro1,
    OnboardingEvent.swipe_intro2,
    OnboardingEvent.swipe_intro3,
    OnboardingEvent.swipe_intro4,
  ];

  @override
  Widget build(BuildContext context) {
    //xem nó là swipe hay tap
    //true
    return BlocProvider(
      create: (context) => SwipePageCubit(),
      child: Builder(builder: (context) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: PageView(
            controller: _pageController,
            onPageChanged: (value) {
              if (context.read<SwipePageCubit>().state) {
                AnalyticLogger.instance.logEventWithScreen(
                    event: onboardingEventSwipe[value > 0 ? value - 1 : value]);
              } else {
                context.read<SwipePageCubit>().update(true);
              }
              debugPrint("value:$value");
            },
            children: [
              ContentPageWidget(
                key: const ValueKey(0),
                index: 0,
                title: context.l10n.onboardingTitle1,
                description: context.l10n.onboardingContent1,
                pageController: _pageController,
                adController: PreloadAdsUtil.instance.ctrlIntro1,
              ),
              ContentPageWidget(
                key: const ValueKey(1),
                index: 1,
                title: context.l10n.onboardingTitle2,
                description: context.l10n.onboardingContent2,
                pageController: _pageController,
                adController: adTypes.nativeIntro2Type.adDisplayType !=
                        AdDisplayType.fullScreen
                    ? PreloadAdsUtil.instance.ctrlIntro2
                    : null,
                hasNativeFull: adTypes.nativeIntro2Type.adDisplayType ==
                    AdDisplayType.fullScreen,
                onInit: () {
                  PreloadAdsUtil.instance.ctrlIntro3?.preloadAd();
                },
              ),
              if (PreloadAdsUtil.instance.ctrlIntro2 != null &&
                  adTypes.nativeIntro2Type.adDisplayType ==
                      AdDisplayType.fullScreen)
                buildFullScreenAd(PreloadAdsUtil.instance.ctrlIntro2!),
              ContentPageWidget(
                key: const ValueKey(2),
                index: 2,
                title: context.l10n.onboardingTitle3,
                description: context.l10n.onboardingContent3,
                pageController: _pageController,
                isLast: true,
                adController: PreloadAdsUtil.instance.ctrlIntro3,
                onInit: () {
                  BannerAllUtil.instance.preloadAd();
                },
              ),
            ],
          ),
        );
      }),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    PreloadAdsUtil.instance.disposeNativeIntro();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}
