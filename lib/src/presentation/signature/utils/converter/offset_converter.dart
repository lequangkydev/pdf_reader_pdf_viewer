import 'dart:ui';

import 'package:freezed_annotation/freezed_annotation.dart';

class OffsetConverter implements JsonConverter<Offset, List<double>> {
  const OffsetConverter();

  @override
  Offset fromJson(List<double> json) {
    return Offset(json[0], json[1]);
  }

  @override
  List<double> toJson(Offset offset) {
    return [offset.dx, offset.dy];
  }
}

class ListOffsetConverter
    implements JsonConverter<List<Offset>, List<List<double>>> {
  const ListOffsetConverter();

  @override
  List<Offset> fromJson(List<List<double>> json) {
    return json.map((e) => const OffsetConverter().fromJson(e)).toList();
  }

  @override
  List<List<double>> toJson(List<Offset> offsets) {
    return offsets.map((e) => const OffsetConverter().toJson(e)).toList();
  }
}
