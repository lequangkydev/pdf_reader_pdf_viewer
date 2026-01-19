import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

enum BottomTab {
  document,
  recent,
  bookmark,
  more,
}

@singleton
class BottomTabCubit extends Cubit<BottomTab> {
  BottomTabCubit() : super(BottomTab.document);

  void changeTab(BottomTab tab) => emit(tab);
}
