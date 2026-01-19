import 'package:flutter/material.dart';

import '../../../../src/gen/assets.gen.dart';
import 'utils.dart';

class EyeDropperOverlay extends StatelessWidget {
  const EyeDropperOverlay({
    super.key,
    required this.color,
    this.overlayColor,
  });

  final Color color;
  final Color? overlayColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: kOverlaySize.height,
      width: kOverlaySize.width,
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                width: kEyeDropperSize * 4,
                height: kEyeDropperSize * 4,
                alignment: Alignment.bottomRight,
                child: Assets.images.colorPickerOverlay.image(
                  fit: BoxFit.fitHeight,
                  color: overlayColor,
                  width: kEyeDropperSize * 4,
                  height: kEyeDropperSize * 4,
                ),
              ),
              Positioned(
                top: 4,
                left: 6,
                right: 6,
                child: CircleAvatar(
                  backgroundColor: color,
                  radius: 22,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Container(
            height: kEyeDropperSize,
            width: kEyeDropperSize,
            decoration: BoxDecoration(
                color: color,
                border: Border.all(color: overlayColor ?? Colors.black45),
                borderRadius: BorderRadius.circular(16)),
          ),
        ],
      ),
    );
  }
}
