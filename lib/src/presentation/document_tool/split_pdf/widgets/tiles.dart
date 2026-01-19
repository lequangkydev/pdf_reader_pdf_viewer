import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../gen/colors.gen.dart';

class LoadingTile extends StatelessWidget {
  const LoadingTile({super.key});

  @override
  Widget build(BuildContext context) => DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Theme.of(context).colorScheme.surfaceVariant,
        ),
        child: const Center(child: CircularProgressIndicator(strokeWidth: 2)),
      );
}

class ShimmerTile extends StatelessWidget {
  const ShimmerTile({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade100,
        highlightColor: Colors.grey.shade50,
        child: Container(
          color: MyColors.adBackground,
        ),
      ),
    );
  }
}

class BrokenTile extends StatelessWidget {
  const BrokenTile({super.key});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Theme.of(context).colorScheme.error,
        ),
      ),
      child: const Center(
        child: Icon(Icons.broken_image_outlined, size: 20),
      ),
    );
  }
}
