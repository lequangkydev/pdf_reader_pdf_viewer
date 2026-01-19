import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../gen/assets.gen.dart';
import '../cubit/add_image_cubit.dart';
import '../cubit/edit_tool_type_cubit.dart';
import '../cubit/position_tool_cubit.dart';
import '../cubit/select_detail_tool_cubit.dart';
import '../edit_pdf_screen.dart';
import '../model/add_image_state.dart';

class AddImage extends StatelessWidget {
  const AddImage({super.key, required this.pageSize});

  final Size pageSize;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PositionToolCubit, Offset>(
      builder: (context, positionState) {
        return Positioned(
          left: positionState.dx,
          top: positionState.dy,
          child: BlocBuilder<AddImageCubit, AddImageState>(
            builder: (context, state) {
              if (state.image == null) {
                return const SizedBox.shrink();
              }
              return Stack(
                children: [
                  GestureDetector(
                    key: positionToolKey,
                    onPanUpdate: (details) {
                      context
                          .read<PositionToolCubit>()
                          .dragUpdatePosition(details, pageSize);
                    },
                    child: Container(
                      margin: const EdgeInsets.all(10),
                      padding: const EdgeInsets.all(8),
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        color: Colors.transparent,
                      ),
                      constraints: const BoxConstraints(
                        minWidth: 50,
                        minHeight: 50,
                      ),
                      child: Image.file(
                        state.image!,
                        width: state.size.width,
                        height: state.size.height,
                        fit: state.isSignature ? BoxFit.fill : BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    child: GestureDetector(
                      onTap: () {
                        context.read<AddImageCubit>().initReset();
                        context.read<SelectDetailToolCubit>().clearDetailTool();
                        context.read<PositionToolCubit>().update(Offset.zero);
                        context.read<EditToolTypeCubit>().clearTool();
                      },
                      child: Assets.icons.close.svg(width: 20),
                    ),
                  ),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: GestureDetector(
                      onPanUpdate: (details) {
                        final newSize = Size(
                          (state.size.width + details.delta.dx).clamp(50, 400),
                          (state.size.height + details.delta.dy).clamp(50, 400),
                        );
                        context.read<AddImageCubit>().onResize(newSize);
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
}
