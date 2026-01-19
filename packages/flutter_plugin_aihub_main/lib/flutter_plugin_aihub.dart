import 'dart:io';

import 'package:flutter/services.dart';

class FlutterPluginAihub {
  static const _channel = MethodChannel("flutter_plugin_aihub");

  static Future<bool> init({
    required String baseUrl,
    required String appId,
    required String secretKey,
  }) async {
    final result = await _channel.invokeMethod("init", {
      "baseUrl": baseUrl,
      "appId": appId,
      "secretKey": secretKey,
    });
    return result == true;
  }

  static Future<Map<String, dynamic>?> getApiToken() async {
    final result = await _channel.invokeMethod("getApiToken");
    if (result == null) return null;
    return Map<String, dynamic>.from(result);
  }

  /// --- PDF Summary ---
  static Future<Map<String, dynamic>?> pdfSummary({
    required String token,
    required File file,
    required String language,
    required String summaryType,
    required String action,
    String uuid = "1212",
  }) async {
    final result = await _channel.invokeMethod("pdfSummary", {
      "token": token,
      "filePath": file.path,
      "language": language,
      "summaryType": summaryType,
      "action": action,
      "uuid": uuid,
    });
    return result != null ? Map<String, dynamic>.from(result) : null;
  }
}
