import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/edit_pdf_cubit.dart';
import '../cubit/position_tool_cubit.dart';
import '../cubit/select_detail_tool_cubit.dart';
import '../enum/pdf_tool_enum.dart';
import 'add_image.dart';
import 'add_signature_widget.dart';
import 'add_text.dart';
import 'add_watermark.dart';

class PdfEditableItem extends StatelessWidget {
  const PdfEditableItem({super.key, required this.pageSize});

  final Size pageSize;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SelectDetailToolCubit, DetailToolEditEnum?>(
        builder: (context, state) {
      if (state == null) {
        return const SizedBox();
      }
      context.read<EditPdfCubit>().updatePageSize(pageSize);
      context.read<PositionToolCubit>().initPosition(pageSize);
      if (state == DetailToolEditEnum.addText) {
        return AddText(pageSize: pageSize);
      }
      if (state == DetailToolEditEnum.addImage) {
        return AddImage(pageSize: pageSize);
      }
      if (state == DetailToolEditEnum.waterMark) {
        return AddWatermark(pageSize: pageSize);
      }
      if (state == DetailToolEditEnum.sign) {
        return AddImage(pageSize: pageSize);
      }
      return const SizedBox.shrink();
    });
  }
}
