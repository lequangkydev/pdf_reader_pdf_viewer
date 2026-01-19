import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

class CustomRadio<T> extends StatelessWidget {
  const CustomRadio({
    super.key,
    this.color,
    this.isSelected = false,
  });

  final Color? color;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    final customColor = color ?? AppColors.pr;
    return Container(
      width: 18,
      height: 18,
      padding: const EdgeInsets.all(3.5),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          width: 1.5,
          color: customColor,
        ),
      ),
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        switchOutCurve: Curves.ease,
        switchInCurve: Curves.ease,
        child: isSelected
            ? CircleAvatar(
                backgroundColor: customColor,
                radius: 6,
              )
            : const SizedBox(),
      ),
    );
  }
}
