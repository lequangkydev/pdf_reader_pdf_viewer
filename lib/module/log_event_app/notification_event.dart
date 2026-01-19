import 'screen_event_enum.dart';

// ignore_for_file: constant_identifier_names
enum NotificationEvent implements AppEvent {
  show_notify_file_background,
  show_notify_close_app,
  show_notify_new_file,
  show_notify_schedule_after_kill_app,
  open_notify_schedule_after_kill_app,
  open_file_from_new_file,
  open_file_from_recent_file,
  open_notify_from_kill_app,
  user_tap_openBookmark,
  user_tap_openHome,
  user_tap_openTool,
  user_tap_openRecent;

  @override
  String get eventName => name;

  @override
  String get screenName => 'NotificationEvent';
}
