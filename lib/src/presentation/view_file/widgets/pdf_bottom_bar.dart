import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../gen/assets.gen.dart';
import '../../../shared/constants/app_colors.dart';
import '../../../shared/extension/context_extension.dart';
import '../cubit/pdf_bottom_cubit.dart';
import '../cubit/toggle_ui_cubit.dart';

class PdfBottomBar extends StatelessWidget {
  const PdfBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    final items = [
      _PdfBottomItem(
        icon: Assets.icons.bottomSheet.page,
        label: context.l10n.page,
        pdfBottomType: PdfBottomBarType.page,
      ),
      _PdfBottomItem(
        icon: Assets.icons.bottomSheet.edit,
        label: context.l10n.editPdf,
        pdfBottomType: PdfBottomBarType.edit,
      ),
      _PdfBottomItem(
        icon: Assets.icons.bottomSheet.print,
        label: context.l10n.print,
        pdfBottomType: PdfBottomBarType.print,
      ),
      _PdfBottomItem(
        icon: Assets.icons.bottomSheet.share,
        label: context.l10n.share,
        pdfBottomType: PdfBottomBarType.share,
      ),
      _PdfBottomItem(
        icon: Assets.icons.bottomSheet.menu,
        label: context.l10n.more,
        pdfBottomType: PdfBottomBarType.more,
      ),
    ];

    return BlocBuilder<ToggleUiCubit, ToggleUiState>(
      builder: (context, stateUI) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: const BoxDecoration(
            color: Colors.white,
            border: Border(
              top: BorderSide(
                color: AppColors.f2f2,
              ),
            ),
          ),
          child: AnimatedSize(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (Widget child, Animation<double> animation) {
                return FadeTransition(
                  opacity: animation,
                  child: child,
                );
              },
              child: !stateUI.isVisible
                  ? const SizedBox.shrink(key: ValueKey('empty'))
                  : BlocBuilder<PdfBottomBarCubit, PdfBottomBarType?>(
                      builder: (context, pdfState) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: List.generate(items.length, (index) {
                              return Expanded(
                                child: GestureDetector(
                                  onTap: () => context
                                      .read<PdfBottomBarCubit>()
                                      .tabType(items[index].pdfBottomType),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      items[index].icon.svg(width: 24),
                                      const SizedBox(height: 4),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 4),
                                        child: Text(
                                          items[index].label,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                            fontSize: 12,
                                            color: Color(0xff808080),
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                          ),
                        );
                      },
                    ),
            ),
          ),
        );
      },
    );
  }
}

class _PdfBottomItem {
  const _PdfBottomItem({
    required this.icon,
    required this.label,
    required this.pdfBottomType,
  });

  final SvgGenImage icon;
  final String label;
  final PdfBottomBarType pdfBottomType;
}
