import 'screen_event_enum.dart';

// ignore_for_file: constant_identifier_names
enum ShellEvent implements AppEvent {
  user_click_tab_home,
  user_click_tab_document,
  user_click_tab_recent,
  user_click_tab_bookmark,
  user_click_setting,
  user_click_box_search,
  user_click_tab_more,
  Enter_FROM_ALL,
  Enter_FROM_Intro,
  Enter_FROM_Splash,
  Enter_FROM_ViewFILE,
  Enter_FROM_Notify,
  Enter_FROM_OTHER_Fun,
  Enter_FROM_PER_AllFile,
  Enter_FROM_PER_AllWay,
  ;

  @override
  String get eventName => name;
  @override
  String get screenName => 'Shell_Scr';
}
