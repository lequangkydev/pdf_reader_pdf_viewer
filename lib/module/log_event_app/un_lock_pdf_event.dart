import 'screen_event_enum.dart';

// ignore_for_file: constant_identifier_names
enum UnLockPdfEvent implements AppEvent {
  user_click_file_unlock,
  user_click_search_unlock,
  user_click_back_unlock,
  user_remove_password;

  @override
  String get eventName => name;
  @override
  String get screenName => 'UnLockPdfScreen';
}
