import 'package:flutter_bloc/flutter_bloc.dart';

class PageIndexCubit extends Cubit<List<int>> {
  PageIndexCubit() : super([0]);

  void toggleIndex(int index) {
    if (index < 0) {
      return;
    }
    final newList = List<int>.from(state);
    final existIndex = state.firstWhere(
      (element) => element == index,
      orElse: () => -1,
    );
    if (existIndex == -1) {
      newList.add(index);
    } else {
      newList.remove(index);
    }
    emit(newList);
  }
}
