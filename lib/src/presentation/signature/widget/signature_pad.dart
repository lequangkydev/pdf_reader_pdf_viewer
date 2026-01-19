import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/extension/offset_extension.dart';
import '../cubit/draw/draw_cubit.dart';
import '../cubit/signature_pad_setting_cubit.dart';
import '../model/stroke.dart';
import 'signature_painter.dart';

class SignaturePad extends StatefulWidget {
  const SignaturePad({super.key});

  @override
  _SignatureCanvasState createState() => _SignatureCanvasState();
}

class _SignatureCanvasState extends State<SignaturePad> {
  Stroke? _currentStroke;
  Timer? _throttleTimer;

  int get _selectedColor =>
      context.read<SignaturePadSettingCubit>().state.signColor.toARGB32();

  double get _strokeWidth =>
      context.read<SignaturePadSettingCubit>().state.strokeWidth;

  void _addPoint(Offset point) {
    if (_throttleTimer?.isActive ?? false) {
      return;
    }
    _throttleTimer = Timer(const Duration(milliseconds: 16), () {
      setState(() {
        _currentStroke = _currentStroke?.copyWith(
          points: [..._currentStroke!.points, point.toPoint()],
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onPanStart: (details) {
        setState(() {
          _currentStroke = Stroke(
            points: [details.localPosition.toPoint()],
            colorValue: _selectedColor,
            strokeWidth: _strokeWidth,
          );
        });
      },
      onPanUpdate: (details) {
        _addPoint(details.localPosition);
      },
      onPanEnd: (_) {
        context.read<DrawCubit>().addStroke(_currentStroke!);
        setState(() => _currentStroke = null);
      },
      child: BlocBuilder<DrawCubit, DrawState>(
        builder: (context, state) {
          return CustomPaint(
            painter: SignaturePainter(
              state.strokes,
              _currentStroke,
            ),
            child: Container(color: Colors.transparent),
          );
        },
      ),
    );
  }
}
