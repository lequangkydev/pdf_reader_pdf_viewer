import 'screen_event_enum.dart';

// ignore_for_file: constant_identifier_names
enum MergePdfEvent implements AppEvent {
  user_select_file_merge,
  user_click_search_merge,
  user_click_back_merge,
  user_click_continue_notSelect,
  user_click_continue_selected,
  user_click_add_file_merge,
  user_click_remove_file_merge,
  user_click_button_merge,
  user_press_move_file;

  @override
  String get eventName => name;
  @override
  String get screenName => 'MergePdfScreen';
}
