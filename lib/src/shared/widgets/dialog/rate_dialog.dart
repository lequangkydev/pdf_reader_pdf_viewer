import 'dart:async';
import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ads/ads_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:in_app_review/in_app_review.dart';

import '../../../../module/remote_config/remote_config.dart';
import '../../../config/di/di.dart';
import '../../../config/navigation/app_router.dart';
import '../../../gen/assets.gen.dart';
import '../../../global/global.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_constants.dart';
import '../../cubit/rate_status_cubit.dart';
import '../../extension/context_extension.dart';
import '../../extension/number_extension.dart';
import '../../helpers/logger_utils.dart';
import '../../utils/style_utils.dart';
import '../button_widget.dart';
import 'rate_success_dialog.dart';
import 'rating_bar.dart';

Future<void> showRatingDialog({bool fromSetting = false}) async {
  final appContext = getIt<AppRouter>().navigatorKey.currentContext!;
  final rated = appContext.read<RateStatusCubit>().state;
  if (rated && !fromSetting) {
    return;
  }

  MyAds.instance.appLifecycleReactor?.setIsExcludeScreen(true);
  final InAppReview inAppReview = InAppReview.instance;
  if (!RemoteConfigManager.instance.enableAllAds && Platform.isIOS) {
    if (await inAppReview.isAvailable()) {
      return inAppReview.requestReview();
    } else if (fromSetting) {
      return inAppReview.openStoreListing(
        appStoreId: AppConstants.appIOSId,
      );
    }
  } else {
    return showDialog(
      barrierDismissible: false,
      context: appContext,
      barrierColor: Colors.black.withOpacity(0.8),
      builder: (BuildContext ctx) => RatingDialog(fromSetting: fromSetting),
    );
  }
}

class RatingDialog extends StatefulWidget {
  const RatingDialog({super.key, this.fromSetting = false});

  final bool fromSetting;

  @override
  State<RatingDialog> createState() => _RatingDialogState();
}

class _RatingDialogState extends State<RatingDialog> {
  final ValueNotifier<double> rateValue = ValueNotifier<double>(5);

  @override
  void dispose() {
    rateValue.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      surfaceTintColor: Colors.white,
      //insetPadding: const EdgeInsets.symmetric(horizontal: 30),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            8.vSpace,
            ValueListenableBuilder<double>(
              valueListenable: rateValue,
              builder: (_, double value, __) {
                return Image.asset(
                  'assets/icons/rates/emotion${value.toInt()}.png',
                  height: 72,
                  width: 72,
                  fit: BoxFit.fill,
                );
              },
            ),
            8.vSpace,
            ValueListenableBuilder<double>(
                valueListenable: rateValue,
                builder: (_, double value, __) {
                  String rateTitle = context.l10n.rate5;
                  switch (value) {
                    case 1:
                      rateTitle = context.l10n.rate1;
                    case 2:
                      rateTitle = context.l10n.rate2;
                    case 3:
                      rateTitle = context.l10n.rate3;
                    case 4:
                      rateTitle = context.l10n.rate4;
                    case 5:
                      rateTitle = context.l10n.rate5;
                  }

                  return Text(
                    rateTitle,
                    style: const TextStyle(
                      fontSize: 20,
                      height: 28 / 20,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  );
                }),
            8.vSpace,
            RatingBar.builder(
              minRating: 1,
              initialRating: 5,
              glowColor: Colors.white,
              itemPadding: const EdgeInsets.symmetric(horizontal: 4),
              itemBuilder: (BuildContext context, int index) {
                return Assets.icons.rates.fullStar.svg(
                  height: 30,
                  width: 30,
                  colorFilter: const ColorFilter.mode(
                    AppColors.pr,
                    BlendMode.srcIn,
                  ),
                );
              },
              unratedBuilder: (BuildContext context, int index) {
                return Assets.icons.rates.emptyStar.svg(
                  height: 30,
                  width: 30,
                );
              },
              onRatingUpdate: (double value) => rateValue.value = value,
            ),
            24.vSpace,
            ButtonWidget(
                onTap: _rateApp,
                radius: 100,
                child: Text(
                  context.l10n.rate,
                  style: StyleUtils.style.s14.semiBold.white,
                )),
            8.vSpace,
            TextButton(
              onPressed: () async {
                await context.maybePop();
                if (Global.instance.isExitApp) {
                  exitApp();
                }
              },
              child: Text(
                context.l10n.notNow,
                style: StyleUtils.style.s12.medium.b25,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void exitApp() {
    if (Platform.isAndroid) {
      SystemNavigator.pop();
    } else if (Platform.isIOS) {
      exit(0);
    }
  }

  Future<void> showThanksDialog() async {
    await showDialog(
      context: getIt<AppRouter>().navigatorKey.currentContext!,
      builder: (context) {
        Timer(
          const Duration(seconds: 1),
          () async {
            await context.maybePop();
            if (Global.instance.isExitApp) {
              exitApp();
            }
          },
        );
        return RateSuccessDialog(context);
      },
    );
  }

  Future<void> _rateApp() async {
    if (mounted) {
      context.read<RateStatusCubit>().update(true);
    }
    if (rateValue.value == 5) {
      MyAds.instance.appLifecycleReactor?.setIsExcludeScreen(true);
      await context.maybePop();
      await _openReview();
      await showThanksDialog();
    } else {
      if (context.mounted) {
        await context.maybePop();
        if (Global.instance.isExitApp) {
          exitApp();
        }
      }
    }
  }

  Future<void> _openReview() async {
    try {
      if (widget.fromSetting) {
        InAppReview.instance.openStoreListing(
          appStoreId: AppConstants.appIOSId,
        );
      } else if (await InAppReview.instance.isAvailable()) {
        await InAppReview.instance.requestReview();
      }
    } catch (e) {
      logger.e(e);
    }
  }
}
