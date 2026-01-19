import 'adjust_event_info.dart';

class AdjustDeviceResponse {
  AdjustDeviceResponse({
    this.adid,
    this.advertisingId,
    this.tracker,
    this.trackerName,
    this.firstTracker,
    this.firstTrackerName,
    this.environment,
    this.clickTime,
    this.installTime,
    this.lastSessionTime,
    this.lastEventsInfo,
    this.lastSdkVersion,
    this.state,
    this.errorMessage,
  });

  final String? adid;
  final String? advertisingId;
  final String? tracker;
  final String? trackerName;
  final String? firstTracker;
  final String? firstTrackerName;
  final String? environment;
  final String? clickTime;
  final String? installTime;
  final String? lastSessionTime;
  final Map<String, AdjustEventInfo>? lastEventsInfo;
  final String? lastSdkVersion;
  final String? state;
  final String? errorMessage;

  factory AdjustDeviceResponse.fromJson(Map<String, dynamic> json) {
    return AdjustDeviceResponse(
      adid: json['Adid'] as String?,
      advertisingId: json['AdvertisingId'] as String?,
      tracker: json['Tracker'] as String?,
      trackerName: json['TrackerName'] as String?,
      firstTracker: json['FirstTracker'] as String?,
      firstTrackerName: json['FirstTrackerName'] as String?,
      environment: json['Environment'] as String?,
      clickTime: json['ClickTime'] as String?,
      installTime: json['InstallTime'] as String?,
      lastSessionTime: json['LastSessionTime'] as String?,
      lastEventsInfo: json['LastEventsInfo'] != null
          ? (json['LastEventsInfo'] as Map<String, dynamic>).map(
              (k, v) => MapEntry(
                  k, AdjustEventInfo.fromJson(v as Map<String, dynamic>)),
            )
          : null,
      lastSdkVersion: json['LastSdkVersion'] as String?,
      state: json['State'] as String?,
      errorMessage: json['ErrorMessage'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Adid': adid,
      'AdvertisingId': advertisingId,
      'Tracker': tracker,
      'TrackerName': trackerName,
      'FirstTracker': firstTracker,
      'FirstTrackerName': firstTrackerName,
      'Environment': environment,
      'ClickTime': clickTime,
      'InstallTime': installTime,
      'LastSessionTime': lastSessionTime,
      'LastEventsInfo': lastEventsInfo?.map((k, v) => MapEntry(k, v.toJson())),
      'LastSdkVersion': lastSdkVersion,
      'State': state,
      'ErrorMessage': errorMessage,
    };
  }
}
