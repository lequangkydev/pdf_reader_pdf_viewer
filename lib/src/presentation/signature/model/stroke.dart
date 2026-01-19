import 'package:flutter/material.dart';

class Stroke {
  Stroke({
    List<Point>? points,
    this.colorValue = 0xFF000000,
    this.strokeWidth = 0.33,
  }) : points = points ?? [];

  final List<Point> points;
  final int colorValue;
  final double strokeWidth;

  Stroke copyWith({
    List<Point>? points,
    int? color,
    double? strokeWidth,
  }) {
    return Stroke(
      points: points ?? this.points,
      colorValue: color ?? colorValue,
      strokeWidth: strokeWidth ?? this.strokeWidth,
    );
  }
}

class Point {
  Point({
    required this.dx,
    required this.dy,
  });

  final double dx;
  final double dy;

  Point copyWith({
    double? x,
    double? y,
  }) {
    return Point(
      dx: x ?? dx,
      dy: y ?? dy,
    );
  }
}
