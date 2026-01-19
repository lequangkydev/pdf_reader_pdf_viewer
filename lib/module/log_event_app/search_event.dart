import 'screen_event_enum.dart';

// ignore_for_file: constant_identifier_names
enum SearchEvent implements AppEvent {
  user_enter_character,
  user_click_back_search,
  user_open_file_search,
  user_click_icon_bookmark,
  user_click_icon_additional_options;

  @override
  String get eventName => name;
  @override
  String get screenName => 'SearchScreen';
}
