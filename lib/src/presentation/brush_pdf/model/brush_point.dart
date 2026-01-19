import 'dart:ui';

class BrushPoint {
  BrushPoint({
    required this.points,
    required this.currentPage,
    required this.id,
    required this.pdfPoints,
  });

  final List<BrushOffsetState> points;
  final List<Offset> pdfPoints;
  final int currentPage;
  final String id;

  BrushPoint copyWith({
    List<BrushOffsetState>? points,
    List<Offset>? pdfPoints,
  }) {
    return BrushPoint(
      currentPage: currentPage,
      id: id,
      points: points ?? this.points,
      pdfPoints: pdfPoints ?? this.pdfPoints,
    );
  }
}

class BrushOffsetState {
  BrushOffsetState({
    required this.point,
    required this.color,
    required this.strokeWidth,
  });

  final Offset point;
  final Color color;
  final double strokeWidth;
}
