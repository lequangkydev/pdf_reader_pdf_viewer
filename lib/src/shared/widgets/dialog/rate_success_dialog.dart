import 'package:flutter/material.dart';

import '../../../gen/assets.gen.dart';
import '../../../gen/colors.gen.dart';
import '../../constants/app_colors.dart';
import '../../extension/context_extension.dart';
import '../../extension/number_extension.dart';

class RateSuccessDialog extends Dialog {
  const RateSuccessDialog(this.context, {super.key});

  final BuildContext context;

  @override
  Widget? get child => Padding(
        padding: const EdgeInsets.symmetric(vertical: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Assets.images.pinkHeart.image(width: 68),
            16.vSpace,
            Text(
              context.l10n.thank,
              style: const TextStyle(
                fontSize: 18,
                color: AppColors.pr,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      );
}
