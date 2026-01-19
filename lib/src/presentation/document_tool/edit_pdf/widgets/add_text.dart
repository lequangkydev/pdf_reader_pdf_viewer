import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../gen/assets.gen.dart';
import '../../../../shared/extension/context_extension.dart';
import '../cubit/add_text_cubit.dart';
import '../cubit/position_tool_cubit.dart';
import '../cubit/select_detail_tool_cubit.dart';
import '../edit_pdf_screen.dart';
import '../model/add_text_state.dart';
import 'add_text_bottom_sheet.dart';

class AddText extends StatelessWidget {
  const AddText({super.key, required this.pageSize});

  final Size pageSize;

  static const double paddingAll = 8;
  static const double marginAll = 10;
  static const double borderWidth = 1;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PositionToolCubit, Offset>(
      builder: (context, positionState) {
        return Positioned(
          left: positionState.dx,
          top: positionState.dy,
          child: BlocBuilder<AddTextCubit, AddTextState>(
            builder: (context, state) {
              final maxAvailableWidth =
                  pageSize.width - positionState.dx - 2 * marginAll;
              final maxAvailableHeight =
                  pageSize.height - positionState.dy - 2 * marginAll;

              return Stack(
                children: [
                  GestureDetector(
                    key: positionToolKey,
                    onTap: () {
                      if (contextEditPdf == null) return;
                      showTextEditorBottomSheet(
                        context: contextEditPdf!,
                        title: context.l10n.addText,
                        text: state.text,
                        color: state.colorText,
                        onTextChanged:
                            context.read<AddTextCubit>().onTextChanged,
                        onColorChanged:
                            context.read<AddTextCubit>().onColorChanged,
                      );
                    },
                    onPanUpdate: (details) {
                      context
                          .read<PositionToolCubit>()
                          .dragUpdatePositionWidgetSize(details, pageSize,
                              widgetSize:
                                  _currentWidgetSize(state, maxAvailableWidth));
                    },
                    child: Container(
                      margin: const EdgeInsets.all(marginAll),
                      padding: const EdgeInsets.all(paddingAll),
                      decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xff3C7AFF)),
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      constraints: BoxConstraints(
                        minWidth: 50,
                        minHeight: 20,
                        maxWidth: maxAvailableWidth,
                        maxHeight: maxAvailableHeight,
                      ),
                      child: Text(
                        state.text,
                        style: TextStyle(
                          fontSize: state.fontSize,
                          color: state.colorText,
                          height: 1,
                        ),
                        softWrap: true,
                      ),
                    ),
                  ),
                  Positioned(
                    child: GestureDetector(
                      onTap: () {
                        context.read<SelectDetailToolCubit>().clearDetailTool();
                        context.read<AddTextCubit>().initReset();
                        context.read<PositionToolCubit>().update(Offset.zero);
                      },
                      child: Assets.icons.close.svg(width: 20),
                    ),
                  ),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: GestureDetector(
                      onPanUpdate: (details) {
                        double currentFont = state.fontSize;
                        double proposedFont =
                            currentFont + details.delta.dy * 0.8;

                        // clamp font between min/max
                        proposedFont = proposedFont.clamp(8.0, 100.0);

                        // tính size với font mới
                        final textSize = calculateTextSize(
                          state.text,
                          proposedFont,
                          maxAvailableWidth,
                        );

                        if (textSize.width <= maxAvailableWidth &&
                            textSize.height <= maxAvailableHeight) {
                          context
                              .read<AddTextCubit>()
                              .onFontSizeChanged(proposedFont);
                        }
                      },
                      child: Assets.icons.zoomInOut.svg(width: 20),
                    ),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }

  /// Hàm tính size widget hiện tại (text + padding + margin + border)
  Size _currentWidgetSize(AddTextState state, double maxAvailableWidth) {
    final textSize =
        calculateTextSize(state.text, state.fontSize, maxAvailableWidth);
    final totalWidth = textSize.width + 2 * marginAll;
    final totalHeight = textSize.height + 2 * marginAll;
    return Size(totalWidth, totalHeight);
  }
}

/// Tính size text với font và maxWidth
Size calculateTextSize(String text, double fontSize, double maxWidth) {
  final textPainter = TextPainter(
    text: TextSpan(text: text, style: TextStyle(fontSize: fontSize)),
    textDirection: TextDirection.ltr,
    maxLines: null,
  );

  final effectiveMaxWidth = maxWidth;
  textPainter.layout(minWidth: 0, maxWidth: effectiveMaxWidth);

  return textPainter.size;
}
