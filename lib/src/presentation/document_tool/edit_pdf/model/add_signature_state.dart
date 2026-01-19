import 'dart:typed_data';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'add_signature_state.freezed.dart';

@freezed
class AddSignatureState with _$AddSignatureState {
  const factory AddSignatureState({
    @Default(100) double width,
    @Default(100) double height,
    Uint8List? uint8List,
  }) = _AddSignatureState;
}
