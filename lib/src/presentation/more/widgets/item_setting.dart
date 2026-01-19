import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../shared/constants/app_colors.dart';
import '../../../shared/utils/style_utils.dart';

class ItemSetting extends StatelessWidget {
  const ItemSetting({
    super.key,
    required this.text,
    this.icon,
    required this.onTap,
    this.divider = true,
  });

  final String text;
  final String? icon;
  final VoidCallback? onTap;
  final bool divider;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 14),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (icon != null)
                  Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: SvgPicture.asset(
                      icon!,
                      width: 20,
                    ),
                  ),
                Expanded(
                  child: Text(
                    text,
                    style: StyleUtils.style.s16.medium.b75,
                  ),
                ),
                const Icon(
                  Icons.arrow_forward_ios,
                  size: 20,
                  color: AppColors.b15,
                ),
              ],
            ),
          ),
          if (divider)
            const Padding(
              padding: EdgeInsets.only(left: 40, right: 16),
              child: Divider(
                color: AppColors.b7,
                height: 0,
              ),
            )
        ],
      ),
    );
  }
}
