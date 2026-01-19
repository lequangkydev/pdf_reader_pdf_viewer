import 'dart:ui';

import '../../presentation/signature/model/stroke.dart';

extension OffsetExtension on Offset {
  Point toPoint() {
    return Point(dx: dx, dy: dy);
  }
}
