import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../remote_config/remote_config.dart';

part 'ad_config.freezed.dart';
part 'ad_config.g.dart';

@freezed
abstract class AdsRemoteConfig with _$AdsRemoteConfig {
  @JsonSerializable(explicitToJson: true)
  const factory AdsRemoteConfig({
    @Default(AdUnitsConfig()) AdUnitsConfig adUnitsConfig,
    @Default(true) bool showAllAds,
    @Default(true) bool showTopButton,
    @Default(1) int nativeFullDisplayMode,
    @Default(false) bool showIntro2FullNormal,
    @Default(true) bool preloadAdsLanguage,
    @Default(true) bool preloadAdsIntro,
    @Default(true) bool showIntro2FullFull,
    @Default(false) bool adOpenAllowAllFile,
    @Default(false) bool showBorderAds,
    @Default(2) int openResumeByNoti,
    @Default(Interval()) Interval interval,
    @Default(AdTypes()) AdTypes adTypes,
    @Default(false) bool switchOpenSplashInterSplash,
    @Default(2) int timeEnableLanguage,
    @Default(15) int interToAppOpenInterval,
    @Default(15) int appOpenToInterInterval,
  }) = _AdsRemoteConfig;

  factory AdsRemoteConfig.fromJson(Map<String, dynamic> json) =>
      _$AdsRemoteConfigFromJson(json);
}

@freezed
abstract class AdUnitConfig with _$AdUnitConfig {
  @JsonSerializable(explicitToJson: true)
  const factory AdUnitConfig({
    @Default('') String id,
    @Default('') String id2,
    @Default(true) bool enable,
    @Default(100) double id2RequestPercentage,
    Map<String, bool>? extraKeys,
  }) = _AdUnitConfig;

  factory AdUnitConfig.fromJson(Map<String, dynamic> json) =>
      _$AdUnitConfigFromJson(json);
}

extension AdUnitConfigExtension on AdUnitConfig {
  bool get isEnable => RemoteConfigManager.instance.enableAllAds && enable;
}

@freezed
abstract class AdUnitsConfig with _$AdUnitsConfig {
  @JsonSerializable(explicitToJson: true)
  const factory AdUnitsConfig({
    // 🅰️ Banner Ads
    @Default(AdUnitConfig()) AdUnitConfig bannerAll,
    @Default(AdUnitConfig()) AdUnitConfig bannerViewFile,

    // 🅰️ Open Ads
    @Default(AdUnitConfig()) AdUnitConfig openResumeSplash,
    @Default(AdUnitConfig()) AdUnitConfig openResumeSplashSecond,
    @Default(AdUnitConfig()) AdUnitConfig openResumeNormal,
    @Default(AdUnitConfig()) AdUnitConfig openResumeByNoti,

    // 🅰️ Interstitial Ads
    @Default(AdUnitConfig()) AdUnitConfig interSplash,
    @Default(AdUnitConfig()) AdUnitConfig interSplashSecond,
    @Default(AdUnitConfig()) AdUnitConfig interIntro,
    @Default(AdUnitConfig()) AdUnitConfig interFileBackTab,
    @Default(AdUnitConfig()) AdUnitConfig interTabMores,
    @Default(AdUnitConfig()) AdUnitConfig interOtherApp,
    @Default(AdUnitConfig()) AdUnitConfig interSuccessfully,
    @Default(AdUnitConfig()) AdUnitConfig interTranslate,
    @Default(AdUnitConfig()) AdUnitConfig interSummary,
    @Default(AdUnitConfig()) AdUnitConfig interUninstall,
    @Default(AdUnitConfig()) AdUnitConfig interSplashFromUninstall,
    @Default(AdUnitConfig()) AdUnitConfig interDefaultPermission,

    // 🅰️ Native Full Ads
    @Default(AdUnitConfig()) AdUnitConfig nativeFullSplash,
    @Default(AdUnitConfig()) AdUnitConfig nativeFullSplashSecond,
    @Default(AdUnitConfig()) AdUnitConfig nativeFullInterTab,
    @Default(AdUnitConfig()) AdUnitConfig nativeFullInterTabMores,
    @Default(AdUnitConfig()) AdUnitConfig nativeFullInterBack,
    @Default(AdUnitConfig()) AdUnitConfig nativeFullInterViewFile,
    @Default(AdUnitConfig()) AdUnitConfig nativeFullInterOtherApp,
    @Default(AdUnitConfig()) AdUnitConfig nativeFullInterSuccess,
    @Default(AdUnitConfig()) AdUnitConfig nativeFullInterUninstall,
    @Default(AdUnitConfig()) AdUnitConfig nativeFullInterSplashFromUninstall,
    @Default(AdUnitConfig()) AdUnitConfig nativeFullInterDefaultPermission,

    // 🅱️ Native UI Ads & Others
    @Default(AdUnitConfig()) AdUnitConfig nativeLanguage,
    @Default(AdUnitConfig()) AdUnitConfig nativeLanguageSelect,
    @Default(AdUnitConfig()) AdUnitConfig nativeIntro1,
    @Default(AdUnitConfig()) AdUnitConfig nativeIntro2,
    @Default(AdUnitConfig()) AdUnitConfig nativeIntro3,
    @Default(AdUnitConfig()) AdUnitConfig nativeUninstall,
    @Default(AdUnitConfig()) AdUnitConfig nativeTabMores,
    @Default(AdUnitConfig()) AdUnitConfig nativeExit,
    @Default(AdUnitConfig()) AdUnitConfig nativeAll,
  }) = _AdUnitsConfig;

  factory AdUnitsConfig.fromJson(Map<String, dynamic> json) =>
      _$AdUnitsConfigFromJson(json);
}

@freezed
abstract class Interval with _$Interval {
  @JsonSerializable(explicitToJson: true)
  const factory Interval({
    @Default(15) int interInterval,
    @Default(15) int reloadBannerInterval,
    @Default(0) int intervalResume,
    @Default(0) int intervalResumeByNoti,
  }) = _Interval;

  factory Interval.fromJson(Map<String, dynamic> json) =>
      _$IntervalFromJson(json);
}

@freezed
abstract class AdTypes with _$AdTypes {
  @JsonSerializable(explicitToJson: true)
  const factory AdTypes({
    @Default(2) int nativeIntro1Type,
    @Default(3) int nativeIntro2Type,
    @Default(2) int nativeIntro3Type,
    @Default(2) int nativeLanguageSelectType,
    @Default(2) int nativeLanguageType,
  }) = _AdTypes;

  factory AdTypes.fromJson(Map<String, dynamic> json) =>
      _$AdTypesFromJson(json);
}
