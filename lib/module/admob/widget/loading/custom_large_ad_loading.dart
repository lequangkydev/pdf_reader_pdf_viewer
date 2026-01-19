import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import 'custom_placeholder.dart';

class CustomLargeAdLoading extends StatelessWidget {
  const CustomLargeAdLoading({
    super.key,
    this.height,
    this.padding,
  });

  final double? height;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      padding: padding,
      width: 1.sw,
      color: Colors.white,
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: Container(
          height: 272,
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  CustomPlaceholder(
                    width: 42,
                    height: 42,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        CustomPlaceholder(
                          width: double.infinity,
                          height: 18,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        CustomPlaceholder(
                          width: double.infinity,
                          height: 18,
                        ),
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: CustomPlaceholder(
                  width: 0.7.sw,
                  height: double.infinity,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
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
