import 'screen_event_enum.dart';

// ignore_for_file: constant_identifier_names
enum ViewEditPdfEvent implements AppEvent {
  user_click_print_pdf,
  user_click_back_view_pdf,
  user_click_edit_pdf,
  user_click_icon_additional_options,
  user_click_page_view,
  user_click_underlineEdit,
  user_click_strikethrough,
  user_click_highlight,
  user_click_brush,
  user_click_undo_redo,
  user_click_button_save,
  user_select_text;

  @override
  String get eventName => name;
  @override
  String get screenName => 'ViewPdfScreen';
}
