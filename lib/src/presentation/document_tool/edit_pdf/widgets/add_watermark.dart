import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../gen/assets.gen.dart';
import '../../../../shared/extension/context_extension.dart';
import '../../../../shared/extension/string_extension.dart';
import '../cubit/add_watermark_cubit.dart';
import '../cubit/position_tool_cubit.dart';
import '../cubit/select_detail_tool_cubit.dart';
import '../edit_pdf_screen.dart';
import '../model/add_watermark_state.dart';
import 'add_text_bottom_sheet.dart';

class AddWatermark extends StatefulWidget {
  const AddWatermark({
    super.key,
    required this.pageSize,
  });

  final Size pageSize;

  @override
  State<AddWatermark> createState() => _AddWatermarkState();
}

class _AddWatermarkState extends State<AddWatermark> {
  final GlobalKey watermarkKey = GlobalKey();
  double _initialRotation = 0;
  double _initialFontSize = 14;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PositionToolCubit, Offset>(
      builder: (context, positionState) {
        return Positioned(
          left: positionState.dx,
          top: positionState.dy,
          child: BlocBuilder<AddWatermarkCubit, AddWatermarkState>(
            builder: (context, watermarkState) {
              return Transform.rotate(
                angle: watermarkState.rotation,
                child: Stack(
                  children: [
                    GestureDetector(
                      key: positionToolKey,
                      behavior: HitTestBehavior.deferToChild,
                      onTap: () {
                        if (contextEditPdf == null) {
                          return;
                        }
                        showTextEditorBottomSheet(
                          context: contextEditPdf!,
                          title: context.l10n.watermarkContent,
                          text: context.read<AddWatermarkCubit>().state.text,
                          color:
                              context.read<AddWatermarkCubit>().state.colorText,
                          onTextChanged:
                              context.read<AddWatermarkCubit>().onTextChanged,
                          onColorChanged:
                              context.read<AddWatermarkCubit>().onColorChanged,
                          validator: (value) {
                            final text = value.trim() ?? '';
                            if (text.isEmpty) {
                              return context.l10n.pleaseEnter;
                            }

                            if (text.containsDiacritics(value)) {
                              return context.l10n.pleaseDoNot;
                            }

                            return null;
                          },
                        );
                      },
                      onScaleStart: (details) {
                        _initialRotation = watermarkState.rotation;
                        _initialFontSize = watermarkState.fontSize;
                      },
                      onScaleUpdate: (details) {
                        // Xử lý rotation
                        if (details.rotation != 0) {
                          final newRotation =
                              _initialRotation + details.rotation;
                          context
                              .read<AddWatermarkCubit>()
                              .onRotationChanged(newRotation);
                        }

                        if (details.pointerCount == 1) {
                          final renderBox = watermarkKey.currentContext
                              ?.findRenderObject() as RenderBox?;
                          final Size widgetSize =
                              renderBox?.size ?? const Size(100, 30);

                          // delta gốc lấy từ gesture
                          final delta = details.focalPointDelta;

                          // xoay ngược delta lại theo góc watermarkState.rotation
                          final angle = watermarkState.rotation;
                          final rotatedDelta = Offset(
                            delta.dx * cos(angle) - delta.dy * sin(angle),
                            delta.dx * sin(angle) + delta.dy * cos(angle),
                          );

                          context
                              .read<PositionToolCubit>()
                              .updatePositionWithDelta(
                                rotatedDelta,
                                widget.pageSize,
                                widgetSize,
                              );
                        } else if (details.pointerCount == 2) {
                          // 👉 2 ngón tay = rotate + scale
                          final newRotation =
                              _initialRotation + details.rotation;

                          context
                              .read<AddWatermarkCubit>()
                              .onRotationChanged(newRotation);

                          final newFontSize = (_initialFontSize * details.scale)
                              .clamp(8.0, 32.0);
                          context
                              .read<AddWatermarkCubit>()
                              .onFontSizeChanged(newFontSize);
                        }
                      },
                      child: Container(
                        key: watermarkKey,
                        margin: const EdgeInsets.all(10),
                        padding: const EdgeInsets.all(8),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          border: Border.all(color: const Color(0xff3C7AFF)),
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        constraints: const BoxConstraints(
                          minWidth: 50,
                        ),
                        child: Text(
                          watermarkState.text,
                          style: TextStyle(
                            fontSize: watermarkState.fontSize,
                            color: watermarkState.colorText,
                            height: 1,
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        context.read<AddWatermarkCubit>().initReset();
                        context.read<SelectDetailToolCubit>().clearDetailTool();
                        context.read<PositionToolCubit>().update(Offset.zero);
                      },
                      child: Assets.icons.close.svg(),
                    ),
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: GestureDetector(
                        onPanUpdate: (details) {
                          double proposedFont =
                              watermarkState.fontSize + details.delta.dy * 0.8;
                          proposedFont = proposedFont.clamp(8.0, 500);
                          context
                              .read<AddWatermarkCubit>()
                              .onFontSizeChanged(proposedFont);
                        },
                        child: Assets.icons.zoomInOut.svg(width: 20),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
