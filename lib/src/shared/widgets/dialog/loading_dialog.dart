import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

import '../../../config/di/di.dart';
import '../../../config/navigation/app_router.dart';
import '../../../gen/assets.gen.dart';
import '../../../services/default_app_checker.dart';
import '../../constants/app_colors.dart';
import '../../cubit/ad_visibility_cubit.dart';
import '../../extension/context_extension.dart';

class LoadingOverlay {
  LoadingOverlay._();

  static OverlayEntry? _overlay;

  static LottieComposition? _cachedComposition;

  static Future<void> preload() async {
    if (_cachedComposition != null) {
      return;
    }

    // Load Lottie composition từ asset
    final assetData = await rootBundle.load(Assets.lotties.loading.path);
    _cachedComposition = await LottieComposition.fromBytes(
      assetData.buffer.asUint8List(),
    );
  }

  static bool get isShowing => _overlay != null;

  static Future<void> show(
      {bool isTranslate = false, bool isSummary = false}) async {
    if (_overlay != null || isShowing) {
      return;
    }

    final currentCtx = getIt<AppRouter>().navigatorKey.currentContext;
    if (currentCtx == null) {
      return;
    }

    await preload(); // preload nếu chưa có

    DefaultAppChecker.disableBack();
    getIt<AdVisibilityCubit>().update(false);

    _overlay = OverlayEntry(
      builder: (_) => Container(
        color: Colors.black54,
        alignment: Alignment.center,
        child: Container(
          padding: const EdgeInsets.all(40),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (isTranslate) ...[
                Assets.lotties.translate.image(width: 120),
                Text(currentCtx.l10n.translationProgress)
              ] else if (isSummary) ...[
                Assets.lotties.summary.image(width: 120),
                Text(currentCtx.l10n.summaryProgress)
              ] else ...[
                Lottie(
                  composition: _cachedComposition,
                  width: 100,
                  repeat: true,
                ),
                Text(
                  currentCtx.l10n.loading,
                  style: const TextStyle(
                    color: AppColors.color80,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ]
            ],
          ),
        ),
      ),
    );

    Overlay.of(currentCtx).insert(_overlay!);
  }

  static void hide() {
    DefaultAppChecker.enableBack();
    getIt<AdVisibilityCubit>().update(true);
    _overlay?.remove();
    _overlay = null;
  }
}
