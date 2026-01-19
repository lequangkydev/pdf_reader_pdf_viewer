import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../../gen/assets.gen.dart';
import '../../../../global/global.dart';
import '../../../../shared/extension/context_extension.dart';
import '../../../../shared/extension/number_extension.dart';
import '../cubit/add_style_pdf_cubit.dart';
import '../cubit/select_detail_tool_cubit.dart';
import '../enum/pdf_tool_enum.dart';
import '../model/add_style_pdf_state.dart';
import 'colors_widget.dart';
import 'tool_edit_pdf.dart';

class TextStyleWidget extends StatelessWidget {
  const TextStyleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SelectDetailToolCubit, DetailToolEditEnum?>(
      builder: (context, state) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (state != null && state != DetailToolEditEnum.brush)
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                child: BlocBuilder<AddStylePdfCubit, AddStylePdfState>(
                    builder: (context, state) {
                  return ColorsTab(
                    initialColor: state.colorStyle,
                    onColorSelected: (value) {
                      context.read<AddStylePdfCubit>().changeColor(value);
                    },
                  );
                }),
              ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: BottomSheetItem(
                    icon: Assets.icons.bottomSheet.brush,
                    label: context.l10n.brush,
                    isSelect: state == DetailToolEditEnum.brush,
                    onTap: () => context
                        .read<SelectDetailToolCubit>()
                        .selectDetailTool(DetailToolEditEnum.brush),
                  ),
                ),
                4.hSpace,
                Expanded(
                  child: BottomSheetItem(
                    icon: Assets.icons.bottomSheet.highlight,
                    label: context.l10n.highlight,
                    isSelect: state == DetailToolEditEnum.highlight,
                    onTap: () {
                      showToast(context.l10n.selectText,
                          toastGravity: ToastGravity.CENTER,
                          toastLength: Toast.LENGTH_SHORT);
                      context
                          .read<SelectDetailToolCubit>()
                          .selectDetailTool(DetailToolEditEnum.highlight);
                    },
                  ),
                ),
                4.hSpace,
                Expanded(
                  child: BottomSheetItem(
                    icon: Assets.icons.bottomSheet.unline,
                    label: context.l10n.underline,
                    isSelect: state == DetailToolEditEnum.unline,
                    onTap: () {
                      showToast(context.l10n.selectText,
                          toastGravity: ToastGravity.CENTER,
                          toastLength: Toast.LENGTH_SHORT);
                      context
                          .read<SelectDetailToolCubit>()
                          .selectDetailTool(DetailToolEditEnum.unline);
                    },
                  ),
                ),
                4.hSpace,
                Expanded(
                  child: BottomSheetItem(
                    icon: Assets.icons.bottomSheet.strike,
                    label: context.l10n.strikethrough,
                    isSelect: state == DetailToolEditEnum.strike,
                    onTap: () {
                      showToast(context.l10n.selectText,
                          toastGravity: ToastGravity.CENTER,
                          toastLength: Toast.LENGTH_SHORT);
                      context
                          .read<SelectDetailToolCubit>()
                          .selectDetailTool(DetailToolEditEnum.strike);
                    },
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
