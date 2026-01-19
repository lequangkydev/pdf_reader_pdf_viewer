import 'screen_event_enum.dart';

// ignore_for_file: constant_identifier_names
enum LanguageEvent implements AppEvent {
  Enter_Screen,
  Select_ITEM_Language,
  Select_BTN_Select,
  Click_Ads_Language,
  Click_Ads_Select,
  Reopen_after_ads_language,
  Reopen_after_ads_select;

  @override
  String get eventName => name;
  @override
  String get screenName => 'Lang_Scr';
}
