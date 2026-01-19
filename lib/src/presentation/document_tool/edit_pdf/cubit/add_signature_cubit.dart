import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/add_signature_state.dart';

class AddSignatureCubit extends Cubit<AddSignatureState> {
  AddSignatureCubit() : super(const AddSignatureState());

  void updateUint8List(Uint8List value) {
    emit(state.copyWith(uint8List: value));
  }

  void onResize(Size newSize) {
    emit(state.copyWith(height: newSize.height, width: newSize.width));
  }
}
