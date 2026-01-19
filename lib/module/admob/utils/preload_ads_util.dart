import 'dart:async';

import 'package:flutter_ads/ads_flutter.dart';

import '../../../src/global/global.dart';
import '../../../src/shared/extension/number_extension.dart';
import '../../remote_config/remote_config.dart';
import '../model/ad_config/ad_config.dart';
import 'enum/ad_factory.dart';
import 'preload_native_full_util.dart';
import 'utils.dart';

class PreloadAdsUtil {
  PreloadAdsUtil._();

  static PreloadAdsUtil instance = PreloadAdsUtil._();

  NativeAdController? ctrlLanguage;
  NativeAdController? ctrlLanguageSelect;

  NativeAdController? ctrlIntro1;
  NativeAdController? ctrlIntro2;
  NativeAdController? ctrlIntro3;

  double heightNativeView(AdDisplayType displayType) {
    if (displayType == AdDisplayType.noMediaRight) {
      return NativeAdSize.smallRightAd;
    }
    return displayType == AdDisplayType.noMedia
        ? NativeAdSize.smallAd
        : NativeAdSize.large;
  }

  NativeAdController? createController({
    required AdDisplayType displayType,
    required AdUnitConfig adConfig,
    bool buttonBottom = false,
    String? adKey,
    bool isIntro = false,
  }) {
    //nếu intro thì có thể dùng customcolor tuỳ vào UI
    if (!adConfig.isEnable || displayType == AdDisplayType.hidden) {
      return null;
    }
    final String factoryId = switch (displayType) {
      AdDisplayType.noMedia =>
        isIntro ? AdFactory.smallNativeAd.name : AdFactory.smallNativeAd.name,
      AdDisplayType.noMediaRight => isIntro
          ? AdFactory.smallRightNativeAd.name
          : AdFactory.smallRightNativeAd.name,
      AdDisplayType.fullScreen => AdFactory.fullNativeAd.name,
      _ => buttonBottom
          ? (isIntro
              ? AdFactory.bottomNormalNativeAd.name
              : AdFactory.bottomNormalNativeAd.name)
          : (isIntro ? largeNativeAdIntro : largeNativeAdFactory),
    };
    final controller = NativeAdController(
      adId: adConfig.id,
      adId2: adConfig.id2,
      adId2RequestPercentage: adConfig.id2RequestPercentage,
      factoryId: factoryId,
      adKey: adKey,
    );
    return controller;
  }

  Future<void> preloadAdsLanguage() async {
    if (!RemoteConfigManager.instance.adsRemoteConfig.preloadAdsLanguage) {
      return;
    }
    final tasks = <Future<void>>[];

    ctrlLanguage = createController(
      displayType: adTypes.nativeLanguageType.adDisplayType,
      adConfig: adUnitsConfig.nativeLanguage,
      adKey: 'nativeLanguage',
    );
    if (ctrlLanguage != null) {
      tasks.add(ctrlLanguage!.load());
    }

    ctrlLanguageSelect = createController(
      displayType: adTypes.nativeLanguageSelectType.adDisplayType,
      adConfig: adUnitsConfig.nativeLanguageSelect,
      adKey: 'nativeLanguageSelect',
    );
    // if (ctrlLanguageSelect != null) {
    //   tasks.add(ctrlLanguageSelect!.load());
    // }
    await Future.wait(tasks);
  }

  void loadLanguageSelect() {
    ctrlLanguageSelect?.load();
  }

  void preloadAdsIntro() {
    if (!RemoteConfigManager.instance.adsRemoteConfig.preloadAdsIntro) {
      return;
    }

    ctrlIntro1 = createController(
      displayType: adTypes.nativeIntro1Type.adDisplayType,
      adConfig: adUnitsConfig.nativeIntro1,
      adKey: 'nativeIntro1',
    );
    ctrlIntro1?.load();
    ctrlIntro1?.onAdFailedToLoad = (ad, error) {
      ctrlIntro1 = null;
    };

    final enableIntro2FullOnNormalAd =
        RemoteConfigManager.instance.adsRemoteConfig.showIntro2FullNormal;
    final enableIntro2FullOnFullAd =
        RemoteConfigManager.instance.adsRemoteConfig.showIntro2FullFull;

    final intro2Type = adTypes.nativeIntro2Type.adDisplayType;

    if (intro2Type != AdDisplayType.fullScreen ||
        (enableIntro2FullOnNormalAd && !Global.instance.isFullAds) ||
        (enableIntro2FullOnFullAd && Global.instance.isFullAds)) {
      ctrlIntro2 = createController(
        displayType: adTypes.nativeIntro2Type.adDisplayType,
        adConfig: adUnitsConfig.nativeIntro2,
        adKey: 'nativeIntro2',
      );
    }

    if (Global.instance.isFullAds) {
      ctrlIntro3 = createController(
        displayType: adTypes.nativeIntro3Type.adDisplayType,
        adConfig: adUnitsConfig.nativeIntro3,
        adKey: 'nativeIntro3',
      );
    }
  }

  //native full splash
  NativeAdController? nativeFullSplashCtrl;

  void preloadNativeFullSlash({
    required AdUnitConfig adConfig,
    bool ignoreCheckFullAds = false,
  }) {
    nativeFullSplashCtrl = PreloadNativeFullUtils.preloadAd(
      adConfig: adConfig,
      ignoreCheckFullAds: ignoreCheckFullAds,
    );
    nativeFullSplashCtrl?.load();
  }

  void disposeNativeIntro() {
    ctrlIntro1?.dispose();
    ctrlIntro2?.dispose();
    ctrlIntro3?.dispose();
  }

  void disposeNativeLanguage() {
    ctrlLanguage?.dispose();
    ctrlLanguageSelect?.dispose();
  }
}
