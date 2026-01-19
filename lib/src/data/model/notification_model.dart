import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification_model.freezed.dart';
part 'notification_model.g.dart';

@freezed
class NotificationModel with _$NotificationModel {
  @JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
  const factory NotificationModel({
    NewFile? newFile,
    NotificationBaseContent? recent,
    NotificationBaseContent? killApp,
  }) = _NotificationModel;

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationModelFromJson(json);
}

@freezed
class NewFile with _$NewFile {
  const factory NewFile({
    String? pdf,
    String? word,
    String? excel,
    String? ppt,
    String? photo,
  }) = _NewFile;

  factory NewFile.fromJson(Map<String, dynamic> json) =>
      _$NewFileFromJson(json);
}

@freezed
class NotificationBaseContent with _$NotificationBaseContent {
  const factory NotificationBaseContent({
    String? title,
    String? message,
  }) = _NotificationBaseContent;

  factory NotificationBaseContent.fromJson(Map<String, dynamic> json) =>
      _$NotificationBaseContentFromJson(json);
}
