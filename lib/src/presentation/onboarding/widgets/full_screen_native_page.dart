import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_ads/ads_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../src/shared/cubit/value_cubit.dart';

class FullScreenNativePage extends StatefulWidget {
  const FullScreenNativePage({
    super.key,
    this.controller,
    required this.onClose,
    this.onInit,
    this.onLoadFail,
  });

  final VoidCallback onClose;
  final VoidCallback? onInit;
  final VoidCallback? onLoadFail;
  final NativeAdController? controller;

  @override
  State<FullScreenNativePage> createState() => _FullScreenNativePageState();
}

class _FullScreenNativePageState extends State<FullScreenNativePage> {
  Timer? timer;
  final _countDownCubit = ValueCubit<int>(1);

  @override
  void initState() {
    super.initState();
    widget.onInit?.call();

    if (widget.controller == null) {
      widget.onClose();
    } else {
      if (widget.controller!.status.isLoadFailed) {
        widget.onLoadFail?.call();
        widget.onClose();
      }
      widget.controller
        ?..onAdFailedToLoad = (_, __) {
          widget.onLoadFail?.call();
          widget.onClose();
        }
        ..onAdImpression = (_) {
          timer = Timer.periodic(const Duration(seconds: 1), (timer) {
            if (_countDownCubit.state > 0) {
              if (_countDownCubit.isClosed) {
                return;
              }
              _countDownCubit.update(_countDownCubit.state - 1);
            } else {
              timer.cancel();
            }
          });
        };
    }
  }

  void closeAd() {
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
    if (widget.controller?.hasAdBeenShown ?? false) {
      _countDownCubit.update(0);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.controller == null) {
      return const SizedBox();
    }
    return SafeArea(
      top: false,
      child: DecoratedBox(
        decoration: const BoxDecoration(color: Colors.black),
        child: MyNativeAd.control(
          key: ValueKey(widget.controller?.adId),
          height: 1.sh,
          controller: widget.controller,
          hasCloseButton: true,
          customCloseButton: _buildCloseButton(widget.controller!.factoryId),
          loadingWidget: FullScreenAdLoading.instance.lottieLoading(),
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
  const _CloseButton({required this.onTap, required this.count});

  final VoidCallback onTap;
  final int count;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        IgnorePointer(
          child: Container(
            width: 26,
            height: 26,
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
                child: const Icon(
                  Icons.close,
                  color: Colors.white,
                  size: 18,
                ),
              ),
            ),
          )
      ],
    );
  }
}
