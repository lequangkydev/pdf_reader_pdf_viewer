import 'screen_event_enum.dart';

// ignore_for_file: constant_identifier_names
enum HomeEvent implements AppEvent {
  user_click_merge_pdf,
  user_click_split_pdf,
  user_click_unlock_pdf,
  user_click_lock_pdf,
  user_click_scan_pdf,
  user_click_pdf_to_image,
  click_pdf_to_LImage,
  user_click_pdf_home,
  user_click_doc_home,
  user_click_xlsx_home,
  user_click_ppt_home;

  @override
  String get eventName => name;
  @override
  String get screenName => 'HomeScreen';
}
