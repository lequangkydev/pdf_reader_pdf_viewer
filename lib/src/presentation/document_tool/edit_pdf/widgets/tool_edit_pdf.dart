import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/navigation/app_router.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../shared/constants/app_colors.dart';
import '../../../../shared/extension/context_extension.dart';
import '../../../../shared/extension/number_extension.dart';
import '../cubit/add_image_cubit.dart';
import '../cubit/edit_pdf_cubit.dart';
import '../cubit/edit_tool_type_cubit.dart';
import '../cubit/select_detail_tool_cubit.dart';
import '../enum/pdf_tool_enum.dart';
import '../model/edit_pdf_state.dart';
import 'detail_tool_edit.dart';

class ToolEditPDf extends StatelessWidget {
  const ToolEditPDf({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditPdfCubit, EditPdfState>(
      builder: (context, state) {
        if (state.status != PdfLoadStatus.success) {
          return const SizedBox.shrink();
        }
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              top: BorderSide(
                color: Colors.black.withValues(alpha: 0.25),
              ),
            ),
          ),
          child: BlocBuilder<EditToolTypeCubit, PdfToolEnum?>(
            builder: (context, state) {
              if (state == null) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    BottomSheetItem(
                      icon: Assets.icons.bottomSheet.add,
                      label: context.l10n.add,
                      onTap: () => context
                          .read<EditToolTypeCubit>()
                          .selectTool(PdfToolEnum.add),
                    ),
                    BottomSheetItem(
                      icon: Assets.icons.bottomSheet.textStyle,
                      label: context.l10n.textStyle,
                      onTap: () => context
                          .read<EditToolTypeCubit>()
                          .selectTool(PdfToolEnum.style),
                    ),
                    BottomSheetItem(
                      icon: Assets.icons.bottomSheet.sign,
                      label: context.l10n.sign,
                      onTap: () async {
                        final result = await context
                            .pushRoute<File?>(const SignatureRoute());
                        if (result != null && context.mounted) {
                          context
                              .read<EditToolTypeCubit>()
                              .selectTool(PdfToolEnum.sign);
                          context
                              .read<SelectDetailToolCubit>()
                              .selectDetailTool(DetailToolEditEnum.sign);
                          context.read<AddImageCubit>().changeSignature(true);
                          context.read<AddImageCubit>().changeImage(result);
                        }
                      },
                    ),
                  ],
                );
              }
              return const DetailToolEdit();
            },
          ),
        );
      },
    );
  }
}

class BottomSheetItem extends StatelessWidget {
  const BottomSheetItem({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
    this.isSelect = false,
  });

  final SvgGenImage icon;
  final String label;
  final VoidCallback onTap;
  final bool isSelect;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            icon.svg(
              width: 24,
              colorFilter: isSelect
                  ? const ColorFilter.mode(AppColors.pr, BlendMode.srcIn)
                  : null,
            ),
            4.vSpace,
            Text(
              label,
              maxLines: 1,
              style: TextStyle(
                overflow: TextOverflow.ellipsis,
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: isSelect ? AppColors.pr : const Color(0xff222222),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
