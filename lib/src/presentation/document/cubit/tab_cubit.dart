import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import '../../../shared/cubit/value_cubit.dart';
import '../../../shared/enum/app_enum.dart';

@singleton
class TabCubit extends ValueCubit<TabBarType> {
  TabCubit() : super(TabBarType.all) {
    emit(TabBarType.all);
  }


  void setTabIndex(int index) {
    emit(TabBarType.values[index]);
  }
}
