import 'package:freezed_annotation/freezed_annotation.dart';

part 'native_all_config.freezed.dart';
part 'native_all_config.g.dart';

@freezed
abstract class NativeAllConfig with _$NativeAllConfig {
  const factory NativeAllConfig({
    @Default(true) bool nativeLanguageSetting,
    @Default(true) bool nativeSuccessfully,
    @Default(true) bool nativePdfToolList,
    @Default(true) bool nativeAISummary,
    @Default(true) bool nativeAITranslate,
  }) = _NativeAllConfig;

  factory NativeAllConfig.fromJson(Map<String, dynamic> json) =>
      _$NativeAllConfigFromJson(json);
}
