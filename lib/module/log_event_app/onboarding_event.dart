import 'screen_event_enum.dart';

// ignore_for_file: constant_identifier_names
enum OnboardingEvent implements AppEvent {
  click_nativeintro1,
  reopen_after_ads_intro1,
  click_nativeintro2,
  reopen_after_ads_intro2,
  click_nativeintro3,
  reopen_after_ads_intro3,
  click_nativeintro4,
  reopen_after_ads_intro4,
  enter_intro1,
  swipe_intro1,
  next_intro1,
  enter_intro2,
  swipe_intro2,
  next_intro2,
  enter_intro3,
  swipe_intro3,
  next_intro3,
  swipe_intro4,
  next_intro4,
  Intro_Vew_INTER_INTRO,
  Intro_Click_INTER_INTRO,
  Intro_Reopen_after_ads_inter_INTRO;

  @override
  String get eventName => name;

  @override
  String get screenName => 'Intro_Scr';
}
