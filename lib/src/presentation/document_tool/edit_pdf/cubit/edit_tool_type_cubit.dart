import 'package:hydrated_bloc/hydrated_bloc.dart';

import '../enum/pdf_tool_enum.dart';

class EditToolTypeCubit extends Cubit<PdfToolEnum?> {
  EditToolTypeCubit() : super(null);

  DateTime? _lastEmitTime;
  final Duration _cooldown = const Duration(milliseconds: 300);

  void selectTool(PdfToolEnum tool) {
    final now = DateTime.now();

    if (_lastEmitTime == null || now.difference(_lastEmitTime!) > _cooldown) {
      emit(tool);
      _lastEmitTime = now;
    }
  }

  void clearTool() => emit(null);
}
