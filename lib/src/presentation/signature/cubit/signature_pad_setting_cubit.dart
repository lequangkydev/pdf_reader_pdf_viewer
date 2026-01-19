import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import '../../../shared/cubit/value_cubit.dart';
import '../model/signature_pad_setting.dart';
import '../utils/signature_pad_controller.dart';

class SignaturePadSettingCubit extends ValueCubit<SignaturePadSetting>
    with HydratedMixin {
  SignaturePadSettingCubit() : super(SignaturePadSetting()) {
    hydrate();
  }

  void updateColor(Color color) {
    if (state.recentColors.contains(color)) {
      emit(state.copyWith(
        signColor: color,
      ));
      return;
    }
    final recentColors = [...state.recentColors];
    if (recentColors.length >= 4) {
      recentColors.removeLast();
    }
    recentColors.insert(0, color);
    emit(state.copyWith(
      signColor: color,
      recentColors: recentColors,
    ));
  }

  void updateWidth(double width) {
    emit(state.copyWith(
      strokeWidth: width,
    ));
  }

  void setWidthRatio(double scale) {
    updateWidth(scale * maxStrokeWidth);
  }

  @override
  SignaturePadSetting? fromJson(Map<String, dynamic> json) {
    return SignaturePadSetting.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(SignaturePadSetting state) {
    return state.toJson();
  }
}
