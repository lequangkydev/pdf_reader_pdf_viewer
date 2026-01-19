import 'screen_event_enum.dart';

// ignore_for_file: constant_identifier_names
enum LockPdfEvent implements AppEvent {
  user_click_file_lock,
  user_click_search_lock,
  user_click_back_lock,
  user_set_password;

  @override
  String get eventName => name;
  @override
  String get screenName => 'LockPdfScreen';
}
