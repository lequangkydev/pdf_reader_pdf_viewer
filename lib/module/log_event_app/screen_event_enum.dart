// ignore_for_file: constant_identifier_names
abstract class AppEvent {
  String get screenName;
  String get eventName;
}

enum OnboardingEvent implements AppEvent {
  intro1_next,
  intro2_next,
  intro3_next;

  @override
  String get eventName => name;
  @override
  String get screenName => 'OnboardingScreen';
}
