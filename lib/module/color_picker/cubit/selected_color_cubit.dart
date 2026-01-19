import 'package:flutter/material.dart';

import '../../../src/shared/cubit/value_cubit.dart';

class SelectedColorCubit extends ValueCubit<Color> {
  SelectedColorCubit(super.state);

  void updateColor(Color color) => emit(color.withAlpha(state.alpha));

  void updateOpacity(double value) => emit(state.withOpacity(value));

  void updateRed(int value) => emit(state.withRed(value));

  void updateGreen(int value) => emit(state.withGreen(value));

  void updateBlue(int value) => emit(state.withBlue(value));
}
