import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import 'custom_placeholder.dart';

class BannerAdLoading extends StatelessWidget {
  const BannerAdLoading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      color: Colors.white,
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              CustomPlaceholder(
                width: 36,
                height: 36,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomPlaceholder(
                      height: 12,
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    CustomPlaceholder(
                      width: 100,
                      height: 12,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
