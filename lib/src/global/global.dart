import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:receive_sharing_intent/receive_sharing_intent.dart';
import 'package:upgrader/upgrader.dart';

import '../shared/constants/app_colors.dart';

class Global {
  Global._privateConstructor();

  static final Global instance = Global._privateConstructor();
  static final String defaultLocale = Platform.localeName;
  PackageInfo? packageInfo;
  String documentPath = '';
  String temporaryPath = '';
  int androidSdkVersion = 0;
  bool isExitApp = false;
  bool initEasyLoading = false;
  bool isFullAds = false;
  bool fromIntro = false;
  SharedMediaFile? sharedFiles;
  bool isShowOnceDefault = true;
  String? recentFilePath;
  String? notificationAction;
  Upgrader? upgrader;
  bool isRequestNotification = false;
  bool viewFile = false;
  bool initializedSplash = false;
  String? currentRouteName;
}

void showToast(
  String mess, {
  ToastGravity? toastGravity,
  Toast? toastLength,
  Color? colorBg,
  Color? colorText,
}) {
  Fluttertoast.showToast(
    msg: mess,
    toastLength: toastLength ?? Toast.LENGTH_SHORT,
    gravity: toastGravity ?? ToastGravity.BOTTOM,
    backgroundColor: colorBg ?? AppColors.pr,
    textColor: colorText ?? Colors.white,
    fontSize: 16.0,
  );
}
