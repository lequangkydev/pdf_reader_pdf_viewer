import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../gen/colors.gen.dart';
import '../constants/app_colors.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({
    super.key,
    required this.onTap,
    required this.child,
    this.padding,
    this.color,
    this.radius,
  });

  final VoidCallback onTap;
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final Color? color;
  final double? radius;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: padding ?? EdgeInsets.symmetric(vertical: 12.h),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius ?? 12.h),
            color: color ?? AppColors.pr,
            boxShadow: [
              BoxShadow(
                  blurRadius: 10,
                  color: (color ?? AppColors.pr).withOpacity(0.25),
                  offset: const Offset(0, 2))
            ]),
        child: Center(child: child),
      ),
    );
  }
}
