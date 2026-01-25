import 'dart:async';
import 'dart:io';

import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:auto_route/auto_route.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ads/ads_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:upgrader/upgrader.dart';
import 'package:uuid/uuid.dart';

import '../../../module/adjust/adjust.dart';
import '../../../module/admob/model/ad_config/ad_config.dart';
import '../../../module/admob/utils/app_open_ad_util.dart';
import '../../../module/admob/utils/inter_ad_util.dart';
import '../../../module/admob/utils/native_full_util.dart';
import '../../../module/admob/utils/preload_ads_util.dart';
import '../../../module/admob/utils/reload_ad_util.dart';
import '../../../module/admob/utils/utils.dart';
import '../../../module/file_system/enum/file_system_type.dart';
import '../../../module/log_event_app/shell_event.dart';
import '../../../module/remote_config/remote_config.dart';
import '../../../module/tracking_screen/loggable_widget.dart';
import '../../../module/tracking_screen/screen_logger.dart';
import '../../config/app_config.dart';
import '../../config/di/di.dart';
import '../../config/navigation/app_router.dart';
import '../../data/local/shared_preferences_manager.dart';
import '../../data/model/file_model.dart';
import '../../gen/assets.gen.dart';
import '../../global/global.dart';
import '../../services/default_app_checker.dart';
import '../../shared/constants/app_colors.dart';
import '../../shared/enum/app_enum.dart';
import '../../shared/extension/context_extension.dart';
import '../../shared/extension/number_extension.dart';
import '../../shared/extension/string_extension.dart';
import '../../shared/helpers/permission_util.dart';
import '../../shared/utils/admob_consent_util.dart';
import '../../shared/utils/file_utils.dart';
import '../../shared/utils/style_utils.dart';
import '../../shared/utils/toast_util.dart';
import '../../shared/widgets/gradient_text.dart';
import '../permission/cubit/storage_status_cubit.dart';
import 'shortcut_utils.dart';
import 'update_dialog.dart';

NativeFullUtil? nativeFullSplashUtil;

@RoutePage()
class SplashScreen extends StatefulLoggableWidget {
  const SplashScreen({
    super.key,
    this.isReload = false,
    this.file,
    this.type,
  });

  final bool isReload;
  final FileModel? file;
  final TabBarType? type;

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController controller = AnimationController(
    vsync: this,
    value: 0,
    duration: const Duration(seconds: 1),
  );

  void initCrashlytics() {
    if (!kDebugMode) {
      FlutterError.onError = (errorDetails) {
        FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
      };
      PlatformDispatcher.instance.onError = (error, stack) {
        FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
        return true;
      };
    }
  }

  Future<bool> configureAd() async {
    if (widget.isReload) {
      return true;
    }
    final bool isShowAd = RemoteConfigManager.instance.enableAllAds;
    //init and show ad
    if (mounted && isShowAd) {
      MyAds.instance.configure(
        navigatorKey: getIt<AppRouter>().navigatorKey,
        interIntervalInSeconds:
            RemoteConfigManager.instance.adsRemoteConfig.interval.interInterval,
        enableShowRateLogger: true,
        interToAppOpenInterval:
            RemoteConfigManager.instance.adsRemoteConfig.interToAppOpenInterval,
        admobConfiguration: RequestConfiguration(
          testDeviceIds: [
            '19D8E27F194BB895488CEADD5DB99D62',
          ],
        ),
      );
      MyAds.instance.events.listen((event) {
        if (event.status.isPaid &&
            event.valueMicros != null &&
            event.currencyCode != null) {
          final value = event.valueMicros! / 1000000;
          AdjustUtil.instance.trackAdRevenue(
            value: value,
            currencyCode: event.currencyCode!,
          );
          AdjustUtil.instance.trackImpressionEvent(
            value: value,
            currencyCode: event.currencyCode!,
          );
          final event80Token =
              RemoteConfigManager.instance.adjustConfig.event80Token;
          if (event80Token.isValid) {
            final AdjustEvent event80 = AdjustEvent(
              event80Token!,
              revenue: value * 0.8,
              currency: event.currencyCode,
            );
            AdjustUtil.instance.trackEvent(event80);
          }
        }

        if (event.adKey == 'inter_resume' && Global.instance.isFullAds) {
          handleNativeAfterInterResume(event);
        }
      });
    }
    return true;
  }

  NativeFullUtil? nativeFullInterResumeUtil;

