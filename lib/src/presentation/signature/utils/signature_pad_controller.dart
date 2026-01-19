import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../module/hive/hive_box.dart';
import '../cubit/draw/draw_cubit.dart';
import '../model/normalized_signature.dart';
import '../model/stroke.dart';

const maxStrokeWidth = 20;

class SignaturePadController {
  SignaturePadController();

  void initialize() {}

  Future<void> saveSignature(BuildContext context) async {
    final drawCubit = context.read<DrawCubit>();
    final normalizedSignature = normalizeSignature(drawCubit.state.strokes);
    final signature = Signature(
      strokes: normalizedSignature.strokes,
      width: normalizedSignature.width,
      height: normalizedSignature.height,
    );
    HiveBox.signature.add(signature);

    context.maybePop(true);
  }

  /// Loại bỏ khoảng trắng xung quanh chữ ký
  NormalizedSignature normalizeSignature(List<Stroke> strokes) {
    if (strokes.isEmpty) {
      return NormalizedSignature(strokes: [], width: 0, height: 0);
    }

    double minX = double.infinity;
    double minY = double.infinity;
    double maxX = double.negativeInfinity;
    double maxY = double.negativeInfinity;

    // Tìm giới hạn bounding box
    for (final stroke in strokes) {
      for (final point in stroke.points) {
        if (point.dx < minX) {
          minX = point.dx;
        }
        if (point.dy < minY) {
          minY = point.dy;
        }
        if (point.dx > maxX) {
          maxX = point.dx;
        }
        if (point.dy > maxY) {
          maxY = point.dy;
        }
      }
    }

    final width = maxX - minX;
    final height = maxY - minY;

    // Dịch từng điểm về sát gốc toạ độ
    final normalizedStrokes = strokes
        .map((stroke) => Stroke(
              points: stroke.points
                  .map((p) => Point(dx: p.dx - minX, dy: p.dy - minY))
                  .toList(),
              colorValue: stroke.colorValue,
              strokeWidth: stroke.strokeWidth,
            ))
        .toList();

    return NormalizedSignature(
      strokes: normalizedStrokes,
      width: width,
      height: height,
    );
  }
}
