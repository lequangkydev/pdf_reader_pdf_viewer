import 'package:injectable/injectable.dart';

import 'value_cubit.dart';

@singleton
class AdVisibilityCubit extends ValueCubit<bool> {
  AdVisibilityCubit() : super(true);
}
