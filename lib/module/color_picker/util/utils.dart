import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

/// shortcuts to manipulate [Color]
extension Utils on Color {
  HSLColor get hsl => HSLColor.fromColor(this);

  double get lightness => hsl.lightness;

  String get hex =>
      value.toRadixString(16).padLeft(8, '0').replaceRange(0, 2, '');
}
