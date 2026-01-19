import 'package:flutter/material.dart';

import '../../gen/assets.gen.dart';
import '../constants/app_colors.dart';
import '../extension/context_extension.dart';

class EmptyData extends StatelessWidget {
  const EmptyData({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Assets.lotties.search.lottie(width: 120),
          Text(
            context.l10n.noDocumentFound,
            style: const TextStyle(
              color: AppColors.color80,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          )
        ],
      ),
    );
  }
}
