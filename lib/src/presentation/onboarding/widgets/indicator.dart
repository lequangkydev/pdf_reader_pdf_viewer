import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../shared/constants/app_colors.dart';
import '../../../shared/extension/number_extension.dart';

class CustomIndicator extends StatelessWidget {
  const CustomIndicator({
    super.key,
    required this.length,
    required this.currentIndex,
  });

  final int length;
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 8,
      child: ListView.separated(
        itemBuilder: (context, index) =>
            indicator(context, index == currentIndex),
        separatorBuilder: (context, index) => 8.r.hSpace,
        itemCount: length,
        physics: const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
      ),
    );
  }

  Widget indicator(BuildContext context, bool isActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: 8.r,
      width: isActive ? 20.r : 8.r,
      decoration: BoxDecoration(
        color: isActive ? AppColors.pr : AppColors.pr.withOpacity(0.4),
        borderRadius: BorderRadius.circular(6).r,
      ),
    );
  }
}
