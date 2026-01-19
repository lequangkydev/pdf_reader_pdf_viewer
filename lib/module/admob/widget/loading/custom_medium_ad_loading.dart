import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import 'custom_placeholder.dart';

class CustomMediumAdLoading extends StatelessWidget {
  const CustomMediumAdLoading({
    super.key,
    this.height,
    this.padding,
    this.isSmall = false,
  });

  final double? height;
  final EdgeInsetsGeometry? padding;
  final bool isSmall;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      padding: padding,
      width: 1.sw,
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: Container(
          height: height,
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Expanded(
                            child: CustomPlaceholder(
                              width: double.infinity,
                              height: 18,
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Expanded(
                            child: CustomPlaceholder(
                              width: double.infinity,
                              height: 18,
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Expanded(
                            child: CustomPlaceholder(
                              width: double.infinity,
                              height: 18,
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Expanded(
                            child: CustomPlaceholder(
                              width: double.infinity,
                              height: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    CustomPlaceholder(
                      width: 0.4.sw,
                      height: double.infinity,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 6,
              ),
              if (!isSmall)
                CustomPlaceholder(
                  width: 1.sw,
                  height: 40,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
