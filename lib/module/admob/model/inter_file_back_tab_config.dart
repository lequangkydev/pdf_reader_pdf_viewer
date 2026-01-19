import 'package:freezed_annotation/freezed_annotation.dart';

part 'inter_file_back_tab_config.freezed.dart';
part 'inter_file_back_tab_config.g.dart';

@freezed
class InterFileBackTabConfig with _$InterFileBackTabConfig {
  const factory InterFileBackTabConfig({
    @Default(true) bool interViewFile,
    @Default(true) bool interBack,
    @Default(true) bool interTab,
  }) = _InterFileBackTabConfig;

  factory InterFileBackTabConfig.fromJson(Map<String, dynamic> json) =>
      _$InterFileBackTabConfigFromJson(json);
}
