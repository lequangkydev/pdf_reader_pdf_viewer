import 'package:flutter_ads/ads_flutter.dart';

import '../../../src/global/global.dart';
import '../model/ad_config/ad_config.dart';
import 'enum/ad_factory.dart';

class PreloadNativeFullUtils {
  PreloadNativeFullUtils._();

  static NativeAdController? preloadAd({
    required AdUnitConfig adConfig,
    bool ignoreCheckFullAds = false,
  }) {
    if (!Global.instance.isFullAds && !ignoreCheckFullAds) {
      return null;
    }
    if (!adConfig.isEnable) {
      return null;
    }

    final NativeAdController controller = NativeAdController(
      adId: adConfig.id,
      adId2: adConfig.id2,
      adId2RequestPercentage: adConfig.id2RequestPercentage,
      factoryId: AdFactory.fullNativeAd.name,
    )..load();
    return controller;
  }
}
