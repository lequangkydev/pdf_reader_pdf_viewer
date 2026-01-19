// import 'dart:async';
// import 'dart:ui';
//
// import 'package:flutter_ads/ads_flutter.dart';
//
// import '../../../src/config/di/di.dart';
// import '../../../src/config/navigation/app_router.dart';
// import '../../../src/shared/helpers/my_completer.dart';
// import '../model/ad_config/ad_config.dart';
// import 'native_full_util.dart';
// import 'utils.dart';
//
// class InterDefaultPermissionUtil {
//   InterDefaultPermissionUtil._();
//
//   static InterDefaultPermissionUtil instance = InterDefaultPermissionUtil._();
//
//   InterstitialAdController? _adController;
//
//   void preload() {
//     if (_adController != null &&
//         (_adController!.status.isLoading || _adController!.status.isLoaded)) {
//       return;
//     }
//     if (adUnitsConfig.interDefaultPermission.isEnable) {
//       _adController = InterstitialAdController(
//         adId: adUnitsConfig.interDefaultPermission.id,
//         adId2: adUnitsConfig.interDefaultPermission.id2,
//         adId2RequestPercentage:
//             adUnitsConfig.interDefaultPermission.id2RequestPercentage,
//         adKey: 'inter_default_permission',
//       );
//       _adController?.load();
//     }
//   }
//
//   Future<void> show({
//     VoidCallback? adDismiss,
//     VoidCallback? onShowed,
//     VoidCallback? onFailed,
//     VoidCallback? onclick,
//   }) async {
//     if (_adController == null) {
//       return;
//     }
//     final completer = MyCompleter();
//     NativeFullUtil? nativeFullUtil;
//     MyAds.instance.showInterstitialAd(
//       getIt<AppRouter>().navigatorKey.currentContext!,
//       controller: _adController,
//       forceShow: true,
//       onShowed: () {
//         nativeFullUtil = NativeFullUtil(
//           adConfig: adUnitsConfig.nativeFullInterDefaultPermission,
//         );
//         nativeFullUtil?.preloadAd();
//         onShowed?.call();
//       },
//       onAdClicked: () {
//         onclick?.call();
//       },
//       onFailed: () {
//         completer.complete();
//         onFailed?.call();
//       },
//       onNoInternet: () {
//         completer.complete();
//       },
//       adDismissed: () async {
//         _adController = null;
//         if (nativeFullUtil != null) {
//           await nativeFullUtil?.show();
//         }
//         completer.complete();
//         adDismiss?.call();
//       },
//     );
//     return completer.future;
//   }
// }
