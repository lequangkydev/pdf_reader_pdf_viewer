import 'screen_event_enum.dart';

// ignore_for_file: constant_identifier_names
enum SuccessfullyEvent implements AppEvent {
  user_click_button_open,
  user_click_button_share,
  user_click_button_go_home;

  @override
  String get eventName => name;
  @override
  String get screenName => 'SuccessfullyScreen';
}
