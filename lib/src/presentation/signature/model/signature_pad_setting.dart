import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../utils/converter/color_converter.dart';
import '../utils/signature_pad_controller.dart';

part 'signature_pad_setting.freezed.dart';
part 'signature_pad_setting.g.dart';

@freezed
abstract class SignaturePadSetting with _$SignaturePadSetting {
  const factory SignaturePadSetting({
    @Default(0.1 * maxStrokeWidth) double strokeWidth,
    @ColorConverter() @Default(Colors.black) Color signColor,
    @ColorListConverter()
    @Default([
      Colors.black,
      Color(0xffE62238),
      Color(0xff0000FE),
      Color(0xff27AE60),
    ])
    List<Color> recentColors,
  }) = _SignaturePadSetting;

  factory SignaturePadSetting.fromJson(Map<String, dynamic> json) =>
      _$SignaturePadSettingFromJson(json);
}
