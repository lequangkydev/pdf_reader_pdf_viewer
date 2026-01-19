import 'screen_event_enum.dart';

// ignore_for_file: constant_identifier_names
enum ScanPdfEvent implements AppEvent {
  user_start_scan,
  user_save_file;

  @override
  String get eventName => name;
  @override
  String get screenName => 'ScanPdfScreen';
}
