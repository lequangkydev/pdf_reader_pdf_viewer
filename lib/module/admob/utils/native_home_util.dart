import 'package:flutter_ads/ads_flutter.dart';
import 'package:flutter_base/module/admob/utils/utils.dart';

import '../../../src/global/global.dart';
import '../model/ad_config/ad_config.dart';
import 'enum/ad_factory.dart';

class NativeHomeUtil {
  NativeHomeUtil._();

  static final instance = NativeHomeUtil._();

  NativeAdController? _controller;

  Future<void> initController() async {
    if (Global.instance.isFullAds && adUnitsConfig.nativeTabMores.isEnable) {
      if (_controller == null) {
        _controller = NativeAdController(
          adId: adUnitsConfig.nativeTabMores.id,
          adId2: adUnitsConfig.nativeTabMores.id2,
          adId2RequestPercentage:
              adUnitsConfig.nativeTabMores.id2RequestPercentage,
          factoryId: AdFactory.homeNativeAd.name,
          loadOnImpression: true,
        );
        await _controller!.load();
        return;
      }
      if (_controller != null && _controller!.hasAdBeenShown) {
        _controller!.reload();
      }
    }
  }

  void updateAds() {
    if (_controller != null && _controller!.hasAdBeenShown) {
      _controller!.reload();
    }
  }

  NativeAdController? get getController => _controller;
}
