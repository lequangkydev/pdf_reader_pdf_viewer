import 'dart:ui';

import '../../../cubit/value_cubit.dart';

class SelectColorCubit extends ValueCubit<Color> {
  SelectColorCubit() : super(const Color(0xFF000000));
}
