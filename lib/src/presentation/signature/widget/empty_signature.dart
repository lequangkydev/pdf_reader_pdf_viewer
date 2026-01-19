import 'package:flutter/material.dart';

import '../../../gen/assets.gen.dart';
import '../../../shared/extension/context_extension.dart';
import '../../../shared/extension/number_extension.dart';

class EmptySignature extends StatelessWidget {
  const EmptySignature({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Assets.images.signature.image(width: 150),
        10.vSpace,
        Text(
          context.l10n.noSignature,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        Text(
          context.l10n.createSignature,
          style: const TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
