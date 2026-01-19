import 'package:freezed_annotation/freezed_annotation.dart';

part 'post_api_token_model.freezed.dart';
part 'post_api_token_model.g.dart';

@freezed
abstract class PostApiTokenModel with _$PostApiTokenModel {
  const factory PostApiTokenModel({
    required String appId,
    required String secretKey,
  }) = _PostApiTokenModel;

  factory PostApiTokenModel.fromJson(Map<String, dynamic> json) =>
      _$PostApiTokenModelFromJson(json);
}
