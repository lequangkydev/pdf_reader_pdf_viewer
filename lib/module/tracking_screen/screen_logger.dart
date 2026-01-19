import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' show toBeginningOfSentenceCase;

import '../../src/global/global.dart';
import '../log_event_app/screen_event_enum.dart';

class AnalyticLogger {
  AnalyticLogger._();

  static final AnalyticLogger instance = AnalyticLogger._();

  Future<void> logScreen(String name) async {
    await FirebaseAnalytics.instance
        .logScreenView(screenName: name, screenClass: name);
  }

  void logEventWithScreen({
    required AppEvent event,
    Map<String, Object>? parameters,
  }) {
    final eventName =
        'V${Global.instance.packageInfo?.buildNumber}_${event.screenName}_${event.eventName}';
    if (eventName.length > 40) {
      debugPrint("> max");
    }
    try {
      FirebaseAnalytics.instance.logEvent(
        name: eventName,
        parameters: parameters,
      );
    } catch (error) {
      debugPrint('Error log event:$error');
    }
  }

  void logEvent({
    required AppEvent event,
    Map<String, Object>? parameters,
  }) {
    final eventName =
        'V${Global.instance..packageInfo?.buildNumber}_${event.eventName}';
    if (eventName.length > 40) {
      debugPrint('Max');
    }
    try {
      FirebaseAnalytics.instance.logEvent(
        name: eventName,
        parameters: parameters,
      );
    } catch (error) {
      debugPrint('Error log event:$error');
    }
  }

  Future<void> logCustomScreen(CustomScreenName screenName) async {
    await logScreen(screenName.customName);
  }
}

enum CustomScreenName {
  languageScreen,
  languageSelectScreen,
  intro1Screen,
  intro2Screen,
  intro3Screen,
}

extension CustomScreenNameExt on CustomScreenName {
  String get customName => toBeginningOfSentenceCase(name);
}
