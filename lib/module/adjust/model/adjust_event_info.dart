class AdjustEventInfo {
  AdjustEventInfo({
    this.name,
    this.time,
  });

  final String? name;
  final String? time;

  factory AdjustEventInfo.fromJson(Map<String, dynamic> json) {
    return AdjustEventInfo(
      name: json['name'] as String?,
      time: json['time'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'time': time,
    };
  }
}
