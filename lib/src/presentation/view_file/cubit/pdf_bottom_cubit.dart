import 'package:flutter_bloc/flutter_bloc.dart';

enum PdfBottomBarType {
  page,
  edit,
  print,
  share,
  more,
}

class PdfBottomBarCubit extends Cubit<PdfBottomBarType?> {
  PdfBottomBarCubit() : super(null);

  void tabType(PdfBottomBarType type) {
    emit(null);
    emit(type);
  }
}