  void handleNativeAfterInterResume(AdInformation event) {
    if (event.status.isShown && nativeFullInterResumeUtil == null) {
      nativeFullInterResumeUtil =
          NativeFullUtil(adConfig: adUnitsConfig.nativeFullInterOtherApp);
      nativeFullInterResumeUtil!.preloadAd();
    } else if (event.status.isDismiss) {
      nativeFullInterResumeUtil?.show(
        onClose: () {
          nativeFullInterResumeUtil = null;
        },
      );
    }
  }

  Future<void> showSplashAd() async {
    final firstUseApp = SharedPreferencesManager.instance.isFirstUseApp();
    final isFirstToSplash = SharedPreferencesManager.instance.isFirstToSplash();

    final useInter = RemoteConfigManager
        .instance.adsRemoteConfig.switchOpenSplashInterSplash;

    AdUnitConfig adConfig;
    AdUnitConfig nativeFullConfig;
    if (Global.instance.sharedFiles == null) {
      adConfig = isFirstToSplash
          ? (useInter
              ? adUnitsConfig.interSplash
              : adUnitsConfig.openResumeSplash)
          : (useInter
              ? adUnitsConfig.interSplashSecond
              : adUnitsConfig.openResumeSplashSecond);
      nativeFullConfig = isFirstToSplash
          ? adUnitsConfig.nativeFullSplash
          : adUnitsConfig.nativeFullSplashSecond;
    } else {
      adConfig = adUnitsConfig.interOtherApp;
      nativeFullConfig = adUnitsConfig.nativeFullInterOtherApp;
    }

    final shouldShowNativeFull = Global.instance.sharedFiles == null &&
        RemoteConfigManager.instance.appConfig.screenFlow.showLanguage;

    if (!adConfig.isEnable) {
      adNotifier.notifyClosed();
    }
    await SplashAdUtil.instance.show(
      adConfig: adConfig,
      isInterstitial: Global.instance.sharedFiles != null || useInter,
      onShow: () {
        if (Global.instance.sharedFiles != null ||
            shouldShowNativeFull && nativeFullConfig.isEnable) {
          nativeFullSplashUtil = NativeFullUtil(
            adConfig: nativeFullConfig,
            adKey: 'native_full_splash',
          );
        }
        nativeFullSplashUtil?.preloadAd();
      },
      onClosed: () async {
        //nếu fullads thì tắt ở nativeFull
        if (!Global.instance.isFullAds) {
          adNotifier.notifyClosed();
        }
        //nếu lần thứ vào app hoặc mở
        if (firstUseApp && Global.instance.sharedFiles == null) {
          SharedPreferencesManager.instance.setFirstToSplash();
          return;
        }
        await nativeFullSplashUtil?.show();
        if (Global.instance.sharedFiles != null) {
          final fileExtension =
              path.extension(Global.instance.sharedFiles!.path).toLowerCase();
          if (!isSupportFile(fileExtension)) {
            Future.delayed(
              const Duration(milliseconds: 500),
              () {
                ToastUtil.showMess(
                  mess: getIt<AppRouter>()
                      .navigatorKey
                      .currentContext!
                      .l10n
                      .doNotSupport,
                );
              },
            );
          }
        }
      },
    );
    if (isFirstToSplash && Global.instance.sharedFiles == null) {
      SharedPreferencesManager.instance.setFirstToSplash();
      return;
    }
  }

  Future<void> setInitScreen() async {
    context.replaceRoute(const ShellRoute());
    return;
    final firstOpen = SharedPreferencesManager.instance.isFirstUseApp();
    if (widget.isReload) {
      if (widget.file != null && widget.type != null) {
        FileUtils.openFileRoute(context, widget.file!, widget.type!, false);
        return;
      }
      return;
    }
    if (Global.instance.sharedFiles != null && !firstOpen) {
      openFile(Global.instance.sharedFiles!.path);
      return;
    }
    if (Global.instance.recentFilePath != null &&
        Global.instance.recentFilePath !=
            File('${Global.instance.documentPath}/sample.pdf').path) {
      // mở file từ thông báo được lên lịch
      AnalyticLogger.instance
          .logEventWithScreen(event: ShellEvent.Enter_FROM_Notify);
      openFile(Global.instance.recentFilePath!);
      return;
    }
    if (Global.instance.notificationAction != null) {
      AnalyticLogger.instance
          .logEventWithScreen(event: ShellEvent.Enter_FROM_OTHER_Fun);
      DefaultAppChecker.handleTapActionOnNotification(
          Global.instance.notificationAction!);
      return;
    }
    if (RemoteConfigManager.instance.appConfig.screenFlow.showLanguage &&
        firstOpen) {
      context.replaceRoute(LanguageRoute());
      return;
    }
    if (RemoteConfigManager.instance.appConfig.screenFlow.showIntro &&
        firstOpen) {
      context.replaceRoute(const OnBoardingRoute());
      return;
    }
    AnalyticLogger.instance
        .logEventWithScreen(event: ShellEvent.Enter_FROM_Splash);
    context.replaceRoute(const ShellRoute());
  }

