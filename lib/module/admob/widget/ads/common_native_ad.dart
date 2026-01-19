import 'package:flutter/material.dart';
import 'package:flutter_ads/ads_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../src/global/global.dart';
import '../../../../src/shared/constants/app_colors.dart';
import '../../../../src/shared/cubit/ad_visibility_cubit.dart';
import '../../../remote_config/remote_config.dart';
import '../../model/ad_config/ad_config.dart';
import '../../utils/enum/ad_factory.dart';
import '../../utils/utils.dart';
import '../loading/custom_large_ad_loading.dart';
import '../loading/custom_medium_ad_loading.dart';

class CommonNativeAd extends StatefulWidget {
  const CommonNativeAd({
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
    this.ignoreCubit = false,
    this.backgroundColor,
  }) : controller = null;

  const CommonNativeAd.control({
    super.key,
    this.controller,
    this.visible = true,
    this.maintainSize = false,
    this.height = NativeAdSize.homeAd,
    this.borderRadius,
    this.border,
    this.padding,
    this.margin,
    this.ignoreCubit = false,
    this.backgroundColor,
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
  final bool ignoreCubit;
  final Color? backgroundColor;

  @override
  State<CommonNativeAd> createState() => _CommonNativeAdState();
}

class _CommonNativeAdState extends State<CommonNativeAd> {
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
    if (widget.ignoreCubit) {
      return buildAd(widget.height);
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
          top: BorderSide(color: AppColors.adBorder),
          left: BorderSide(color: AppColors.adBorder),
          right: BorderSide(color: AppColors.adBorder),
        );
    final loadingWidget = (factoryId != AdFactory.homeNativeAd.name &&
            widget.controller?.factoryId != AdFactory.homeNativeAd.name)
        ? CustomLargeAdLoading(
            height: widget.height,
          )
        : (height == NativeAdSize.smallAd || height == NativeAdSize.smallRightAd
            ? CustomMediumAdLoading(
                height: widget.height,
                isSmall: true,
              )
            : CustomMediumAdLoading(
                height: widget.height,
              ));
    return Container(
      padding: widget.padding,
      margin: widget.margin,
      decoration: BoxDecoration(
        color: widget.backgroundColor ??
            (Global.instance.isFullAds
                ? Colors.transparent
                : AppColors.adBackground),
        borderRadius: Global.instance.isFullAds
            ? (RemoteConfigManager.instance.adsRemoteConfig.showBorderAds
                ? widget.borderRadius
                : null)
            : widget.borderRadius ??
                const BorderRadius.vertical(
                  top: Radius.circular(10),
                ),
        border: !Global.instance.isFullAds
            ? border
            : (RemoteConfigManager.instance.adsRemoteConfig.showBorderAds
                ? border
                : null),
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
              key: ValueKey(widget.controller?.controllerId),
            ),
    );
  }
}
