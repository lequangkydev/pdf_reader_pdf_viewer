import 'package:freezed_annotation/freezed_annotation.dart';

import 'base_response_model.dart';

part 'get_api_token_model.freezed.dart';
part 'get_api_token_model.g.dart';

@Freezed(genericArgumentFactories: true)
abstract class GetApiTokenModel with _$GetApiTokenModel {
  const factory GetApiTokenModel({
    StatusResponseModel? status,
    ApiTokenResponse? data,
    dynamic extraData,
  }) = _GetApiTokenModel;

  factory GetApiTokenModel.fromJson(Map<String, dynamic> json) =>
      _$GetApiTokenModelFromJson(json);
}

@freezed
abstract class ApiTokenResponse with _$ApiTokenResponse {
  const factory ApiTokenResponse({
    String? token,
    String? encryptionKey,
    int? tokenExpire,
  }) = _ApiTokenResponse;

  factory ApiTokenResponse.fromJson(Map<String, dynamic> json) =>
      _$ApiTokenResponseFromJson(json);
}
