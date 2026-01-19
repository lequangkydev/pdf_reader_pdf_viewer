import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../module/color_picker/color_picker.dart';
import '../../../gen/assets.gen.dart';
import '../../../shared/constants/app_colors.dart';

class ColorPickerButton extends StatefulWidget {
  const ColorPickerButton({
    super.key,
    required this.context,
    required this.onTap,
    required this.onPickedColor,
    this.color,
  });

  final BuildContext context;
  final VoidCallback? onTap;
  final void Function(Color color)? onPickedColor;
  final Color? color;

  @override
  State<ColorPickerButton> createState() => _ColorPickerButtonState();
}

class _ColorPickerButtonState extends State<ColorPickerButton> {
  late final ValueNotifier<Color?> color = ValueNotifier(widget.color);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        widget.onTap?.call();
        final Color? pickerColor = await showColorPicker(
          context: context,
          selectedColor: color.value,
        );
        if (pickerColor != null && context.mounted) {
          color.value = pickerColor;
          widget.onPickedColor?.call(pickerColor);
        }
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          buildImage(
            image: Assets.images.colorPicker,
          ),
          ValueListenableBuilder(
            valueListenable: color,
            builder: (context, value, child) {
              if (value == null) {
                return const SizedBox();
              }
              return Positioned(
                top: 6.r,
                left: 6.r,
                bottom: 6.r,
                right: 6.r,
                child: Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.whiteSmoke,
                  ),
                  padding: EdgeInsets.all(3.r),
                  child: CircleAvatar(
                    backgroundColor: value,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget buildImage({
    required AssetGenImage image,
  }) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: AppColors.cerebralGrey.withOpacity(0.2),
            spreadRadius: 1.r,
            blurRadius: 5.r,
          )
        ],
      ),
      padding: EdgeInsets.all(2.r),
      child: image.image(fit: BoxFit.cover),
    );
  }
}
