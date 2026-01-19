import 'package:flutter/material.dart';

import '../../../gen/assets.gen.dart';

class IndicatorLoading extends StatelessWidget {
  const IndicatorLoading({super.key, this.width});
  final double? width;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Assets.lotties.loading.lottie(width: width ?? 100),
    );
  }
}
