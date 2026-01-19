import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ads/ads_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

import '../../../module/admob/utils/app_open_ad_util.dart';
import '../../../module/admob/utils/native_all_util.dart';
import '../../../module/admob/utils/preload_ads_util.dart';
import '../../../module/admob/utils/reload_ad_util.dart';
import '../../../module/admob/utils/utils.dart';
import '../../../module/admob/widget/ads/common_native_ad.dart';
import '../../../module/admob/widget/ads/native_all_ad.dart';
import '../../../module/log_event_app/language_event.dart';
import '../../../module/remote_config/remote_config.dart';
import '../../../module/tracking_screen/screen_logger.dart';
import '../../config/navigation/app_router.dart';
import '../../data/local/shared_preferences_manager.dart';
import '../../global/global.dart';
import '../../shared/constants/app_colors.dart';
import '../../shared/enum/language.dart';
import '../../shared/extension/context_extension.dart';
import '../../shared/extension/number_extension.dart';
import '../../shared/utils/file_utils.dart';
import '../../shared/widgets/glowing_button.dart';
import '../splash/shortcut_utils.dart';
import '../splash/splash_screen.dart';
import 'cubit/language_cubit.dart';
import 'widgets/language_item.dart';

@RoutePage()
class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key, this.isFirst = true});

  final bool isFirst;

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen>
    with TickerProviderStateMixin, WidgetsBindingObserver {
  List<Languages> languages = [...Languages.values];

  late final ValueNotifier<NativeAdController?> adControllerNotifier;
  late AnimationController _scaleController;

  // Offset? buttonPosition;
  Languages? suggestionLanguage;
  bool _hasUserChangedLanguage = false;

  AdDisplayType get adDisplayType => adTypes.nativeLanguageType.adDisplayType;

  @override
  void initState() {
    super.initState();
    if (widget.isFirst &&
        RemoteConfigManager.instance.appConfig.optimizeLanguage) {
      PreloadAdsUtil.instance.preloadAdsLanguage();
    }
    if (widget.isFirst) {
      clickAds();
      AnalyticLogger.instance
          .logEventWithScreen(event: LanguageEvent.Enter_Screen);
      AnalyticLogger.instance.logCustomScreen(CustomScreenName.languageScreen);
    }
    if (widget.isFirst &&
        RemoteConfigManager.instance.appConfig.screenFlow.showIntro &&
        SharedPreferencesManager.instance.isFirstUseApp() &&
        !RemoteConfigManager.instance.appConfig.optimizeLanguage) {
      PreloadAdsUtil.instance.preloadAdsIntro();
    }
    _scaleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    )..repeat(reverse: true);

    updateLanguages();
    if (widget.isFirst &&
        RemoteConfigManager.instance.appConfig.enableReRender) {
      Future.delayed(
        Duration.zero,
        () {
          setState(() {});
        },
      );
    }

    WidgetsBinding.instance.addObserver(this);
    if (widget.isFirst) {
      _initLanguageAd();
    }
  }

  void _initLanguageAd() {
    if (Global.instance.isFullAds) {
      // Hiển thị ad native được load trước ở splash khi sang màn language
      adControllerNotifier =
          ValueNotifier<NativeAdController?>(ReloadAdUtil.instance.controller);
      Future.delayed(Duration.zero, showNativeFull);
    } else {
      adControllerNotifier = ValueNotifier<NativeAdController?>(
          PreloadAdsUtil.instance.ctrlLanguage);
    }
  }

  void showNativeFull() {
    if (nativeFullSplashUtil == null) {
      adControllerNotifier.value = PreloadAdsUtil.instance.ctrlLanguage;
      adNotifier.notifyClosed();
    } else {
      nativeFullSplashUtil?.show(
        onClose: () {
          // Tắt native full sẽ hiển thị ad language
          adControllerNotifier.value = PreloadAdsUtil.instance.ctrlLanguage;
          adNotifier.notifyClosed();
        },
      );
    }
  }

  bool _isButtonEnabled = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Sau 2s thì enable button
    adNotifier.addListener(() {
      if (RemoteConfigManager.instance.appConfig.optimizeLanguage) {
        Future.delayed(
            Duration(
                seconds: RemoteConfigManager
                    .instance.adsRemoteConfig.timeEnableLanguage), () {
          if (mounted) {
            setState(() {
              _isButtonEnabled = true;
            });
          }
          PreloadAdsUtil.instance.preloadAdsIntro();
        });
      }
    });
  }

  void updateLanguages() {
    final String defaultLanguage = Global.defaultLocale.split('_').first;
    suggestionLanguage = Languages.values.firstWhereOrNull(
      (element) => element.code == defaultLanguage,
    );
    if (suggestionLanguage != null) {
      languages.remove(suggestionLanguage);
      languages.insert(0, suggestionLanguage!);
      languages.insert(4, suggestionLanguage!);
    } else {
      suggestionLanguage = Languages.english;
    }

    setState(() {});
  }

  bool isClickAdsNativeLanguage = false;
  bool isClickAdsNativeLanguageSelect = false;

  void clickAds() {
    final ctrlLanguage = PreloadAdsUtil.instance.ctrlLanguage;
    ctrlLanguage?.onAdClicked = (ad) {
      isClickAdsNativeLanguage = true;
      AnalyticLogger.instance
          .logEventWithScreen(event: LanguageEvent.Click_Ads_Language);
    };
    final ctrlLanguageSelect = PreloadAdsUtil.instance.ctrlLanguageSelect;
    ctrlLanguageSelect?.onAdClicked = (ad) {
      isClickAdsNativeLanguageSelect = true;
      AnalyticLogger.instance
          .logEventWithScreen(event: LanguageEvent.Click_Ads_Select);
    };
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      if (isClickAdsNativeLanguage) {
        AnalyticLogger.instance
            .logEventWithScreen(event: LanguageEvent.Reopen_after_ads_language);
        isClickAdsNativeLanguage = false;
      }
      if (isClickAdsNativeLanguageSelect) {
        AnalyticLogger.instance
            .logEventWithScreen(event: LanguageEvent.Reopen_after_ads_select);
        isClickAdsNativeLanguageSelect = false;
      }
    }
  }

  @override
  void dispose() {
    _scaleController.dispose();

    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            elevation: 0,
            automaticallyImplyLeading: !widget.isFirst,
            scrolledUnderElevation: 0,
            backgroundColor: const Color(0xffF7F7F7),
            title: BlocSelector<LanguageCubit, LanguageState, Languages?>(
              selector: (state) => state.language,
              builder: (context, state) {
                return HtmlWidget(
                  context.l10n.selectLanguage,
                  textStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                );
              },
            ),
            actions: widget.isFirst && adDisplayType == AdDisplayType.hasMedia
                ? [_buildAcceptButton()]
                : null,
          ),
          backgroundColor: const Color(0xffF7F7F7),
          body: BlocConsumer<LanguageCubit, LanguageState>(
            listener: (context, state) {
              if (widget.isFirst) {
                if (!_hasUserChangedLanguage &&
                    !RemoteConfigManager.instance.appConfig.optimizeLanguage) {
                  PreloadAdsUtil.instance.loadLanguageSelect();
                  AnalyticLogger.instance
                      .logCustomScreen(CustomScreenName.languageSelectScreen);
                  if (PreloadAdsUtil.instance.ctrlLanguageSelect != null) {
                    _hasUserChangedLanguage = true;
                    adControllerNotifier.value =
                        PreloadAdsUtil.instance.ctrlLanguageSelect;
                  }
                }
              }
            },
            listenWhen: (previous, current) =>
                previous.language != current.language ||
                previous.isSystemLanguage != current.isSystemLanguage,
            builder: (context, state) {
              final Languages? selectedLanguage = state.language;
              return SingleChildScrollView(
                child: Column(
                  children: [
                    if (languages.length == 17)
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 16),
                        child: Container(
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.pr.withValues(alpha: 0.05),
                                blurRadius: 12,
                              )
                            ],
                          ),
                          child: LanguageItem(
                            language: languages[0],
                            selectedLanguage: selectedLanguage,
                            isSystem: true,
                          ),
                        ),
                      ),
                    if (languages.length == 17)
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(
                            bottom: 2,
                            left: 10,
                          ),
                          child: Text(
                            context.l10n.other,
                            style: TextStyle(
                              color: const Color(0xff808080),
                              fontSize: 12.sp,
                              height: 1,
                            ),
                          ),
                        ),
                      ),
                    ListView.separated(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: languages.length,
                      itemBuilder: (BuildContext context1, int index) {
                        final Languages item = languages[index];

                        if (languages.length == 17 && index == 0) {
                          return const SizedBox.shrink();
                        }
                        return LanguageItem(
                          language: item,
                          selectedLanguage: selectedLanguage,
                        );
                      },
                      separatorBuilder: (context, index) => 8.vSpace,
                    ),
                    20.vSpace,
                  ],
                ),
              );
            },
          ),
          bottomNavigationBar: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              4.vSpace,
              if (widget.isFirst && adDisplayType != AdDisplayType.hasMedia)
                ColoredBox(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: GlowingButton(
                      isEnable: !RemoteConfigManager
                              .instance.appConfig.optimizeLanguage ||
                          _isButtonEnabled,
                      onTap: () {
                        final isOptimize = RemoteConfigManager
                            .instance.appConfig.optimizeLanguage;
                        final bool isButtonReady =
                            !isOptimize || _isButtonEnabled;

                        if (!isButtonReady) {
                          return;
                        }
                        final state = context.read<LanguageCubit>().state;
                        final Languages? selectedLanguage = state.language;
                        AnalyticLogger.instance.logEventWithScreen(
                            event: LanguageEvent.Select_BTN_Select);
                        ShortcutUtils.instance.setShortcut();
                        context.read<LanguageCubit>().update(
                              LanguageState(
                                language: selectedLanguage,
                                isSystemLanguage: state.isSystemLanguage,
                              ),
                            );

                        if (!widget.isFirst) {
                          context.maybePop();
                        } else {
                          if (RemoteConfigManager
                                  .instance.appConfig.screenFlow.showIntro &&
                              SharedPreferencesManager.instance
                                  .isFirstUseApp()) {
                            context.replaceRoute(const OnBoardingRoute());
                          } else {
                            context.replaceRoute(const ShellRoute());
                          }
                        }
                      },
                      textBtn: context.l10n.continuePer,
                    ),
                  ),
                ),
              _buildAd(),
            ],
          ),
        ),
      ],
    );
  }

  Builder _buildAcceptButton() {
    return Builder(builder: (context) {
      final state = context.watch<LanguageCubit>().state;
      final Languages? selectedLanguage = state.language;

      final isOptimize =
          RemoteConfigManager.instance.appConfig.optimizeLanguage;
      final bool isButtonReady = isOptimize ? _isButtonEnabled : true;
      final bool isActive = selectedLanguage != null && isButtonReady;
      return TextButton(
        onPressed: () async {
          if (!isActive) {
            return;
          }
          AnalyticLogger.instance
              .logEventWithScreen(event: LanguageEvent.Select_BTN_Select);
          ShortcutUtils.instance.setShortcut();
          context.read<LanguageCubit>().update(
                LanguageState(
                  language: selectedLanguage,
                  isSystemLanguage: state.isSystemLanguage,
                ),
              );

          if (!widget.isFirst) {
            context.maybePop();
            return;
          }
          if (RemoteConfigManager.instance.appConfig.screenFlow.showIntro &&
              SharedPreferencesManager.instance.isFirstUseApp()) {
            context.replaceRoute(const OnBoardingRoute());
          } else {
            if (Global.instance.sharedFiles != null) {
              openFile(Global.instance.sharedFiles!.path, context);
            } else {
              context.replaceRoute(const ShellRoute());
            }
            SharedPreferencesManager.instance.setFirstUseApp();
          }
        },
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 200),
          opacity: isOptimize ? (isButtonReady ? 1 : 0.4) : 1,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.check_rounded,
                color: selectedLanguage == null ? Colors.grey : AppColors.pr,
                size: 24,
              ),
              const SizedBox(width: 2),
              Text(
                context.l10n.done.toUpperCase(),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildAd() {
    return widget.isFirst
        ? ValueListenableBuilder(
            valueListenable: adControllerNotifier,
            builder: (context, value, child) {
              final adType = value == PreloadAdsUtil.instance.ctrlLanguageSelect
                  ? adTypes.nativeLanguageSelectType.adDisplayType
                  : adTypes.nativeLanguageType.adDisplayType;

              return CommonNativeAd.control(
                key: ValueKey(value?.controllerId),
                height: PreloadAdsUtil.instance.heightNativeView(adType),
                controller: value,
              );
            })
        : NativeAllAd(
            isAdEnabled: NativeAllUtil.instance.config.nativeLanguageSetting,
          );
  }
}
