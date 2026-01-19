import 'screen_event_enum.dart';

// ignore_for_file: constant_identifier_names
enum SplitPdfEvent implements AppEvent {
  user_click_file_split,
  user_click_search_split,
  user_click_back_split,
  user_select_page_split,
  user_unSelect_page_split,
  user_click_split_notSelect,
  user_click_split_selected;

  @override
  String get eventName => name;
  @override
  String get screenName => 'SplitPdfScreen';
}
