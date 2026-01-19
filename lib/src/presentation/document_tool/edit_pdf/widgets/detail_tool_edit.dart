import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../gen/assets.gen.dart';
import '../../../../shared/extension/number_extension.dart';
import '../cubit/add_image_cubit.dart';
import '../cubit/add_text_cubit.dart';
import '../cubit/add_watermark_cubit.dart';
import '../cubit/edit_tool_type_cubit.dart';
import '../cubit/select_detail_tool_cubit.dart';
import '../enum/pdf_tool_enum.dart';
import 'add_tool_widget.dart';
import 'text_style_widget.dart';

class DetailToolEdit extends StatelessWidget {
  const DetailToolEdit({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SelectDetailToolCubit, DetailToolEditEnum?>(
      builder: (context, state) {
        return Visibility(
          visible: state == null || !state.isHide,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              6.hSpace,
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  context.read<EditToolTypeCubit>().clearTool();
                  context.read<AddWatermarkCubit>().initReset();
                  context.read<AddImageCubit>().initReset();
                  context.read<AddTextCubit>().initReset();
                  context.read<SelectDetailToolCubit>().clearDetailTool();
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  child: Assets.icons.bottomSheet.backTool.svg(
                    height: 40,
                  ),
                ),
              ),
              2.hSpace,
              Expanded(
                child: BlocBuilder<EditToolTypeCubit, PdfToolEnum?>(
                    builder: (context, state) {
                  if (state == PdfToolEnum.add) {
                    return const AddToolWidget();
                  }
                  if (state == PdfToolEnum.style) {
                    return const TextStyleWidget();
                  }

                  return const SizedBox();
                }),
              ),
              12.hSpace,
            ],
          ),
        );
      },
    );
  }
}
