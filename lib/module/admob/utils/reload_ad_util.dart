import 'package:flutter_ads/ads_flutter.dart';

import '../../../src/global/global.dart';
import '../../../src/shared/extension/number_extension.dart';
import '../model/ad_config/ad_config.dart';
import 'preload_ads_util.dart';
import 'utils.dart';

class ReloadAdUtil {
  ReloadAdUtil._();

  static final ReloadAdUtil instance = ReloadAdUtil._();

  AdUnitConfig? adConfig;
  NativeAdController? controller;

  Future<void> loadAd() async {
    if (controller == null && adConfig != null && Global.instance.isFullAds) {
      controller = PreloadAdsUtil.instance.createController(
        displayType: adTypes.nativeLanguageType.adDisplayType,
        adConfig: adConfig!,
        adKey: 'reloadAd',
      );
      controller?.load();
    }
  }
}
