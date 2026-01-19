import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ads/ads_flutter.dart';
import 'package:path/path.dart' as path;
import 'package:uuid/uuid.dart';

import '../../module/admob/utils/utils.dart';
import '../../module/file_system/enum/file_system_type.dart';
import '../../module/file_system/file_system_manage.dart';
import '../../module/log_event_app/notification_event.dart';
import '../../module/remote_config/remote_config.dart';
import '../../module/tracking_screen/screen_logger.dart';
import '../config/di/di.dart';
import '../config/navigation/app_router.dart';
import '../data/local/shared_preferences_manager.dart';
import '../data/model/file_model.dart';
import '../data/model/notification_model.dart';
import '../global/global.dart';
import '../shared/helpers/logger_utils.dart';
import '../shared/screen/cubit/bottom_tab_cubit.dart';

enum NotificationAction {
  openHome,
  openBookmark,
  openRecent,
  openTool,
}

class DefaultAppChecker {
  DefaultAppChecker._();

  static const _channel = MethodChannel('default_app_checker');

  static Future<void> disableBack() async {
    try {
      _channel.invokeMethod('disableBack');
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  static Future<void> enableBack() async {
    try {
      _channel.invokeMethod('enableBack');
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  static Future<void> viewFile(bool isViewFile) async {
    try {
      _channel.invokeMethod('viewFile', {'isViewFile': isViewFile});
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  static Future<void> blockNotify() async {
    try {
      _channel.invokeMethod('blockNotify');
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  static Future<void> unBlockNotify() async {
    try {
      _channel.invokeMethod('unBlockNotify');
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  static Future<void> setFullAds() async {
    try {
      await _channel.invokeMethod<bool>(
          'initFullAds', {'isFullAds': Global.instance.isFullAds});
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  static Future<bool> isDefaultPdfApp(String filePath) async {
    try {
      final result = await _channel
          .invokeMethod<bool>('checkDefaultApp', {'filePath': filePath});
      return result ?? false;
    } catch (e) {
      return false;
    }
  }

  static Future<void> openDefaultPdfSettings(String filePath) async {
    try {
      await _channel
          .invokeMethod('openDefaultAppSettings', {'filePath': filePath});
    } catch (e) {
      print('Error opening default settings: $e');
    }
  }

  static Future<void> openManageExternalStorage() async {
    try {
      await _channel.invokeMethod('openManageExternalStorage');
    } catch (e) {
      print('Error opening default settings: $e');
    }
  }

  static Future<void> openNotificationSettings() async {
    try {
      await _channel.invokeMethod('openNotificationSettings');
    } catch (e) {
      print('Error opening settings: $e');
    }
  }

  static Future<void> setRecentFilePath(String? path) async {
    try {
      await _channel.invokeMethod('setRecentFilePath', {'filePath': path});
    } catch (e) {
      logger.e(e);
    }
  }

  static Future<void> showFunctionNotification() async {
    try {
      await _channel.invokeMethod('showFunctionNotification');
    } catch (e) {
      logger.e(e);
    }
  }

  static Future<void> showRecentFileNotification() async {
    try {
      await _channel.invokeMethod('showRecentFileNotification');
    } catch (e) {
      logger.e(e);
    }
  }

  static Future<void> updateLocale(String languageCode) async {
    try {
      await Future.delayed(const Duration(milliseconds: 500));
      await _channel.invokeMethod(
        'updateLocale',
        {'languageCode': languageCode},
      );
    } catch (e) {
      logger.e(e);
    }
  }

  static Future<void> setNotificationContent(
      NotificationModel notificationModel) async {
    try {
      await Future.delayed(const Duration(milliseconds: 50));
      final json = notificationModel.toJson();
      await _channel.invokeMethod(
        'setNotificationContent',
        json,
      );
    } catch (e) {
      logger.e(e);
    }
  }

  static void setMethodCallHandler() {
    _channel.setMethodCallHandler((call) async {
      switch (call.method) {
        case 'openFileFromNotification':
          final args = call.arguments as Map;
          final filePath = args["filePath"] as String;
          final isSplash = args["isSplash"] as bool;
          final currentRoute = Global.instance.currentRouteName;
          final isFirstUse = SharedPreferencesManager.instance.isFirstUseApp();
          final isOnlyRootScreen = getIt<AppRouter>().stack.length == 1;
          //user cấp quyền notification ở language sau đó xuống background
          //user chưa vào home trường hợp app chưa bị kill và
          // xuống background của splash,language, intro => không xử lí gì cho back lại màn chính nó
          if (currentRoute != null && isOnlyRootScreen && isFirstUse) {
            return;
          }
          final fileSample = File('${Global.instance.documentPath}/sample.pdf');
          final file = File(filePath);
          if (fileSample.path == file.path) {
            return;
          }
          //trường hợp chưa kill app
          if (currentRoute != null &&
              currentRoute == ShellRoute.name &&
              fileSample.path == file.path) {
            return;
          }
          if (!file.existsSync()) {
            return;
          }
          if (isSplash) {
            Global.instance.recentFilePath = filePath;
            return;
          }
          final String fileExtension = path.extension(file.path).toLowerCase();
          if (fileExtension == '.pdf') {
            getIt<AppRouter>().replaceAll(
              [
                ViewPdfRoute(
                    pdfFile: FileModel(id: const Uuid().v1(), file: file),
                    fromReload: true),
              ],
            );
            return;
          }
          if (imagesExtension.contains(fileExtension)) {
            getIt<AppRouter>().replaceAll(
              [
                ViewImageRoute(
                  fileModel: FileModel(file: file, id: ''),
                  fromReload: true,
                )
              ],
            );
            return;
          }
          if (pptExtension.contains(fileExtension) ||
              excelsExtension.contains(fileExtension) ||
              wordsExtension.contains(fileExtension)) {
            final type = FileSystemManager.instance.getTypeFile(file);
            getIt<AppRouter>().replaceAll([
              ViewFileRoute(
                type: type,
                fileModel: FileModel(file: file, id: ''),
                file: file,
                fromReload: true,
              ),
            ]);
          }
          break;
        case 'pushRecentFilePath':
          final filePath = call.arguments as String;
          Global.instance.recentFilePath = filePath;
          break;
        case 'openNotify':
          final useInterAd =
              RemoteConfigManager.instance.adsRemoteConfig.openResumeByNoti ==
                  2;
          final bool enableOpenResumeByNoti =
              RemoteConfigManager.instance.adsRemoteConfig.openResumeByNoti !=
                  0;
          if (enableOpenResumeByNoti) {
            final adConfig = useInterAd
                ? adUnitsConfig.interOtherApp
                : adUnitsConfig.openResumeByNoti;
            MyAds.instance.appLifecycleReactor?.setSingleUseAdId(
              id: useInterAd ? adConfig.id : adConfig.id,
              id2: useInterAd ? adConfig.id2 : adConfig.id2,
              adId2RequestPercentage: useInterAd
                  ? adConfig.id2RequestPercentage
                  : adConfig.id2RequestPercentage,
              useInterAd: useInterAd,
              intervalInSeconds: RemoteConfigManager
                  .instance.adsRemoteConfig.interval.intervalResumeByNoti,
            );
          } else {
            MyAds.instance.appLifecycleReactor?.setIsExcludeScreen(true);
          }
          break;
        default:
          handleTapActionOnNotification(call.method);
          break;
      }
    });
  }

  static void handleTapActionOnNotification(String action) {
    if (action != 'openHome' &&
        action != 'openRecent' &&
        action != 'openBookmark' &&
        action != 'openTool') {
      return;
    }
    if (SharedPreferencesManager.instance.isFirstUseApp()) {
      return;
    }
    switch (action) {
      case 'openHome':
        if (Global.instance.initializedSplash) {
          getIt<AppRouter>().replaceAll([const ShellRoute()]);
          AnalyticLogger.instance
              .logEventWithScreen(event: NotificationEvent.user_tap_openHome);
          getIt<BottomTabCubit>().changeTab(BottomTab.document);
        }
        Global.instance.notificationAction = NotificationAction.openHome.name;
        break;
      case 'openRecent':
        if (Global.instance.initializedSplash) {
          getIt<AppRouter>().replaceAll([const ShellRoute()]);
          getIt<BottomTabCubit>().changeTab(BottomTab.recent);
          AnalyticLogger.instance
              .logEventWithScreen(event: NotificationEvent.user_tap_openRecent);
        }
        Global.instance.notificationAction = NotificationAction.openRecent.name;
        break;
      case 'openBookmark':
        if (Global.instance.initializedSplash) {
          getIt<AppRouter>().replaceAll([const ShellRoute()]);
          getIt<BottomTabCubit>().changeTab(BottomTab.bookmark);
          AnalyticLogger.instance.logEventWithScreen(
              event: NotificationEvent.user_tap_openBookmark);
        }
        Global.instance.notificationAction =
            NotificationAction.openBookmark.name;
        break;
      case 'openTool':
        if (Global.instance.initializedSplash) {
          getIt<AppRouter>().replaceAll([const ShellRoute()]);
          getIt<BottomTabCubit>().changeTab(BottomTab.more);
          AnalyticLogger.instance
              .logEventWithScreen(event: NotificationEvent.user_tap_openTool);
        }
        Global.instance.notificationAction = NotificationAction.openTool.name;
        break;
      default:
        break;
    }
  }
}
