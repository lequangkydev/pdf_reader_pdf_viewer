import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_ads/ads_flutter.dart';

import '../widget/ads/full_screen_native_ad.dart';
import 'cached_ad_util.dart';
import 'enum/ad_factory.dart';

class NativeFullUtil extends CachedAdUtil<NativeAdController> {
  NativeFullUtil({
    required super.adConfig,
    this.adKey,
  });

  final String? adKey;

  @override
  bool get checkFullAds => true;

  @override
  NativeAdController createController() {
    return NativeAdController(
      adId: adConfig.id,
      adId2: adConfig.id2,
      adId2RequestPercentage: adConfig.id2RequestPercentage,
      adKey: adKey,
      factoryId: AdFactory.fullNativeAd.name,
    );
  }

  Future<void> show({VoidCallback? onClose}) {
    return showFullNativeAd(
      onClose: onClose,
      nativeAdUtil: this,
    );
  }
}
