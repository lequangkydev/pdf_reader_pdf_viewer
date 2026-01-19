import 'package:freezed_annotation/freezed_annotation.dart';

part 'base_response_model.freezed.dart';
part 'base_response_model.g.dart';

@Freezed(genericArgumentFactories: true)
abstract class BaseResponseModel<T, T1> with _$BaseResponseModel<T, T1> {
  const factory BaseResponseModel({
    StatusResponseModel? status,
    T? data,
    T1? extraData,
  }) = _BaseResponseModel<T, T1>;

  factory BaseResponseModel.fromJson(
    Map<String, dynamic> json,
    T Function(Object?) fromJsonT,
    T1 Function(Object?) fromJsonT1,
  ) => _$BaseResponseModelFromJson(json, fromJsonT, fromJsonT1);
}

@freezed
abstract class StatusResponseModel with _$StatusResponseModel {
  const factory StatusResponseModel({
    String? code,
    String? message,
    String? label,
    String? requestId,
  }) = _StatusResponseModel;

  factory StatusResponseModel.fromJson(Map<String, dynamic> json) =>
      _$StatusResponseModelFromJson(json);
}