  void openFile(String filePath) {
    final file = File(filePath);
    if (!file.existsSync()) {
      context.replaceRoute(const ShellRoute());
      return;
    }
    final fileExtension = path.extension(file.path).toLowerCase();
    if (fileExtension == '.pdf') {
      context.replaceRoute(ViewPdfRoute(
          pdfFile: FileModel(id: const Uuid().v1(), file: file),
          fromReload: true));
      return;
    }
    if (imagesExtension.contains(fileExtension)) {
      context.replaceRoute(
        ViewImageRoute(
          fileModel: FileModel(file: file, id: ''),
        ),
      );
      return;
    }
    if (pptExtension.contains(fileExtension) ||
        excelsExtension.contains(fileExtension) ||
        wordsExtension.contains(fileExtension)) {
      context.replaceRoute(
        ViewFileRoute(
            file: file,
            fileModel: FileModel(file: file, id: ''),
            type: TabBarType.ppt,
            fromReload: true),
      );
      return;
    }
    if (!allTypeExtension.contains(fileExtension)) {
      AnalyticLogger.instance
          .logEventWithScreen(event: ShellEvent.Enter_FROM_Splash);
      context.replaceRoute(const ShellRoute());
    }
  }

  Future<void> initUpgrader() async {
    final Completer completer = Completer();
    if (Global.instance.upgrader == null) {
      Global.instance.upgrader = Upgrader(
        // debugDisplayAlways: true,
        debugLogging: true,
      );
      await Global.instance.upgrader?.initialize();
    }
    final bool forceUpdate =
        RemoteConfigManager.instance.appConfig.isForceUpdate;
    if (!Global.instance.upgrader!.shouldDisplayUpgrade()) {
      completer.complete();
    } else {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => PopScope(
          canPop: false,
          child: UpdateDialog(
            upgrader: Global.instance.upgrader,
            showLater: !forceUpdate,
            onLater: completer.complete,
          ),
        ),
      );
    }
    return completer.future;
  }

  Future<bool> initGlobalData() async {
    if (widget.isReload) {
      return true;
    }
    final result = await Future.wait([
      getApplicationDocumentsDirectory(),
      getTemporaryDirectory(),
    ]);
    Global.instance.documentPath = result[0].path;
    Global.instance.temporaryPath = result[1].path;
    if (Platform.isAndroid) {
      Global.instance.androidSdkVersion =
          (await DeviceInfoPlugin().androidInfo).version.sdkInt;
    }
    AppConfig.getInstance().settingSystemUI();
    return true;
  }

  void configureEasyLoading() {
    if (widget.isReload) {
      return;
    }
    EasyLoading.instance
      ..loadingStyle = EasyLoadingStyle.custom
      ..backgroundColor = Colors.transparent
      ..indicatorColor = context.colorScheme.primary
      ..textColor = Colors.white
      ..indicatorType = EasyLoadingIndicatorType.fadingCircle
      ..boxShadow = [
        const BoxShadow(
          color: Colors.transparent,
          blurRadius: 5,
        )
      ];
    Global.instance.initEasyLoading = true;
  }

  Future<void> initUMP() async {
    if (widget.isReload) {
      return;
    }
    if (!RemoteConfigManager.instance.enableAllAds) {
      await AppTrackingTransparency.requestTrackingAuthorization();
    } else {
      await ConsentUtil.instance.checkAndShowConsent();
    }
  }

  Future<void> checkStoragePermission() async {
    final status = await PermissionUtil.instance.checkStoragePermission();
    if (mounted) {
      context.read<StoragePermissionCubit>().update(status);
    }
  }

  Future<void> loadSampleFile() async {
    if (widget.isReload) {
      return;
    }
    final file = File('${Global.instance.documentPath}/sample.pdf');
    if (!file.existsSync()) {
      final assetFile =
          (await rootBundle.load(Assets.files.sample)).buffer.asUint8List();
      file.createSync(recursive: true);
      file.writeAsBytesSync(
        assetFile,
        flush: true,
      );
    }
  }

  void initAdOpen() {
    final bool enableOpenResume = adUnitsConfig.openResumeNormal.isEnable;
    if (enableOpenResume) {
      MyAds.instance.initAppOpenAd(
        appOpenAdUnitId: adUnitsConfig.openResumeNormal.id,
        appOpenAdUnitId2: adUnitsConfig.openResumeNormal.id2,
        adId2RequestPercentage:
            adUnitsConfig.openResumeNormal.id2RequestPercentage,
        mainAdInterval: RemoteConfigManager
            .instance.adsRemoteConfig.interval.intervalResume,
        appOpenToInterInterval:
            RemoteConfigManager.instance.adsRemoteConfig.appOpenToInterInterval,
      );
    }
  }

  Future<void> waitingForAdInit() async {
    if (MyAds.instance.initialized) {
      return;
    }
    final completer = Completer();
    MyAds.instance.stream.listen(
      (event) {
        if (event && !completer.isCompleted) {
          completer.complete();
        }
      },
    );
    return completer.future;
  }

  Future<void> _init() async {
    if (!kDebugMode) {
      initCrashlytics();
    }
    controller.animateTo(.31);
    await initUMP();
    controller.animateTo(.53);
    final result = await Future.wait([
      configureAd(),
      initGlobalData(),
      ShortcutUtils.instance.initialize(),
      PermissionUtil.instance.requestPermissionNotificationDefault(),
    ]);
    await checkStoragePermission();
    controller.animateTo(.99);
    await waitingForAdInit();
    // vào app bằng shortcut
    if (result[2]) {
      await InterAdUtil.instance.showInterWithNativeFull(
        interAdConfig: adUnitsConfig.interSplashFromUninstall,
        nativeFullConfig: adUnitsConfig.nativeFullInterSplashFromUninstall,
      );
      ShortcutUtils.instance.handleShortcut();
      return;
    }
    await initUpgrader();

    preloadAds();

    loadSampleFile();
    Global.instance.initializedSplash = true;
    if (widget.isReload) {
      await InterAdUtil.instance.showInterWithNativeFull(
        interAdConfig: adUnitsConfig.interDefaultPermission,
        nativeFullConfig: adUnitsConfig.nativeFullInterDefaultPermission,
      );
    } else {
      await showSplashAd();
    }
    await setInitScreen();
  }

  void preloadAds() {
    final firstOpen = SharedPreferencesManager.instance.isFirstUseApp();
    if (!firstOpen) {
      return;
    }
    if (widget.isReload || Global.instance.notificationAction != null) {
      return;
    }
    if (RemoteConfigManager.instance.appConfig.screenFlow.showLanguage &&
        SharedPreferencesManager.instance.isFirstUseApp()) {
      ReloadAdUtil.instance.loadAd();

      if (RemoteConfigManager.instance.appConfig.optimizeLanguage) {
        return;
      }
      PreloadAdsUtil.instance.preloadAdsLanguage();
      return;
    }
    if (RemoteConfigManager.instance.appConfig.screenFlow.showIntro &&
        SharedPreferencesManager.instance.isFirstUseApp()) {
      PreloadAdsUtil.instance.preloadAdsIntro();
      return;
    }
  }

  @override
  void initState() {
    super.initState();
    _init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
          image: Assets.images.splashBg.provider(),
          fit: BoxFit.cover,
        )),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Assets.images.logo.roundedLogo.image(width: 120),
                    16.vSpace,
                    const GradientText(
                      'PDF Reader',
                      gradient: LinearGradient(
                        colors: [
                          Color(0xffFF5959),
                          Color(0xffD90000),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            100.vSpace,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 60),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  AnimatedBuilder(
                    animation: controller,
                    builder: (context, child) {
                      return Column(
                        children: [
                          Text(
                            context.l10n.loadingSplash(
                                (controller.value * 100).toStringAsFixed(0)),
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Color(0xff404040),
                              fontSize: 14,
                              height: 1,
                            ),
                          ),
                          8.vSpace,
                          Container(
                            width: 200,
                            height: 10,
                            decoration: BoxDecoration(
                              color: const Color(0xffE6E6E6),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(2),
                              child: LinearProgressIndicator(
                                borderRadius: BorderRadius.circular(4),
                                color: AppColors.pr,
                                value: controller.value,
                                backgroundColor: Colors.transparent,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  10.vSpace,
                  Text(
                    context.l10n.thisActionCanContainAds,
                    textAlign: TextAlign.center,
                    style: StyleUtils.style.s14.regular.b25,
                  ),
                ],
              ),
            ),
            50.vSpace,
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    ShortcutUtils.instance.isSplash = false;
    initAdOpen();
    controller.dispose();
    super.dispose();
  }
}
