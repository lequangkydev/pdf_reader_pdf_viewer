import 'screen_event_enum.dart';

// ignore_for_file: constant_identifier_names
enum BottomSheetEvent implements AppEvent {
  user_click_bookmark,
  user_click_print,
  user_click_rename,
  user_click_merge,
  user_click_split,
  user_click_convert,
  user_click_lock,
  user_click_unLock,
  user_click_detail,
  user_click_share,
  user_click_delete,
  user_click_open;

  @override
  String get eventName => name;
  @override
  String get screenName => 'BottomSheetActionFile';
}
