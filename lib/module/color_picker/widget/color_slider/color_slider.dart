import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../src/shared/extension/context_extension.dart';
import '../../color_picker.dart';
import '../opacity_slider/opacity_slider_thumb.dart';
import 'color_slider_track.dart';

enum ColorType {
  red(Color(0xffFF0000)),
  green(Color(0xff00FF00)),
  blue(Color(0xff0101ff));

  const ColorType(this.color);

  final Color color;
}

class ColorSlider extends StatefulWidget {
  const ColorSlider({
    super.key,
    required this.value,
    required this.onChanged,
    required this.colorType,
  });

  final double value;
  final void Function(double value) onChanged;
  final ColorType colorType;

  @override
  State<ColorSlider> createState() => _ColorSliderState();
}

class _ColorSliderState extends State<ColorSlider> {
  late String labelText = switch (widget.colorType) {
    ColorType.red => context.l10n.redOption,
    ColorType.green => context.l10n.greenOption,
    ColorType.blue => context.l10n.blueOption,
  };

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 5.w),
          child: Text(
            labelText.toUpperCase(),
            style: TextStyle(
              color: const Color(0x993C3C43),
              fontWeight: FontWeight.w600,
              fontSize: 12.sp,
            ),
          ),
        ),
        Row(
          children: [
            Expanded(
              child: Theme(
                data: ThemeData(
                    sliderTheme: SliderThemeData(
                  trackHeight: 33.r,
                  thumbColor: Colors.white,
                  trackShape: ColorSliderTrack(widget.colorType.color),
                  thumbShape: () {
                    final convertedValue = (widget.value * 255).toInt();
                    final Color color = switch (widget.colorType) {
                      ColorType.red =>
                        widget.colorType.color.withRed(convertedValue),
                      ColorType.green =>
                        widget.colorType.color.withGreen(convertedValue),
                      ColorType.blue =>
                        widget.colorType.color.withBlue(convertedValue),
                    };
                    return OpacitySliderThumbShape(
                      color,
                      enabledThumbRadius: sliderThumbRadius,
                    );
                  }(),
                )),
                child: Slider(
                  value: widget.value,
                  onChanged: widget.onChanged,
                ),
              ),
            ),
            10.horizontalSpace,
            Container(
              padding: const EdgeInsets.all(8).r,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.r),
                color: Colors.white,
              ),
              width: 70.w,
              child: Text(
                '${(widget.value * 255).toInt()}',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 17.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
