import '../enum/app_enum.dart';
import 'value_cubit.dart';

class ShellDocumentTabCubit extends ValueCubit<TabBarType> {
  ShellDocumentTabCubit() : super(TabBarType.all);
}
