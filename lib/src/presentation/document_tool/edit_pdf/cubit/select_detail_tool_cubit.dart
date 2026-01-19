import 'package:hydrated_bloc/hydrated_bloc.dart';

import '../enum/pdf_tool_enum.dart';

class SelectDetailToolCubit extends Cubit<DetailToolEditEnum?> {
  SelectDetailToolCubit() : super(null);

  void selectDetailTool(DetailToolEditEnum detailTool) => emit(detailTool);

  void clearDetailTool() => emit(null);
}
