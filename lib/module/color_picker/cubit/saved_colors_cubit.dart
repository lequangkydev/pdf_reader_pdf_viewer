// ignore_for_file: avoid_dynamic_calls

import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class SavedColorCubit extends Cubit<List<Color>> with HydratedMixin {
  SavedColorCubit() : super([]) {
    hydrate();
  }

  final String _key = 'color_list';

  void addToHead(Color element) {
    if (!state.contains(element)) {
      final List<Color> newState = [element, ...state];
      if (state.length == 10) {
        newState.removeLast();
      }
      emit(newState);
    }
  }

  @override
  List<Color>? fromJson(Map<String, dynamic> json) {
    return json[_key].map((e) => Color(e));
  }

  @override
  Map<String, dynamic>? toJson(List<Color> state) {
    final data = [];
    for (final e in state) {
      data.add(e.value);
    }
    return {
      _key: data,
    };
  }
}
