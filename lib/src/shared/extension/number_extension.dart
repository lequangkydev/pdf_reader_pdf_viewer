import 'package:flutter/cupertino.dart';

extension NumberExtension on num {
  SizedBox get vSpace => SizedBox(
        height: toDouble(),
      );

  SizedBox get hSpace => SizedBox(
        width: toDouble(),
      );

  String get convertByte {
    if (this < 1024) {
      return '$this bytes'; // Nếu < 1 KB
    } else if (this < 1024 * 1024) {
      return '${this ~/ 1024} KB'; // Nếu < 1 MB
    } else if (this < 1024 * 1024 * 1024) {
      return '${this ~/ (1024 * 1024)} MB'; // Nếu >= 1 MB
    } else {
      return '${this ~/ (1024 * 1024 * 1024)} GB'; // Nếu >= 1 GB
    }
  }
}

extension IntExtension on int {
  AdDisplayType get adDisplayType {
    if (this < 0 || this >= AdDisplayType.values.length) {
      return AdDisplayType.noMedia;
    }
    return AdDisplayType.values[this];
  }
}

enum AdDisplayType {
  hidden,
  noMedia,
  hasMedia,
  fullScreen,
  noMediaRight,
}
