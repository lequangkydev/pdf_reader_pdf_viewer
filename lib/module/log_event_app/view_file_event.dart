import 'screen_event_enum.dart';

// ignore_for_file: constant_identifier_names
enum ViewFileEvent implements AppEvent {
  user_click_back_view_file,
  user_click_icon_additional_options;

  @override
  String get eventName => name;
  @override
  String get screenName => 'ViewFileScreen';
}
