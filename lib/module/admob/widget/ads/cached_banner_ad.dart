import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ads/ads_flutter.dart';

import '../../../../src/shared/utils/reload_timer_util.dart';
import '../../../remote_config/remote_config.dart';
import '../../utils/cached_ad_util.dart';

class CachedBannerAd extends StatefulWidget {
  const CachedBannerAd({
    super.key,
    this.maintainSize = false,
    required this.cachedAdUtil,
  });

  final bool maintainSize;
  final CachedAdUtil<BannerAdController> cachedAdUtil;

  @override
  State<CachedBannerAd> createState() => _CachedBannerAdState();
}

class _CachedBannerAdState extends State<CachedBannerAd>
    with AutoRouteAwareStateMixin {
  bool get visible => controller != null;
  BannerAdController? controller;
  BannerAdController? waitingController;
  bool isCurrentScreen = false;
  ReloadTimerUtil? reloadTimerService;

  AppLifecycleListener? appLifecycleListener;
  bool isPaused = false;

  @override
  void didPushNext() {
    // tạm dừng reload timer khi sang màn khác
    isCurrentScreen = false;
    reloadTimerService?.pause();
    super.didPushNext();
  }

  @override
  void didPopNext() {
    // tiếp tục reload timer khi từ màn khác back về
    isCurrentScreen = true;
    reloadTimerService?.resume();
    super.didPopNext();
  }

  void autoReload() {
    final interval = RemoteConfigManager
        .instance.adsRemoteConfig.interval.reloadBannerInterval;
    reloadTimerService = ReloadTimerUtil();
    // start reload timer
    // reload ad sau 15s
    reloadTimerService?.start(
      interval: (interval - 5).clamp(1, interval),
      onReset: () {
        waitingController = widget.cachedAdUtil.getController();
        // tam dừng reload timer khi load ad mới
        reloadTimerService?.pause();
        Future.delayed(const Duration(seconds: 5), () {
          // sau 5s thì resume lại reload timer
          // và hiện thị ad mới
          if (waitingController != null) {
            widget.cachedAdUtil.disposeController(controller!);
            controller = waitingController;
            waitingController = null;
            if (mounted) {
              setState(() {});
            }
          }
          reloadTimerService?.resume();
        });
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
    controller = widget.cachedAdUtil.getController();
    if (!visible) {
      return;
    }
    autoReload();
  }

  @override
  Widget build(BuildContext context) {
    if (!visible) {
      return SizedBox(
        height: widget.maintainSize ? 60 : 0,
      );
    }
    return Builder(builder: (context) {
      return MyBannerAd.control(
        key: ValueKey(controller?.controllerId ?? DateTime.now()),
        controller: controller,
      );
    });
  }

  @override
  void dispose() {
    if (controller != null) {
      widget.cachedAdUtil.disposeController(controller!);
    }
    reloadTimerService?.dispose();
    super.dispose();
  }
}
