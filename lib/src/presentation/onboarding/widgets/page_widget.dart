import 'package:flutter/material.dart';
import 'package:flutter_ads/ads_flutter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../module/admob/utils/enum/ad_factory.dart';
import '../../../../module/admob/utils/utils.dart';
import '../../../../module/admob/widget/ads/common_native_ad.dart';
import '../../../../module/log_event_app/onboarding_event.dart';
import '../../../../module/remote_config/remote_config.dart';
import '../../../../module/tracking_screen/screen_logger.dart';
import '../../../gen/assets.gen.dart';
import '../../../gen/fonts.gen.dart';
import '../../../global/global.dart';
import '../../../shared/constants/app_colors.dart';
import '../../../shared/extension/context_extension.dart';
import '../../../shared/extension/number_extension.dart';
import '../onboarding_screen.dart';

class ContentPageWidget extends StatefulWidget {
  const ContentPageWidget({
    super.key,
    required this.title,
    required this.description,
    required this.pageController,
    this.adId,
    this.isLast = false,
    required this.index,
    this.adController,
    this.onInit,
    this.hasNativeFull = false,
  });

  final String title;
  final String description;
  final String? adId;
  final PageController pageController;
  final bool isLast;
  final int index;
  final NativeAdController? adController;
  final bool hasNativeFull;
  final VoidCallback? onInit;

  @override
  State<ContentPageWidget> createState() => _ContentPageWidgetState();
}

class _ContentPageWidgetState extends State<ContentPageWidget> {
  @override
  void initState() {
    super.initState();
    widget.onInit?.call();
  }

  bool get hasAd => widget.adController != null;

  void _logScreen(int page) {
    final screenName = switch (page) {
      0 => CustomScreenName.intro1Screen,
      1 => CustomScreenName.intro2Screen,
      _ => CustomScreenName.intro3Screen,
    };
    AnalyticLogger.instance.logCustomScreen(screenName);
  }

  void _logEvent(int page) {
    final eventName = switch (page) {
      0 => OnboardingEvent.enter_intro1,
      1 => OnboardingEvent.enter_intro2,
      _ => OnboardingEvent.enter_intro3,
    };
    AnalyticLogger.instance.logEventWithScreen(event: eventName);
  }

  @override
  Widget build(BuildContext context) {
    _logScreen(widget.index);
    _logEvent(widget.index);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          child: SizedBox.expand(
            child: Image(
              image: getImageAds(widget.index).provider(),
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
        ),
        Column(
          children: [
            buildDescription(),
            if (hasAd) 40.vSpace else 35.vSpace,
            if (widget.adController?.factoryId == largeNativeAdFactory)
              VerticalSmallAction(
                pageController: widget.pageController,
                index: widget.index,
                isLast: widget.isLast,
              )
            else if (hasAd)
              HorizontalAction(
                pageController: widget.pageController,
                index: widget.index,
                isLast: widget.isLast,
              )
            else
              VerticalAction(
                pageController: widget.pageController,
                index: widget.index,
                isLast: widget.isLast,
              ),
            if (hasAd)
              6.vSpace
            else if (widget.hasNativeFull && Global.instance.isFullAds) ...[
              20.vSpace,
              Center(
                child: context.isRTL
                    ? Transform(
                        alignment: Alignment.center,
                        transform: Matrix4.identity()
                          ..scaleByDouble(-1, 1, 1, 1),
                        child: Assets.lotties.swipe.lottie(
                          width: 100.r,
                          height: 170.r,
                          fit: BoxFit.fitWidth,
                        ),
                      )
                    : Assets.lotties.swipe.lottie(
                        width: 100.r,
                        height: 170.r,
                        fit: BoxFit.fitWidth,
                      ),
              ),
            ] else
              42.vSpace,
          ],
        ),
        _buildAd(),
      ],
    );
  }

  Widget _buildAd() {
    if (widget.adController == null) {
      return const SizedBox.shrink();
    }
    return CommonNativeAd.control(
      controller: widget.adController,
      height:
          widget.adController?.factoryId == AdFactory.smallRightNativeAd.name
              ? NativeAdSize.smallRightAd
              : widget.adController?.factoryId == AdFactory.smallNativeAd.name
                  ? NativeAdSize.smallAd
                  : NativeAdSize.large,
      border: Global.instance.isFullAds
          ? null
          : const Border(top: BorderSide(color: AppColors.adBorder)),
    );
  }

  Widget buildDescription() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            widget.title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 20.sp,
              fontFamily: FontFamily.sFProDisplay,
              color: AppColors.pr,
            ),
          ),
          3.vSpace,
          Text(
            widget.description,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16.sp,
              color: AppColors.color40,
              fontWeight: FontWeight.w400,
              fontFamily: FontFamily.sFProDisplay,
              height: 1,
            ),
          ),
        ],
      ),
    );
  }

  AssetGenImage getImageAds(int index) {
    final factory = widget.adController?.factoryId;

    final map = {
      AdFactory.smallNativeAd.name: [
        Assets.images.onboarding.intro1Medium,
        Assets.images.onboarding.intro2Medium,
        Assets.images.onboarding.intro3Medium,
        Assets.images.onboarding.intro3Medium,
      ],
      AdFactory.smallRightNativeAd.name: [
        Assets.images.onboarding.intro1Small,
        Assets.images.onboarding.intro2Small,
        Assets.images.onboarding.intro3Small,
        Assets.images.onboarding.intro3Small,
      ],
      'default': [
        Assets.images.onboarding.intro1Large,
        Assets.images.onboarding.intro2Large,
        Assets.images.onboarding.intro3Large,
        Assets.images.onboarding.intro3Large,
      ],
      'noAds': [
        Assets.images.onboarding.intro1Full,
        Assets.images.onboarding.intro2Full,
        Assets.images.onboarding.intro3Full,
        Assets.images.onboarding.intro3Full,
      ]
    };

    final key = () {
      if (!RemoteConfigManager.instance.enableAllAds) {
        return 'noAds';
      }
      if (widget.adController == null && !widget.hasNativeFull) {
        return 'noAds';
      }
      if (widget.hasNativeFull) {
        return Global.instance.isFullAds ? 'default' : 'noAds';
      }
      return factory ?? 'default';
    }();
    final list = map[key] ?? map['default']!;
    return list[index.clamp(0, list.length - 1)];
  }

  Widget getSPaceDes() {
    final factory = widget.adController?.factoryId;
    if (factory == AdFactory.smallNativeAd.name) {
      return 40.vSpace;
    }
    if (factory == largeNativeAdFactory) {
      return 40.vSpace;
    }
    if (factory == AdFactory.smallRightNativeAd.name) {
      return 40.vSpace;
    }
    return 20.vSpace;
  }
}
