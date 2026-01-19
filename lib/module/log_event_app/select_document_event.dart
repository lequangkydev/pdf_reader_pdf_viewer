import 'screen_event_enum.dart';

// ignore_for_file: constant_identifier_names
enum SelectDocumentEvent implements AppEvent {
  user_select_all_file,
  user_unSelect_all_file,
  user_select_file,
  user_click_back_select,
  user_click_share_notSelect,
  user_click_share_selected,
  user_click_delete_notSelect,
  user_click_delete_selected;

  @override
  String get eventName => name;
  @override
  String get screenName => 'SelectDocumentScreen';
}
