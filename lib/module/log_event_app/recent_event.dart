import 'screen_event_enum.dart';

// ignore_for_file: constant_identifier_names
enum RecentEvent implements AppEvent {
  user_click_all_recent,
  user_click_pdf_recent,
  user_click_doc_recent,
  user_click_xlsx_recent,
  user_click_ppt_recent,
  user_click_open_file_recent,
  user_click_icon_bookmark_recent,
  user_click_icon_expand_recent,
  user_click_icon_sort_recent,
  user_click_icon_select_recent;

  @override
  String get eventName => name;
  @override
  String get screenName => 'RecentScreen';
}
