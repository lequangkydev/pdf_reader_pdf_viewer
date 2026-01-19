import 'dart:async';
import 'dart:ui';

import 'package:flutter_ads/ads_flutter.dart';

import '../../../src/config/di/di.dart';
import '../../../src/config/navigation/app_router.dart';
import '../../../src/shared/helpers/my_completer.dart';
import '../../remote_config/remote_config.dart';
import '../model/ad_config/ad_config.dart';
import '../model/inter_file_back_tab_config.dart';
import 'native_full_util.dart';
import 'utils.dart';

class InterFileBackTabUtil {
  InterFileBackTabUtil._();

  static InterFileBackTabUtil instance = InterFileBackTabUtil._();

  Timer? _timer;

  InterstitialAdController? _adController;

  InterFileBackTabConfig config = const InterFileBackTabConfig();

  final String _adKey = 'InterFileBackTabUtil';

  void init() {
    MyAds.instance.events.listen(
      (event) {
        final isClosed = event.status.isDismiss ||
            event.status.isLoadFailed ||
            event.status.isShowFailed;
        if (event.type == AdType.interstitial &&
            isClosed &&
            _adController == null) {
          preload();
        }
      },
    );
    preload();
  }

  void preload() {
    if (_adController != null && !_adController!.status.isShowOnScreen) {
      return;
    }

    if (_timer?.isActive ?? false) {
      _timer?.cancel();
    }
    final interval =
        RemoteConfigManager.instance.adsRemoteConfig.interval.interInterval;
    _timer = Timer(
      Duration(seconds: (interval - 5).clamp(0, interval)),
      () {
        if (adUnitsConfig.interFileBackTab.isEnable) {
          _adController = InterstitialAdController(
            adId: adUnitsConfig.interFileBackTab.id,
            adId2: adUnitsConfig.interFileBackTab.id2,
            adId2RequestPercentage:
                adUnitsConfig.interFileBackTab.id2RequestPercentage,
            adKey: _adKey,
          );
          _adController?.load();
        }
      },
    );
  }

  Future<void> show({
    bool enable = true,
    AdUnitConfig? nativeFullConfig,
    VoidCallback? adDismiss,
    VoidCallback? onShowed,
    VoidCallback? onFailed,
    VoidCallback? onclick,
  }) async {
    if (_adController == null || !enable) {
      return;
    }
    final completer = MyCompleter();
    NativeFullUtil? nativeFullUtil;
    MyAds.instance.showInterstitialAd(
      getIt<AppRouter>().navigatorKey.currentContext!,
      controller: _adController,
      onShowed: () {
        onShowed?.call();
        if (nativeFullConfig != null) {
          nativeFullUtil = NativeFullUtil(
            adConfig: nativeFullConfig,
          );
          nativeFullUtil?.preloadAd();
        }
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
      adDismissed: () async {
        _adController = null;
        await nativeFullUtil?.show();
        completer.complete();
        adDismiss?.call();
      },
    );
    return completer.future;
  }
}
