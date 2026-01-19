import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../shared/constants/app_colors.dart';
import '../cubit/signature_pad_setting_cubit.dart';
import '../utils/signature_pad_controller.dart';

class SignWidthBottomSheet extends StatefulWidget {
  const SignWidthBottomSheet({
    super.key,
    required this.parentContext,
    required this.value,
  });

  final BuildContext parentContext;
  final double value;

  static void show({
    required BuildContext context,
    required double value,
  }) {
    showBottomSheet(
      context: context,
      constraints: BoxConstraints(
        maxWidth: 1.sw,
      ),
      builder: (_) {
        return SignWidthBottomSheet(
          parentContext: context,
          value: value,
        );
      },
    );
  }

  @override
  State<SignWidthBottomSheet> createState() => _SignWidthBottomSheetState();
}

class _SignWidthBottomSheetState extends State<SignWidthBottomSheet> {
  late double ratio = widget.value;

  SignaturePadController get controller =>
      widget.parentContext.read<SignaturePadController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 33, vertical: 8).r,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.r),
            topRight: Radius.circular(20.r),
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Container(
                  width: 32.r,
                  height: 3.r,
                  decoration: BoxDecoration(
                    color: AppColors.colorE6E6E6,
                    borderRadius: BorderRadius.circular(3.r),
                  ),
                ),
              ),
              SizedBox(height: 12.r),
              const Text(
                'Width',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16).r,
                child: Row(
                  children: [
                    Expanded(
                      child: Theme(
                        data: ThemeData(
                          sliderTheme: SliderThemeData(
                            trackShape: const _SliderTrack(),
                            thumbShape: const _SliderThumbShape(),
                            trackHeight: 4.r,
                            overlayShape: SliderComponentShape.noOverlay,
                          ),
                          primaryColor: AppColors.pr,
                        ),
                        child: Slider(
                          value: ratio,
                          onChangeEnd: updateValue,
                          onChanged: updateValue,
                        ),
                      ),
                    ),
                    SizedBox(width: 16.r),
                    Text(
                      '${(ratio * maxStrokeWidth).toInt()}',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppColors.b25,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void updateValue(double value) {
    widget.parentContext.read<SignaturePadSettingCubit>().setWidthRatio(ratio);
    setState(() {
      ratio = value;
    });
  }
}

double get thumbRadius => 10.r;

class _SliderTrack extends SliderTrackShape with BaseSliderTrackShape {
  const _SliderTrack();

  @override
  void paint(
    PaintingContext context,
    Offset offset, {
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required Animation<double> enableAnimation,
    required TextDirection textDirection,
    required Offset thumbCenter,
    bool isDiscrete = false,
    bool isEnabled = false,
    double additionalActiveTrackHeight = 2,
    Offset? secondaryOffset,
  }) {
    final trackRect = getPreferredRect(
      parentBox: parentBox,
      offset: offset,
      sliderTheme: sliderTheme,
      isEnabled: isEnabled,
      isDiscrete: isDiscrete,
    );
    final isRTL = textDirection == TextDirection.rtl;

    context.canvas.drawRRect(
      RRect.fromRectAndRadius(
        trackRect,
        const Radius.circular(10).r,
      ),
      Paint()..color = isRTL ? AppColors.pr : AppColors.b10,
    );
    context.canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(
          trackRect.left,
          trackRect.top,
          thumbCenter.dx - thumbRadius * 2,
          trackRect.height,
        ),
        const Radius.circular(10).r,
      ),
      Paint()..color = isRTL ? AppColors.b10 : AppColors.pr,
    );
  }
}

class _SliderThumbShape extends RoundSliderThumbShape {
  const _SliderThumbShape();

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    required bool isDiscrete,
    required TextPainter labelPainter,
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required TextDirection textDirection,
    required double value,
    required double textScaleFactor,
    required Size sizeWithOverflow,
  }) {
    context.canvas.drawCircle(
      center,
      thumbRadius.r,
      Paint()..color = AppColors.pr,
    );
    context.canvas.drawCircle(
      center,
      thumbRadius.r - 4.r,
      Paint()..color = Colors.white,
    );
  }
}
