import 'screen_event_enum.dart';

// ignore_for_file: constant_identifier_names
enum SettingEvent implements AppEvent {
  user_click_language,
  user_click_rate,
  user_click_share,
  user_click_policy,
  user_click_back_setting;

  @override
  String get eventName => name;
  @override
  String get screenName => 'SettingScreen';
}
