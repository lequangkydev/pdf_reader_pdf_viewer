import 'dart:ui';

import 'package:freezed_annotation/freezed_annotation.dart';

class ColorConverter implements JsonConverter<Color, int> {
  const ColorConverter();

  @override
  Color fromJson(int json) => Color(json);

  @override
  int toJson(Color color) => color.value;
}

class ColorListConverter implements JsonConverter<List<Color>, List<int>> {
  const ColorListConverter();

  @override
  List<Color> fromJson(List<int> json) =>
      json.map((e) => Color(e)).toList(growable: false);

  @override
  List<int> toJson(List<Color> color) => color.map((e) => e.value).toList();
}
