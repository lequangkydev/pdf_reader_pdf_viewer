import 'package:flutter_ads/ads_flutter.dart';

import '../model/ad_config/ad_config.dart';
import 'cached_ad_util.dart';
import 'utils.dart';

class BannerAllUtil extends CachedAdUtil<BannerAdController> {
  BannerAllUtil._({required super.adConfig});

  static final instance = BannerAllUtil._(
    adConfig: const AdUnitConfig(),
  );

  @override
  AdUnitConfig get adConfig => adUnitsConfig.bannerAll;

  @override
  bool get checkFullAds => false;

  @override
  BannerAdController createController() {
    return BannerAdController(
      adId: adConfig.id,
      adId2: adConfig.id2,
      adId2RequestPercentage: adConfig.id2RequestPercentage,
      adKey: 'banner_all',
    );
  }
}

class BannerViewFileUtil extends CachedAdUtil<BannerAdController> {
  BannerViewFileUtil._({required super.adConfig});

  @override
  bool get checkFullAds => true;

  static final instance = BannerViewFileUtil._(
    adConfig: const AdUnitConfig(),
  );

  @override
  AdUnitConfig get adConfig => adUnitsConfig.bannerViewFile;

  @override
  BannerAdController createController() {
    return BannerAdController(
      adId: adConfig.id,
      adId2: adConfig.id2,
      adId2RequestPercentage: adConfig.id2RequestPercentage,
      adKey: 'banner_view_file',
    );
  }
}
