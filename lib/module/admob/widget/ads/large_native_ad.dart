import 'package:flutter/material.dart';
import 'package:flutter_ads/ads_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../src/global/global.dart';
import '../../../../src/shared/cubit/ad_visibility_cubit.dart';
import '../../model/ad_config/ad_config.dart';
import '../../utils/utils.dart';

class LargeNativeAd extends StatefulWidget {
  const LargeNativeAd({
    super.key,
    this.adConfig,
    this.controller,
    this.visible = true,
    this.maintainSize = false,
    this.height = NativeAdSize.large,
    this.borderRadius,
  });

  final AdUnitConfig? adConfig;
  final NativeAdController? controller;
  final bool visible;
  final bool maintainSize;
  final double height;
  final BorderRadiusGeometry? borderRadius;

  @override
  State<LargeNativeAd> createState() => _LargeNativeAdState();
}

class _LargeNativeAdState extends State<LargeNativeAd> {
  bool isAdEnabled = false;

  @override
  void initState() {
    if (widget.controller != null) {
      isAdEnabled = true;
    } else {
      isAdEnabled = widget.adConfig?.isEnable ?? false;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (!isAdEnabled) {
      return SizedBox(
        height: widget.maintainSize ? widget.height : 0,
      );
    }
    return BlocBuilder<AdVisibilityCubit, bool>(
      builder: (context, state) {
        return Visibility(
          visible: state,
          maintainState: true,
          maintainAnimation: widget.maintainSize,
          maintainSize: widget.maintainSize,
          child: buildAd(widget.height),
        );
      },
    );
  }

  Container buildAd(double height) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
            color:
                Global.instance.isFullAds ? Colors.transparent : Colors.black),
        borderRadius: widget.borderRadius ??
            BorderRadius.vertical(
              top: Radius.circular(10.r),
            ),
      ),
      child: widget.controller == null
          ? MyNativeAd(
              factoryId: largeNativeAdFactory,
              adId: widget.adConfig!.id,
              adId2: widget.adConfig!.id2,
              adId2RequestPercentage: widget.adConfig!.id2RequestPercentage,
              height: height,
              loadingWidget: LargeAdLoading(height: widget.height),
            )
          : MyNativeAd.control(
              key: ValueKey(widget.controller?.controllerId),
              height: height,
              controller: widget.controller,
              loadingWidget: LargeAdLoading(height: widget.height),
            ),
    );
  }
}
