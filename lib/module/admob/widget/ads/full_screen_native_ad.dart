import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_ads/ads_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../src/config/di/di.dart';
import '../../../../src/config/navigation/app_router.dart';
import '../../../../src/global/global.dart';
import '../../../../src/shared/cubit/value_cubit.dart';
import '../../../../src/shared/helpers/logger_utils.dart';
import '../../../../src/shared/helpers/my_completer.dart';
import '../../model/ad_config/ad_config.dart';
import '../../utils/cached_ad_util.dart';

OverlayEntry? _overlayEntry;

Future<void> showFullNativeAd({
  required CachedAdUtil<NativeAdController> nativeAdUtil,
  VoidCallback? onClose,
}) async {
  if (!Global.instance.isFullAds) {
    onClose?.call();
    return;
  }

  if (!nativeAdUtil.adConfig.isEnable) {
    onClose?.call();
    return;
  }
  final MyCompleter<void> completer = MyCompleter();
  _removeOverlay();
  _overlayEntry = OverlayEntry(
    builder: (context) {
      return FullScreenNativeAd(
        nativeAdUtil: nativeAdUtil,
        onClose: () {
          onClose?.call();
          completer.complete();
        },
      );
    },
  );
  try {
    Overlay.of(getIt<AppRouter>().navigatorKey.currentContext!)
        .insert(_overlayEntry!);
  } on Exception catch (e) {
    logger.e(e);
    onClose?.call();
    completer.complete();
  }
  return completer.future;
}

void _removeOverlay() {
  try {
    _overlayEntry?.remove();
    _overlayEntry?.dispose();
    _overlayEntry = null;
  } on Exception catch (e) {
    logger.e(e);
  }
}

class FullScreenNativeAd extends StatefulWidget {
  const FullScreenNativeAd({
    super.key,
    required this.nativeAdUtil,
    required this.onClose,
  });

  final VoidCallback onClose;
  final CachedAdUtil<NativeAdController> nativeAdUtil;

  @override
  State<FullScreenNativeAd> createState() => _FullScreenNativeAdState();
}

class _FullScreenNativeAdState extends State<FullScreenNativeAd> {
  Timer? timer;
  NativeAdController? controller;
  final _countDownCubit = ValueCubit<int>(1);

  @override
  void initState() {
    super.initState();
    controller = widget.nativeAdUtil.getController();
    if (controller == null || controller!.status.isLoadFailed) {
      closeAd();
      return;
    }
    controller
      ?..onAdFailedToLoad = (_, __) {
        closeAd();
      }
      ..onAdImpression = (_) {
        timer = Timer.periodic(const Duration(seconds: 1), (timer) {
          if (_countDownCubit.state > 0) {
            _countDownCubit.update(_countDownCubit.state - 1);
          } else {
            timer.cancel();
          }
        });
      };
  }

  void closeAd() {
    _removeOverlay();
    widget.onClose();
  }

  Positioned? _buildCloseButton(String factoryId) {
    return Positioned(
      top: 30,
      right: 8,
      child: SafeArea(
        child: BlocBuilder<ValueCubit<int>, int>(
          bloc: _countDownCubit,
          builder: (context, state) {
            return _CloseButton(
              count: state,
              onTap: closeAd,
            );
          },
        ),
      ),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (controller?.hasAdBeenShown ?? false) {
      _countDownCubit.update(0);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (controller == null) {
      return const SizedBox();
    }
    return SafeArea(
      top: false,
      child: DecoratedBox(
        decoration: const BoxDecoration(color: Colors.black),
        child: MyNativeAd.control(
          key: ValueKey(controller?.adId),
          height: 1.sh,
          controller: controller,
          hasCloseButton: true,
          customCloseButton: _buildCloseButton(controller!.factoryId),
        ),
      ),
    );
  }

  @override
  void dispose() {
    timer?.cancel();
    _countDownCubit.close();
    super.dispose();
  }
}

class _CloseButton extends StatelessWidget {
  const _CloseButton({super.key, required this.onTap, required this.count});

  final VoidCallback onTap;
  final int count;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        IgnorePointer(
          child: Container(
            width: 30,
            height: 30,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xff737373),
            ),
          ),
        ),
        if (count > 0)
          Positioned.fill(
            child: Center(
              child: Text(
                count.toString(),
                style: const TextStyle(fontSize: 15, color: Colors.white),
              ),
            ),
          )
        else
          Positioned.fill(
            child: Center(
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: onTap,
                child: const SizedBox(
                  width: 50,
                  height: 50,
                  child: Icon(
                    Icons.close,
                    color: Colors.white,
                    size: 15,
                  ),
                ),
              ),
            ),
          )
      ],
    );
  }
}
