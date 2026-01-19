import 'dart:ui';

import 'package:flutter/material.dart';

import '../model/brush_point.dart';

class BrushPainter extends CustomPainter {
  BrushPainter({
    required this.points,
    required this.isRTL,
  });

  final List<BrushOffsetState> points;
  final bool isRTL;

  @override
  void paint(Canvas canvas, Size size) {
    if (isRTL) {
      canvas.translate(size.width, 0);
      canvas.scale(-1, 1);
    }

    for (int i = 0; i < points.length - 1; i++) {
      final pointColor = points[i].color;
      final pointStrokeWidth = points[i].strokeWidth;
      final paint = Paint()
        ..color = pointColor
        ..strokeCap = StrokeCap.round
        ..strokeWidth = pointStrokeWidth;
      if (points[i].point != Offset.zero &&
          points[i + 1].point != Offset.zero) {
        canvas.drawLine(points[i].point, points[i + 1].point, paint);
      }
    }
  }

  @override
  bool shouldRepaint(BrushPainter oldDelegate) => true;
}
