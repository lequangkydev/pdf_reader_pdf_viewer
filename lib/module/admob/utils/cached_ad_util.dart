import 'package:flutter_ads/ads_flutter.dart';

import '../../../src/global/global.dart';
import '../model/ad_config/ad_config.dart';

abstract class CachedAdUtil<T extends AdController> {
  CachedAdUtil({
    required this.adConfig,
  });

  final AdUnitConfig adConfig;

  // Các controller đã được load và đang đợi sử dụng
  final List<T> _controllers = [];

  // Các controller đang được sử dụng
  final List<T> _usedControllers = [];

  bool get checkFullAds;

  T createController();

  /// Load trước ad
  void preloadAd() {
    if (checkFullAds && !Global.instance.isFullAds) {
      return;
    }
    final isEnable = adConfig.isEnable;
    if (!isEnable) {
      return;
    }
    // Kiểm tra xem trong danh sách controller có controller nào chưa impression
    // và không bị lỗi
    final hasController = _controllers.any(
      (element) => !element.hasAdBeenShown && !element.status.isLoadFailed,
    );
    // Nếu đã có controller chưa impression thì không load nữa
    if (hasController) {
      return;
    }
    // Khi khong có controller nào chưa impression sẽ tạo 1 controller mới
    final T controller = createController();
    controller.load();
    _controllers.add(controller);
    controller.onAdFailedToLoad = (ad, error) {
      _controllers.remove(controller);
    };
  }

  /// Lấy ra 1 controller trong danh sách [_controller] chưa impression
  T? getController() {
    if (checkFullAds && !Global.instance.isFullAds) {
      return null;
    }
    final enableOnRemoteConfig = adConfig.isEnable;
    if (!enableOnRemoteConfig) {
      return null;
    }
    // Kiểm tra xem trong danh sách controller có controller nào chưa impression
    // và không bị lỗi
    final index = _controllers.indexWhere(
      (element) => !element.hasAdBeenShown && !element.status.isLoadFailed,
    );
    T controller;
    if (index == -1) {
      // Tạo 1 controller mới nếu chưa có controller nào không impression
      controller = createController();
      controller.load();
      _usedControllers.add(controller);
    } else {
      // chuyển controller chưa impression vào _usedControllers
      controller = _controllers[index];
      _usedControllers.add(controller);
      _controllers.removeAt(index);
    }
    return controller;
  }

  void disposeController(T controller) {
    if (controller.hasAdBeenShown) {
      // dispose controller và xoá khỏi danh sách nếu như controller đó đã impression
      controller.dispose();
      _usedControllers.remove(controller);
      return;
    }

    // chuyển lại controller về danh sách _controller nếu nó chưa impresssion
    // và không load lỗi
    if (controller.status.isLoadFailed) {
      controller.dispose();
    } else {
      _controllers.add(controller);
    }
    _usedControllers.remove(controller);
  }
}
