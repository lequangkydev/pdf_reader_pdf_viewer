import 'screen_event_enum.dart';

// ignore_for_file: constant_identifier_names
enum BookmarkEvent implements AppEvent {
  user_click_all_bookmark,
  user_click_pdf_bookmark,
  user_click_doc_bookmark,
  user_click_xlsx_bookmark,
  user_click_ppt_bookmark,
  user_click_open_file_bookmark,
  user_click_icon_bookmark_bookmark,
  user_click_icon_expand_bookmark;

  @override
  String get eventName => name;
  @override
  String get screenName => 'BookmarkScreen';
}
