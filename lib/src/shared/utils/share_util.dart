import 'dart:io';

import 'package:flutter_ads/ads_flutter.dart';
import 'package:share_plus/share_plus.dart';

import '../../config/di/di.dart';
import '../../config/navigation/app_router.dart';
import '../../services/default_app_checker.dart';
import '../constants/app_constants.dart';
import '../extension/context_extension.dart';

class ShareUtil {
  ShareUtil._();

  static bool _isSharing = false;

  static String appLink =
      Platform.isAndroid ? AppConstants.appAndroidUrl : AppConstants.appIOSUrl;

  static Future<void> shareFiles(List<XFile> files) async {
    if (_isSharing) {
      return; // chặn spam
    }
    _isSharing = true;
    final currentCtx = getIt<AppRouter>().navigatorKey.currentContext;
    if (currentCtx == null) {
      return;
    }
    try {
      DefaultAppChecker.blockNotify();
      MyAds.instance.appLifecycleReactor?.setIsExcludeScreen(true);

      await Share.shareXFiles(
        files,
        text: currentCtx.l10n.shareMessage(AppConstants.appName, appLink),
      );
    } finally {
      DefaultAppChecker.unBlockNotify();
      _isSharing = false;
    }
  }

  static Future<void> shareApp() async {
    if (_isSharing) {
      return;
    }
    _isSharing = true;

    try {
      DefaultAppChecker.blockNotify();
      MyAds.instance.appLifecycleReactor?.setIsExcludeScreen(true);

      final String appLink = Platform.isAndroid
          ? AppConstants.appAndroidUrl
          : AppConstants.appIOSUrl;
      await Share.share(appLink);
    } finally {
      DefaultAppChecker.unBlockNotify();
      _isSharing = false;
    }
  }
}
