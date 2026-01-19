import 'package:flutter_ads/ads_flutter.dart';

import '../../../src/global/global.dart';
import '../../remote_config/remote_config.dart';
import '../model/ad_config/ad_config.dart';
import 'enum/ad_factory.dart';

class NativeAdSize {
  const NativeAdSize._();

  static const double large = 240;
  static const double medium = 200;
  static const double extraAd = 272;
  static const double normalAd = 260;
  static const double homeAd = 160;
  static const double smallAd = 130;
  static const double smallRightAd = 70;
}

String get largeNativeAdFactory {
  if (Global.instance.isFullAds &&
      RemoteConfigManager.instance.adsRemoteConfig.showTopButton) {
    return AdFactory.topExtraNativeAd.name;
  } else {
    return AdFactory.bottomNormalNativeAd.name;
  }
}

String get largeNativeAdIntro {
  if (Global.instance.isFullAds &&
      RemoteConfigManager.instance.adsRemoteConfig.showTopButton) {
    return AdFactory.topExtraNativeAdCustomColor.name;
  } else {
    return AdFactory.bottomNormalNativeAdCustomColor.name;
  }
}

AdUnitsConfig get adUnitsConfig =>
    RemoteConfigManager.instance.adsRemoteConfig.adUnitsConfig;

AdTypes get adTypes => RemoteConfigManager.instance.adsRemoteConfig.adTypes;

extension NativeAdCtrlExt on NativeAdController {
  Future<void> preloadAd() async {
    if (!status.isLoading && !status.isShowOnScreen) {
      await load();
    }
  }
}
