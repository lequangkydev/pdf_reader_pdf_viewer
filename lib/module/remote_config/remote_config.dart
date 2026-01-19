import 'dart:convert';

import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';

import '../../flavors.dart';
import '../../src/data/model/adjust_config.dart';
import '../../src/data/model/app_config_model.dart';
import '../../src/data/model/notification_model.dart';
import '../../src/shared/helpers/logger_utils.dart';
import '../admob/model/ad_config/ad_config.dart';
import '../admob/model/inter_file_back_tab_config.dart';
import '../admob/model/native_all_config/native_all_config.dart';
import '../admob/utils/inter_file_back_tab_util.dart';
import '../admob/utils/native_all_util.dart';
import '../admob/utils/reload_ad_util.dart';
import 'default_values/dev_values.dart';
import 'default_values/prod_values.dart';

class RemoteConfigManager {
  RemoteConfigManager._privateConstructor();

  static final RemoteConfigManager instance =
      RemoteConfigManager._privateConstructor();
  final FirebaseRemoteConfig _remoteConfig = FirebaseRemoteConfig.instance;
  bool initialized = false;

  /// Config cho app
  AppConfigModel _appConfig = const AppConfigModel();

  AppConfigModel get appConfig => _appConfig;

  /// Config cho  quảng cáo
  AdsRemoteConfig _adsRemoteConfig = const AdsRemoteConfig();

  AdsRemoteConfig get adsRemoteConfig => _adsRemoteConfig;

  /// Config cho adjust
  AdjustConfig _adjustConfig = const AdjustConfig();

  AdjustConfig get adjustConfig => _adjustConfig;

  bool get enableAllAds {
    // if (purchasesManager.isPremium) {
    //   return false;
    // }
    return adsRemoteConfig.showAllAds;
  }

  Future<void> initConfig() async {
    if (initialized) {
      return;
    }
    await _remoteConfig.setConfigSettings(
      RemoteConfigSettings(
        fetchTimeout: const Duration(
          seconds: 5,
        ), // a fetch will wait up to 5 seconds before timing out
        minimumFetchInterval: const Duration(
          seconds: 5,
        ), // fetch parameters will be cached for a maximum of 5 seconds
      ),
    );

    // Set default values for remote config
    await _remoteConfig.setDefaults(
        F.appFlavor == Flavor.dev ? devDefaultValues : prodDefaultValues);
    await _fetchConfig();
    await Future.wait([
      _loadAdUnitConfig(),
      _loadAppConfig(),
      _loadAdjustConfig(),
    ]);
    initialized = true;
  }

  Future<void> _loadAdUnitConfig() async {
    try {
      final String rawJson = _remoteConfig.getString('ad_config');
      final result = await compute((message) {
        final value = json.decode(message) as Map<String, dynamic>;
        final reloadAdConfigRaw = value['adUnitsConfig'][value['reloadKey']];
        AdUnitConfig? reloadAdConfig;
        if (reloadAdConfigRaw != null) {
          reloadAdConfig =
              AdUnitConfig.fromJson(reloadAdConfigRaw as Map<String, dynamic>);
        }
        final adRemoteConfig = AdsRemoteConfig.fromJson(value);

        return (adRemoteConfig, reloadAdConfig);
      }, rawJson);
      _adsRemoteConfig = result.$1;
      ReloadAdUtil.instance.adConfig = result.$2;

      // Load config cho native all
      final nativeAllConfigJson =
          _adsRemoteConfig.adUnitsConfig.nativeAll.extraKeys;
      if (nativeAllConfigJson != null && nativeAllConfigJson.isNotEmpty) {
        NativeAllUtil.instance.config =
            NativeAllConfig.fromJson(nativeAllConfigJson);
      }
      // Load config cho inter_file_back_tab
      final interFileBackTabConfigJson =
          _adsRemoteConfig.adUnitsConfig.nativeAll.extraKeys;
      if (interFileBackTabConfigJson != null &&
          interFileBackTabConfigJson.isNotEmpty) {
        InterFileBackTabUtil.instance.config =
            InterFileBackTabConfig.fromJson(interFileBackTabConfigJson);
      }
      print('object');
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> _loadAppConfig() async {
    try {
      final String rawJson = _remoteConfig.getString('app_config');
      _appConfig = await compute((message) {
        final value = json.decode(message);
        return AppConfigModel.fromJson(value);
      }, rawJson);
      print('object');
    } on Exception catch (e) {
      logger.e(e);
    }
  }

  Future<void> _loadAdjustConfig() async {
    try {
      final String rawJson = _remoteConfig.getString('adjust_config');
      _adjustConfig = await compute((message) {
        final value = json.decode(message);
        return AdjustConfig.fromJson(value);
      }, rawJson);
      print('object');
    } on Exception catch (e) {
      logger.e(e);
    }
  }

  Future<void> _fetchConfig([bool refresh = false]) async {
    try {
      await _remoteConfig.fetchAndActivate();
    } catch (_) {
      if (!refresh) {
        _fetchConfig(true);
      }
    }
  }

  NotificationModel? get notificationContent {
    final rawValue = _remoteConfig.getString('notification_content');
    if (rawValue.isEmpty) {
      return null;
    }
    try {
      final data = NotificationModel.fromJson(jsonDecode(rawValue));
      return data;
    } on Exception catch (e) {
      logger.e(e);
    }
    return null;
  }
}
