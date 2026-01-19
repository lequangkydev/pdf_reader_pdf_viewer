import 'package:flutter/material.dart';

import '../../../../shared/cubit/value_cubit.dart';
import '../edit_pdf_screen.dart';

//vị trí của widget trên page pdf : text vs image
class PositionToolCubit extends ValueCubit<Offset> {
  PositionToolCubit() : super(Offset.zero);

  void initPosition(Size pageSize) {
    if (state != Offset.zero) {
      return;
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (positionToolKey.currentContext == null) {
        return;
      }
      final renderBox = positionToolKey.currentContext!.findRenderObject();
      if (renderBox is! RenderBox) {
        return;
      }

      final widgetSize = renderBox.size;
      final double x = (pageSize.width - widgetSize.width) / 2;
      final double y = (pageSize.height - widgetSize.height) / 2;

      update(Offset(x, y));
    });
  }

  void dragUpdatePosition(DragUpdateDetails details, Size pageSize) {
    final RenderBox? widgetBox =
        positionToolKey.currentContext?.findRenderObject() as RenderBox?;
    final Size widgetSize = widgetBox?.size ?? const Size(100, 30);

    double newX = state.dx + details.delta.dx;
    double newY = state.dy + details.delta.dy;

    newX = newX.clamp(0, pageSize.width - widgetSize.width);
    newY = newY.clamp(0, pageSize.height - widgetSize.height);

    update(Offset(newX, newY));
  }

  void dragUpdatePositionWidgetSize(
    DragUpdateDetails details,
    Size pageSize, {
    required Size widgetSize, // size tính toán trước từ _currentWidgetSize
  }) {
    final maxX =
        (pageSize.width - widgetSize.width).clamp(0.0, double.infinity);
    final maxY =
        (pageSize.height - widgetSize.height).clamp(0.0, double.infinity);

    final newX = (state.dx + details.delta.dx).clamp(0.0, maxX);
    final newY = (state.dy + details.delta.dy).clamp(0.0, maxY);

    update(Offset(newX, newY));
  }

  void updatePositionWithDelta(Offset delta, Size pageSize, Size widgetSize) {
    double newX = state.dx + delta.dx;
    double newY = state.dy + delta.dy;

    final double maxX =
        (pageSize.width - widgetSize.width).clamp(0, double.infinity);
    final double maxY =
        (pageSize.height - widgetSize.height).clamp(0, double.infinity);

    newX = newX.clamp(0, maxX);
    newY = newY.clamp(0, maxY);

    update(Offset(newX, newY));
  }
}
