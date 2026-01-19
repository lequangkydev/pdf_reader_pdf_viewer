import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ads/ads_flutter.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:upgrader/upgrader.dart';

import '../../flavors.dart';
import '../../module/adjust/adjust.dart';
import '../../module/hive/hive_box.dart';
import '../../module/remote_config/remote_config.dart';
import '../data/local/shared_preferences_manager.dart';
import '../global/global.dart';
import '../services/ai_service.dart';
import '../services/default_app_checker.dart';
import '../shared/mixin/system_ui_mixin.dart';
import '../shared/widgets/dialog/loading_dialog.dart';
import 'di/di.dart';

class AppConfig with SystemUiMixin {
  factory AppConfig.getInstance() {
    return _instance;
  }

  AppConfig._();

  static final AppConfig _instance = AppConfig._();

  Future<void> init() async {
    _initUpgrader();
    MyAds.instance.initialize();
    LoadingOverlay.preload();
    AIService().init(
      baseUrl: "https://api.code12.cloud/",
      appId: F.appFlavor == Flavor.dev ? "DEV" : 'VTN_365G',
      secretKey: F.appFlavor == Flavor.dev
          ? "CvxhFbxa9b2y"
          : 'p8AcaHR7SL2d3Pe8O1daljo7FZ5DWC0v',
    );
    await Future.wait([
      Firebase.initializeApp(),
      _initHydrateBlocStorage(),
      SharedPreferencesManager.instance.initialize(),
      HiveBox.init(),
    ]);
    await RemoteConfigManager.instance.initConfig();
    configureDependencies();
    await _initAdjust();
    _setNotificationContent();
    // await getIt<MyPurchasesManager>().init();
  }

  void _setNotificationContent() {
    final data = RemoteConfigManager.instance.notificationContent;
    if (data != null) {
      DefaultAppChecker.setNotificationContent(data);
    }
  }

  Future<void> _initUpgrader() async {
    Global.instance.upgrader = Upgrader(
      // debugDisplayAlways: true,
      debugLogging: true,
    );
    await Global.instance.upgrader?.initialize();
  }

  Future<void> _initAdjust() {
    final adjustConfig = RemoteConfigManager.instance.adjustConfig;
    final adjustEnvironment = F.appFlavor == Flavor.dev
        ? AdjustEnvironment.sandbox
        : AdjustEnvironment.production;
    return AdjustUtil.instance.initialize(
      // Kiểm tra môi trường Adjust
      environment: adjustEnvironment,
      // Token app của Adjust
      appToken: AdjustToken(
        androidToken: adjustConfig.appToken,
      ),
      // Cấu hình cho ad
      adOptions: AdOptions(
        androidAdOptions: AndroidAdOptions(
          // Token event để log các sự kiện impression của ad lên Adjust
          impressionToken: adjustConfig.eventToken,
          // Callback khi ad kiểm tra xem có phải là full ad không
          fullAdCallback: (isFullAd, network, fromCache, fromLib, fromApi) {
            if (const bool.hasEnvironment('FULL_ADS')) {
              isFullAd = const bool.fromEnvironment('FULL_ADS');
            }
            Global.instance.isFullAds = isFullAd;
            if (!isFullAd) {
              DefaultAppChecker.setFullAds();
            }
          },
        ),
      ),
      fullAdsOption: adjustConfig.fullAdsOption,
      apiToken: adjustConfig.apiToken,
    );
  }

  Future<HydratedStorage> _initHydrateBlocStorage() async {
    final Directory documentDir = await getApplicationDocumentsDirectory();
    final dataDir =
        Directory('${documentDir.path}${Platform.pathSeparator}data');
    return HydratedBloc.storage =
        await HydratedStorage.build(storageDirectory: dataDir);
  }

  bool shouldAutoHide = true;

  //show hide bottom navigation bar of device
  void settingSystemUI() {
    if (Platform.isAndroid) {
      shouldAutoHide = true;
      SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.transparent,
      ));

      hideNavigationBar();
      SystemChrome.setSystemUIChangeCallback(
          (bool systemOverlaysAreVisible) async {
        if (systemOverlaysAreVisible && shouldAutoHide) {
          Future<void>.delayed(
            const Duration(seconds: 3),
            hideNavigationBar,
          );
        }
      });
    }
    SystemChrome.setPreferredOrientations(<DeviceOrientation>[
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }
}
