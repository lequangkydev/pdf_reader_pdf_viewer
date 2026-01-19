import 'stroke.dart';

class NormalizedSignature {
  NormalizedSignature({
    required this.strokes,
    required this.width,
    required this.height,
  });

  final List<Stroke> strokes;
  final double width;
  final double height;
}
