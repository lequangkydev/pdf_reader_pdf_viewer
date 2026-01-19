import 'dart:async';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../src/gen/assets.gen.dart';
import '../../../../src/shared/extension/context_extension.dart';
import '../../color_picker.dart';
import 'opacity_slider_thumb.dart';
import 'opacity_slider_track.dart';

class OpacitySlider extends StatelessWidget {
  const OpacitySlider({
    required this.opacity,
    required this.selectedColor,
    required this.onChange,
    super.key,
  });

  final double opacity;

  final Color selectedColor;

  final ValueChanged<double> onChange;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ui.Image>(
      future: getGridImage(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const SizedBox.shrink();
        }
        return Padding(
          padding: const EdgeInsets.only(top: 4.0).h,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0).w,
                child: Text(
                  context.l10n.opacityOption.toUpperCase(),
                  style: TextStyle(
                    color: const Color(0x993C3C43),
                    fontWeight: FontWeight.w600,
                    fontSize: 12.sp,
                  ),
                ),
              ),
              buildSlider(),
            ],
          ),
        );
      },
    );
  }

  Widget buildSlider() {
    return Row(
      children: [
        Expanded(
          child: Theme(
            data: _opacitySliderTheme(selectedColor.withOpacity(opacity)),
            child: Slider(
              value: opacity,
              onChanged: onChange,
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
            '${(opacity * 100).toInt()}%',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 17.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        )
      ],
    );
  }
}

ui.Image? _gridImage;

Future<ui.Image> getGridImage() {
  if (_gridImage != null) {
    return Future.value(_gridImage!);
  }
  final completer = Completer<ui.Image>();
  Assets.images.grid
      .provider()
      .resolve(ImageConfiguration.empty)
      .addListener(ImageStreamListener((ImageInfo info, bool _) {
    _gridImage = info.image;
    completer.complete(_gridImage);
  }));
  return completer.future;
}

ThemeData _opacitySliderTheme(Color color) => ThemeData.light().copyWith(
      sliderTheme: SliderThemeData(
        trackHeight: sliderThumbRadius * 2 + 4.r,
        thumbColor: Colors.white,
        trackShape: OpacitySliderTrack(color, gridImage: _gridImage!),
        thumbShape: OpacitySliderThumbShape(
          color,
          enabledThumbRadius: sliderThumbRadius,
        ),
      ),
    );
