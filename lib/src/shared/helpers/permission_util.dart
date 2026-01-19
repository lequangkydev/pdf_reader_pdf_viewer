import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ads/ads_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../config/di/di.dart';
import '../../config/navigation/app_router.dart';
import '../../gen/assets.gen.dart';
import '../../global/global.dart';
import '../../services/default_app_checker.dart';
import '../../services/notification_service.dart';
import '../extension/context_extension.dart';
import '../widgets/dialog/notification_dialog.dart';
import '../widgets/dialog/request_permission_dialog.dart';

class PermissionUtil {
  PermissionUtil._();

  static PermissionUtil instance = PermissionUtil._();

  // TODO(son): Xóa nếu không cần thiết
  //Ví dụ về yêu cầu quyền truy cập và lưu trữ ảnh
  Future<bool> checkStoragePermission() async {
    bool status;
    if (Platform.isAndroid) {
      status = await _checkStoragePermissionOnAndroid();
    } else {
      status = await _checkStoragePermissionOnIOS();
    }
    return status;
  }

  Future<PermissionStatus> checkCameraPermission() async {
    return Permission.camera.status;
  }

  Future<bool> requestStoragePermission() async {
    PermissionStatus status;
    if (Platform.isAndroid) {
      if (Global.instance.androidSdkVersion >= 30) {
        await DefaultAppChecker.openManageExternalStorage();
        status = await Permission.manageExternalStorage.status;
      } else {
        status = await Permission.storage.request();
      }
    } else {
      status = await Permission.photos.request();
    }
    return status.isGranted || status.isLimited;
  }

  Future<bool> _checkStoragePermissionOnIOS() async {
    final PermissionStatus status = await Permission.photos.status;
    return status.isLimited || status.isGranted;
  }

  Future<bool> _checkStoragePermissionOnAndroid() async {
    PermissionStatus status;
    if (Global.instance.androidSdkVersion >= 30) {
      status = await Permission.manageExternalStorage.status;
    } else {
      status = await Permission.storage.status;
    }
    return status.isGranted || status.isLimited;
  }

  Future<PermissionStatus> requestCameraPermission(BuildContext context) async {
    PermissionStatus status = PermissionStatus.denied;
    final isPermanentlyDenied = await Permission.camera.isPermanentlyDenied;

    if (isPermanentlyDenied) {
      showDialogGoToSetting(
          title: context.l10n.reqPermission,
          content: context.l10n.cameraReqPermission,
          image: Assets.images.permission.path);
    } else {
      status = await Permission.camera.request();
    }
    return status;
  }

  Future<dynamic> showDialogGoToSetting({
    required String title,
    required String content,
    required String image,
    bool location = false,
    VoidCallback? callback,
    VoidCallback? onTap,
  }) async {
    final context1 = getIt<AppRouter>().navigatorKey.currentContext!;
    return showDialog(
      barrierDismissible: false,
      context: context1,
      builder: (context) => GestureDetector(
        onTap: () {
          context.maybePop();
          callback?.call();
        },
        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.transparent,
          child: RequestPermissionDialog(
            context: context,
            title: title,
            contentText: content,
            buttonText: context.l10n.goToSetting,
            pathImage: image,
            onButtonTap: () async {
              context.maybePop();
              MyAds.instance.appLifecycleReactor?.setIsExcludeScreen(true);
              onTap?.call();
              await openAppSettings();
            },
            onClosed: () {
              context.maybePop();
              callback?.call();
            },
            heightBtn: 40,
          ),
        ),
      ),
    );
  }

  Future<bool> checkNotificationPermission() async {
    final status = await Permission.notification.status;
    return status.isGranted || status.isLimited;
  }

  Future<bool> requestPermissionNotificationDefault(
      {bool openSetting = false}) async {
    final isPermanentlyDenied =
        await Permission.notification.isPermanentlyDenied;
    PermissionStatus permissionStatus = PermissionStatus.denied;
    if (isPermanentlyDenied && openSetting) {
      MyAds.instance.appLifecycleReactor?.setIsExcludeScreen(true);
      await DefaultAppChecker.openNotificationSettings();
      permissionStatus = await Permission.notification.status;
    } else {
      Global.instance.isRequestNotification = true;
      permissionStatus = await Permission.notification.request();
    }
    if (permissionStatus.isLimited || permissionStatus.isGranted) {
      DefaultAppChecker.showFunctionNotification();
      NotificationService.instance.init();
    }
    if (permissionStatus.isPermanentlyDenied) {
      Global.instance.isRequestNotification = false;
    }
    return permissionStatus.isGranted || permissionStatus.isLimited;
  }

  Future<void> requestNotificationHome({bool forceRequest = false}) async {
    // Đã cấp quyền thông báo hoặc đã từng yêu cầu quyền thông báo
    if (await checkNotificationPermission()) {
      return;
    }
    if (!forceRequest && Global.instance.isRequestNotification) {
      return;
    }

    Global.instance.isRequestNotification = true;
    final isPermanentlyDenied =
        await Permission.notification.isPermanentlyDenied;
    if (isPermanentlyDenied) {
      // Nếu đã từ chối quyền thông báo vĩnh viễn thì show dialog yêu cầu mở cài đặt
      NotificationPermissionDialog.show();
    } else {
      // Nếu chưa từ chối quyền thông báo thì yêu cầu quyền
      final PermissionStatus permissionStatus =
          await Permission.notification.request();
      if (permissionStatus.isLimited || permissionStatus.isGranted) {
        DefaultAppChecker.showFunctionNotification();
        NotificationService.instance.init();
      }
    }
  }
}
