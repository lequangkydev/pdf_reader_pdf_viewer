import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ads/ads_flutter.dart';

import '../../../../src/shared/utils/reload_timer_util.dart';
import '../../../remote_config/remote_config.dart';
import '../../model/ad_config/ad_config.dart';

class CustomBanner extends StatefulWidget {
  const CustomBanner({
    super.key,
    this.adConfig,
    this.controller,
    this.visible = true,
    this.maintainSize = false,
    this.reload = false,
    this.reloadTime,
  });

  final AdUnitConfig? adConfig;
  final BannerAdController? controller;
  final bool visible;
  final bool maintainSize;
  final bool reload;
  final int? reloadTime;

  @override
  State<CustomBanner> createState() => _CustomBannerState();
}

class _CustomBannerState extends State<CustomBanner>
    with AutoRouteAwareStateMixin {
  bool visible = false;
  BannerAdController? controller;
  bool isCurrentScreen = false;
  ReloadTimerUtil? reloadTimerService;

  AppLifecycleListener? appLifecycleListener;
  bool isPaused = false;

  @override
  void didPushNext() {
    if (widget.reload) {
      // tạm dừng reload timer khi sang màn khác
      isCurrentScreen = false;
      controller?.disposeAd();
      reloadTimerService?.pause();
      super.didPushNext();
    }
  }

  @override
  void didPopNext() {
    if (widget.reload) {
      // tiếp tục reload timer khi từ màn khác back về
      isCurrentScreen = true;
      controller?.load();
      reloadTimerService?.resume();
    }

    super.didPopNext();
  }

  void autoReload() {
    reloadTimerService = ReloadTimerUtil();
    // start reload timer
    // reload ad sau 15s
    reloadTimerService?.start(
      interval: widget.reloadTime ??
          RemoteConfigManager
              .instance.adsRemoteConfig.interval.reloadBannerInterval,
      onReset: () {
        controller?.reload();
      },
    );
    controller?.stream.listen(
      (event) {
        if (event.isLoading) {
          reloadTimerService?.pause();
        } else if ((event.isImpression || event.isLoadFailed) && !isPaused) {
          reloadTimerService?.reset();
        }
      },
    );
    appLifecycleListener = AppLifecycleListener(
      onStateChange: (value) {
        if (!isCurrentScreen) {
          // Nếu ad native này không được hiển thị ở màn hiện tại
          return;
        }
        // Nếu app được mở lại từ background
        // thì resume lại reload timer
        // Nếu app bị ẩn duới background thì pause lại reload timer
        if (value == AppLifecycleState.resumed) {
          isPaused = false;
          reloadTimerService?.resume();
        } else if (value == AppLifecycleState.paused) {
          isPaused = true;
          reloadTimerService?.pause();
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();
    if (widget.controller != null) {
      controller = widget.controller;
      visible = true;
    } else if (widget.adConfig?.isEnable ?? false) {
      controller = BannerAdController(
        adId: widget.adConfig!.id,
        adId2: widget.adConfig!.id2,
        adId2RequestPercentage: widget.adConfig!.id2RequestPercentage,
      );
      controller?.load();
      visible = true;
    }

    if (widget.reload) {
      autoReload();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!visible) {
      return SizedBox(
        height: widget.maintainSize ? 60 : 0,
      );
    }
    return Builder(builder: (context) {
      return MyBannerAd.control(controller: controller);
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    reloadTimerService?.dispose();
    super.dispose();
  }
}
