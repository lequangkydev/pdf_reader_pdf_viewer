import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_ads/ads_flutter.dart';

import '../../../src/config/di/di.dart';
import '../../../src/config/navigation/app_router.dart';
import '../model/ad_config/ad_config.dart';

class AdStatusNotifier extends ValueNotifier<bool> {
  AdStatusNotifier() : super(false);

  void notifyClosed() => value = true;
}

final adNotifier = AdStatusNotifier();

class SplashAdUtil {
  SplashAdUtil._();

  static SplashAdUtil instance = SplashAdUtil._();

  Future<void> show({
    required AdUnitConfig adConfig,
    VoidCallback? onClosed,
    VoidCallback? onShow,
    bool isInterstitial = false,
  }) async {
    if (!adConfig.isEnable) {
      return;
    }
    final completer = Completer();
    if (isInterstitial) {
      MyAds.instance.showInterstitialAd(
        getIt<AppRouter>().navigatorKey.currentContext!,
        adId: adConfig.id,
        adId2: adConfig.id2,
        adId2RequestPercentage: adConfig.id2RequestPercentage,
        onShowed: () {
          onShow?.call();
          completer.complete();
        },
        onFailed: () {
          onClosed?.call();
          completer.complete();
        },
        onNoInternet: () {
          onClosed?.call();
          completer.complete();
        },
        adDismissed: () async {
          onClosed?.call();
        },
      );
    } else {
      MyAds.instance.showSplashAd(
        getIt<AppRouter>().navigatorKey.currentContext!,
        adId: adConfig.id,
        adId2: adConfig.id2,
        adId2RequestPercentage: adConfig.id2RequestPercentage,
        useInterAd: isInterstitial,
        onShowed: () {
          onShow?.call();
          completer.complete();
        },
        onFailed: () {
          onClosed?.call();
          completer.complete();
        },
        onNoInternet: () {
          onClosed?.call();
          completer.complete();
        },
        adDismissed: () async {
          onClosed?.call();
        },
      );
    }

    return completer.future;
  }
}
