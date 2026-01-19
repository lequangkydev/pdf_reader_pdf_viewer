import 'screen_event_enum.dart';

// ignore_for_file: constant_identifier_names
enum PdfToImageEvent implements AppEvent {
  user_select_file_toImage,
  user_click_search_toImage,
  user_click_back_to_image,
  user_select_separate_image,
  user_select_long_image,
  user_click_icon_convert_image;

  @override
  String get eventName => name;
  @override
  String get screenName => 'PdfToImageScreen';
}
