import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../shared/constants/app_colors.dart';

class SignPadBackgroudPainter extends CustomPainter {
  SignPadBackgroudPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.b10
      ..strokeWidth = 1.5.r
      ..style = PaintingStyle.stroke;
    final radius = 12.r;

    final path = Path()
      ..addRRect(RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, size.width, size.height),
        Radius.circular(radius),
      ));

    // Tạo dashed path bằng cách rời các đoạn trên đường đi
    final dashPath = _createDashedPath(path, 5, 5);
    canvas.drawPath(dashPath, paint);

    // vẽ background
    canvas.drawRRect(
      RRect.fromRectAndRadius(Rect.fromLTRB(0, 0, size.width, size.height),
          Radius.circular(radius)),
      Paint()..color = AppColors.b2,
    );

    // vẽ đường kẻ ngang
    final linePaint = Path()
      ..moveTo(0, size.height * 3 / 4)
      ..lineTo(size.width, size.height * 3 / 4);
    final linePath = _createDashedPath(linePaint, 5, 5);
    canvas.drawPath(linePath, paint);
  }

  Path _createDashedPath(Path source, double dashLen, double gapLen) {
    final Path dest = Path();
    for (final PathMetric pathMetric in source.computeMetrics()) {
      double distance = 0.0;
      while (distance < pathMetric.length) {
        final double currentLength = dashLen;
        dest.addPath(
          pathMetric.extractPath(
            distance,
            distance + currentLength.clamp(0, pathMetric.length - distance),
          ),
          Offset.zero,
        );
        distance += dashLen + gapLen;
      }
    }
    return dest;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
