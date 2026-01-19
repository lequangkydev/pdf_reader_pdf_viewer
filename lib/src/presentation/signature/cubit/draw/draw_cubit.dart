import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/stroke.dart';

class DrawState {
  factory DrawState.initial() =>
      DrawState(strokes: [], redoStack: [], undoStack: []);

  DrawState({
    required this.strokes,
    required this.redoStack,
    required this.undoStack,
  });

  final List<Stroke> strokes;
  final List<List<Stroke>> undoStack;
  final List<List<Stroke>> redoStack;
}

class DrawCubit extends Cubit<DrawState> {
  DrawCubit() : super(DrawState.initial());

  void addStroke(Stroke stroke) {
    emit(DrawState(
      strokes: [...state.strokes, stroke],
      undoStack: [...state.undoStack, state.strokes],
      redoStack: [],
    ));
  }

  void clear() {
    emit(DrawState(
      strokes: [],
      undoStack: [...state.undoStack, state.strokes],
      redoStack: [],
    ));
  }

  void undo() {
    if (state.undoStack.isNotEmpty) {
      final previous = List<List<Stroke>>.from(state.undoStack);
      final newStrokes = previous.removeLast();
      emit(DrawState(
        strokes: newStrokes,
        undoStack: previous,
        redoStack: [...state.redoStack, state.strokes],
      ));
    }
  }

  void redo() {
    if (state.redoStack.isNotEmpty) {
      final next = List<List<Stroke>>.from(state.redoStack);
      final redoStrokes = next.removeLast();
      emit(DrawState(
        strokes: redoStrokes,
        undoStack: [...state.undoStack, state.strokes],
        redoStack: next,
      ));
    }
  }
}
