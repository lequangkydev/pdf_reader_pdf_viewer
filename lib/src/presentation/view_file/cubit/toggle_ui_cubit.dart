// file: toggle_ui_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';

class ToggleUiState {
  ToggleUiState({required this.isVisible});

  final bool isVisible;

  ToggleUiState copyWith({bool? isVisible}) {
    return ToggleUiState(isVisible: isVisible ?? this.isVisible);
  }
}

class ToggleUiCubit extends Cubit<ToggleUiState> {
  ToggleUiCubit() : super(ToggleUiState(isVisible: true)) {}

  void toggle() {
    final newState = !state.isVisible;
    emit(state.copyWith(isVisible: newState));
  }

  void show() {
    emit(state.copyWith(isVisible: true));
  }

  void hide() {
    emit(state.copyWith(isVisible: false));
  }
}
