import 'package:flutter/material.dart';

import '../../gen/assets.gen.dart';

enum SuccessType {
  pdf,
  scan,
  photo,
}

extension SuccessTypeExtension on SuccessType {
  Widget get lottie {
    switch (this) {
      case SuccessType.pdf:
        return Assets.lotties.pdf.lottie(width: 180);
      case SuccessType.photo:
        return Assets.lotties.photo.lottie(width: 180);
      case SuccessType.scan:
        return Assets.lotties.scan.lottie(width: 180);
    }
  }
}
