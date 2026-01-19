import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vtn_flutter_pdfviewer/pdfviewer.dart';

import '../enum/pdf_tool_enum.dart';
import '../model/add_style_pdf_state.dart';

class AddStylePdfCubit extends Cubit<AddStylePdfState> {
  AddStylePdfCubit() : super(const AddStylePdfState());
  PdfViewerController? _pdfViewerController;
  GlobalKey<SfPdfViewerState>? _pdfViewerKey;

  void setPdfViewCtrl(PdfViewerController ctrl) {
    _pdfViewerController = ctrl;
  }

  void setPdfViewKey(GlobalKey<SfPdfViewerState> key) {
    _pdfViewerKey = key;
  }

  void changeColor(Color color) {
    emit(state.copyWith(colorStyle: color));
  }

  Timer? _timer;

  void selectText({
    required PdfTextSelectionChangedDetails detail,
    DetailToolEditEnum? currentTool,
  }) {
    if (currentTool == null) {
      return;
    }
    if (_pdfViewerKey == null) {
      return;
    }
    _timer?.cancel();
    _timer = Timer(const Duration(milliseconds: 600), () {
      final List<PdfTextLine>? textLines =
          _pdfViewerKey!.currentState?.getSelectedTextLines();
      final selectColor = state.colorStyle;
      if (textLines == null || textLines.isEmpty) {
        return;
      }

      if (currentTool == DetailToolEditEnum.unline) {
        _addAnnotation(
          UnderlineAnnotation(textBoundsCollection: textLines),
          selectColor,
        );
      }
      if (currentTool == DetailToolEditEnum.highlight) {
        _addAnnotation(
          HighlightAnnotation(textBoundsCollection: textLines),
          selectColor,
        );
      }
      if (currentTool == DetailToolEditEnum.strike) {
        _addAnnotation(
          StrikethroughAnnotation(textBoundsCollection: textLines),
          selectColor,
        );
      }
    });
  }

  void _addAnnotation(Annotation annotation, [Color? color]) {
    if (_pdfViewerController == null) {
      return;
    }
    if (annotation is UnderlineAnnotation ||
        annotation is StrikethroughAnnotation ||
        annotation is HighlightAnnotation) {
      annotation.color = color ?? Colors.black;
    }
    _pdfViewerController!.addAnnotation(annotation);
    emit(state.copyWith(hasChangeAnnotation: true));
  }

  bool get hasAnnotation => state.hasChangeAnnotation;
}
