import 'dart:async';
import 'dart:ui';

import 'package:flutter_ads/ads_flutter.dart';

import '../../../src/config/di/di.dart';
import '../../../src/config/navigation/app_router.dart';
import '../../../src/global/global.dart';
import '../model/ad_config/ad_config.dart';
import 'native_full_util.dart';

class InterAdUtil {
  InterAdUtil._();

  static InterAdUtil instance = InterAdUtil._();

  Future<void> showInterAd({
    required AdUnitConfig adConfig,
    bool forceShow = false,
    VoidCallback? adDismiss,
    VoidCallback? onShowed,
    VoidCallback? onFailed,
    VoidCallback? onclick,
  }) async {
    if (!adConfig.isEnable) {
      return;
    }
    final completer = Completer();
    MyAds.instance.showInterstitialAd(
      getIt<AppRouter>().navigatorKey.currentContext!,
      adId: adConfig.id,
      adId2: adConfig.id2,
      adId2RequestPercentage: adConfig.id2RequestPercentage,
      forceShow: forceShow,
      onShowed: () {
        onShowed?.call();
      },
      onAdClicked: () {
        onclick?.call();
      },
      onFailed: () {
        completer.complete();
        onFailed?.call();
      },
      onNoInternet: () {
        completer.complete();
      },
      adDismissed: () {
        completer.complete();
        adDismiss?.call();
      },
    );
    return completer.future;
  }

  Future<void> showInterSplashAd({
    required AdUnitConfig adConfig,
    FutureOr<void> Function()? adDismissed,
    VoidCallback? onFailed,
    VoidCallback? onShow,
  }) async {
    if (!adConfig.isEnable) {
      onFailed?.call();
      return;
    }
    final completer = Completer();
    MyAds.instance.showInterstitialAd(
      getIt<AppRouter>().navigatorKey.currentContext!,
      adId: adConfig.id,
      adId2: adConfig.id2,
      adId2RequestPercentage: adConfig.id2RequestPercentage,
      showLoading: false,
      onShowed: () {
        onShow?.call();
        completer.complete();
      },
      onFailed: () {
        onFailed?.call();
        completer.complete();
      },
      onNoInternet: () {
        onFailed?.call();
        completer.complete();
      },
      adDismissed: () async {
        await adDismissed?.call();
      },
    );
    return completer.future;
  }

  Future<void> showInterWithNativeFull({
    required AdUnitConfig interAdConfig,
    required AdUnitConfig nativeFullConfig,
    bool checkFullAds = true,
    bool forceShow = false,
  }) async {
    if (checkFullAds && !Global.instance.isFullAds) {
      return;
    }
    if (!interAdConfig.isEnable) {
      return;
    }

    final completer = Completer();
    NativeFullUtil? nativeFullUtil;
    await MyAds.instance.showInterstitialAd(
      getIt<AppRouter>().navigatorKey.currentContext!,
      adId: interAdConfig.id,
      adId2: interAdConfig.id2,
      forceShow: forceShow,
      adId2RequestPercentage: interAdConfig.id2RequestPercentage,
      onShowed: () {
        nativeFullUtil = NativeFullUtil(adConfig: nativeFullConfig);
        nativeFullUtil?.preloadAd();
      },
      onFailed: () {
        completer.complete();
      },
      onNoInternet: () {
        completer.complete();
      },
      adDismissed: () async {
        await nativeFullUtil?.show();

        completer.complete();
      },
    );
    return completer.future;
  }
}
