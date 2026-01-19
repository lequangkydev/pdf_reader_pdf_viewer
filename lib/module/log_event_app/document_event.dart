import 'screen_event_enum.dart';

// ignore_for_file: constant_identifier_names
enum DocumentEvent implements AppEvent {
  user_click_all_document,
  user_click_pdf_document,
  user_click_doc_document,
  user_click_xlsx_document,
  user_click_ppt_document,
  user_click_open_file_document,
  user_click_icon_bookmark_document,
  user_click_icon_expand_document,
  user_click_icon_sort_document,
  user_click_icon_select_document, user_click_image_document;

  @override
  String get eventName => name;
  @override
  String get screenName => 'DocumentScreen';
}
