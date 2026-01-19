import 'package:flutter/material.dart';
import 'package:flutter_ads/ads_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../src/gen/colors.gen.dart';
import '../../../../src/shared/cubit/ad_visibility_cubit.dart';
import '../../model/ad_config/ad_config.dart';
import '../../utils/enum/ad_factory.dart';
import '../../utils/utils.dart';
import '../loading/custom_large_ad_loading.dart';
import '../loading/custom_medium_ad_loading.dart';

class NativeHomeAd extends StatefulWidget {
  const NativeHomeAd({
    super.key,
    this.adConfig,
    this.visible = true,
    this.maintainSize = false,
    this.height = NativeAdSize.homeAd,
    this.borderRadius,
    this.factoryId,
    this.border,
    this.padding,
    this.margin,
  }) : controller = null;

  const NativeHomeAd.control({
    super.key,
    this.controller,
    this.visible = true,
    this.maintainSize = false,
    this.height = NativeAdSize.homeAd,
    this.borderRadius,
    this.border,
    this.padding,
    this.margin,
  })  : adConfig = null,
        factoryId = null;

  final AdUnitConfig? adConfig;
  final String? factoryId;
  final NativeAdController? controller;
  final bool visible;
  final bool maintainSize;
  final double height;
  final BorderRadiusGeometry? borderRadius;
  final BoxBorder? border;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;

  @override
  State<NativeHomeAd> createState() => _NativeHomeAdState();
}

class _NativeHomeAdState extends State<NativeHomeAd> {
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
    final factoryId = widget.factoryId ?? AdFactory.homeNativeAd.name;
    final border = widget.border ??
        const Border(
          top: BorderSide(color: MyColors.adBorder),
          left: BorderSide(color: MyColors.adBorder),
          right: BorderSide(color: MyColors.adBorder),
        );
    final loadingWidget = (factoryId != AdFactory.homeNativeAd.name &&
            widget.controller?.factoryId != AdFactory.homeNativeAd.name)
        ? CustomLargeAdLoading(
            height: widget.height,
          )
        : CustomMediumAdLoading(
            height: widget.height,
          );
    return Container(
      padding: widget.padding,
      margin: widget.margin,
      decoration: BoxDecoration(
        color: MyColors.adBackground,
        borderRadius: widget.borderRadius ??
            const BorderRadius.vertical(
              top: Radius.circular(10),
            ),
        border: border,
      ),
      clipBehavior: Clip.antiAlias,
      child: widget.controller == null
          ? MyNativeAd(
              factoryId: factoryId,
              adId: widget.adConfig!.id,
              adId2: widget.adConfig!.id2,
              adId2RequestPercentage: widget.adConfig!.id2RequestPercentage,
              height: height,
              loadingWidget: loadingWidget,
            )
          : MyNativeAd.control(
              height: height,
              controller: widget.controller,
              loadingWidget: loadingWidget,
            ),
    );
  }
}
