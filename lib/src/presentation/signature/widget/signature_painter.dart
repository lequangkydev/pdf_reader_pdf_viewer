import 'package:flutter/material.dart';

import '../model/stroke.dart';

class SignaturePainter extends CustomPainter {
  SignaturePainter(this.strokes, this.currentStroke);

  final List<Stroke> strokes;
  final Stroke? currentStroke;

  @override
  void paint(Canvas canvas, Size size) {
    for (final stroke in strokes) {
      _drawStroke(canvas, stroke);
    }

    if (currentStroke != null && currentStroke!.points.length > 1) {
      _drawStroke(canvas, currentStroke!);
    }
  }

  void _drawStroke(Canvas canvas, Stroke stroke) {
    final paint = Paint()
      ..color = Color(stroke.colorValue)
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke.strokeWidth;

    final path = _createSmoothPath(stroke.points);
    canvas.drawPath(path, paint);
  }

  Path _createSmoothPath(List<Point> points) {
    final path = Path();
    if (points.isEmpty) {
      return path;
    }

    path.moveTo(points[0].dx, points[0].dy);
    for (int i = 1; i < points.length - 1; i++) {
      final mid = Offset(
        (points[i].dx + points[i + 1].dx) / 2,
        (points[i].dy + points[i + 1].dy) / 2,
      );
      path.quadraticBezierTo(points[i].dx, points[i].dy, mid.dx, mid.dy);
    }

    if (points.length >= 2) {
      path.lineTo(points.last.dx, points.last.dy);
    }

    return path;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
