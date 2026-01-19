import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ads/ads_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../src/global/global.dart';
import '../../../../src/shared/cubit/ad_visibility_cubit.dart';
import '../../utils/native_all_util.dart';

class NativeAllAd extends StatefulWidget {
  const NativeAllAd({
    super.key,
    required this.isAdEnabled,
    this.offAdMaintainSize = false,
    this.height = 200,
    this.borderRadius,
    this.border,
    this.padding,
    this.loadingPadding,
    this.margin,
    this.ignoreCubit = false,
    this.hideMaintainSize = false,
    this.ignoreRouteObserver = false,
  });

  final bool isAdEnabled;
  final bool offAdMaintainSize;
  final bool hideMaintainSize;
  final double height;
  final BorderRadiusGeometry? borderRadius;
  final BoxBorder? border;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? loadingPadding;
  final EdgeInsetsGeometry? margin;
  final bool ignoreCubit;
  final bool ignoreRouteObserver;

  @override
  State<NativeAllAd> createState() => _NativeAllAdState();
}

class _NativeAllAdState extends State<NativeAllAd> with AutoRouteAware {
  NativeAdController? controller;
  NativeAdController? previousController;
  late bool isAdEnabled = widget.isAdEnabled;
  AutoRouteObserver? _observer;

  @override
  void initState() {
    if (isAdEnabled) {
      controller = NativeAllUtil.instance.getController();
      isAdEnabled = controller != null;
    }
    super.initState();
  }

  @override
  void didPushNext() {
    super.didPushNext();
    if (controller?.hasAdBeenShown ?? false) {
      previousController = controller;
    }
  }

  @override
  void didPopNext() {
    super.didPopNext();
    if (!widget.isAdEnabled) {
      return;
    }
    setState(() {
      controller = NativeAllUtil.instance.getController();
    });
    debugPrint('previousController:$previousController');
    debugPrint('controller:$controller');

    if (previousController != null) {
      // Future.delayed(const Duration(seconds: 2), () {
      //   NewNativeAllUtil.instance.disposeController(previousController!);
      // });
      // Lắng nghe sau khi UI đã được render
      WidgetsBinding.instance.addPostFrameCallback((_) {
        NativeAllUtil.instance.disposeController(previousController!);
      });
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (widget.ignoreRouteObserver) {
      return;
    }
    _observer =
        RouterScope.of(context).firstObserverOfType<AutoRouteObserver>();
    if (_observer != null) {
      // we subscribe to the observer by passing our
      // AutoRouteAware state and the scoped routeData
      _observer?.subscribe(this, context.routeData);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!isAdEnabled) {
      return SizedBox(
        height: widget.offAdMaintainSize ? widget.height : 0,
      );
    }
    if (widget.ignoreCubit) {
      return buildAd(widget.height);
    }
    return Builder(
      builder: (context) {
        final visible = context.watch<AdVisibilityCubit>().state;
        return Visibility(
          visible: visible,
          maintainState: true,
          maintainAnimation: widget.hideMaintainSize,
          maintainSize: widget.hideMaintainSize,
          child: buildAd(widget.height),
        );
      },
    );
  }

  Container buildAd(double height) {
    return Container(
      padding: widget.padding,
      margin: widget.margin,
      decoration: BoxDecoration(
        // borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
        border: Global.instance.isFullAds
            ? null
            : Border.all(color: const Color(0xffc5c5c5)),
        borderRadius: const BorderRadius.all(Radius.circular(5)),
        color: Colors.white,
      ),
      clipBehavior: Clip.antiAlias,
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(5)),
        child: MyNativeAd.control(
          key: ValueKey(controller?.controllerId ?? ''),
          height: height,
          controller: controller,
        ),
      ),
    );
  }

  @override
  void dispose() {
    if (controller != null) {
      NativeAllUtil.instance.disposeController(controller!);
    }
    super.dispose();
    _observer?.unsubscribe(this);
  }
}
