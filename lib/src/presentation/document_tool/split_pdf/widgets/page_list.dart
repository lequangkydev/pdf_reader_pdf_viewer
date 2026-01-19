import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reorderable_grid/reorderable_grid.dart';

import '../../../../../module/log_event_app/split_pdf_event.dart';
import '../../../../../module/tracking_screen/screen_logger.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../shared/constants/app_colors.dart';
import '../cubit/pdf_grid/pdf_grid_cubit.dart';
import '../cubit/pdf_grid/pdf_grid_state.dart';
import 'show_image_preview.dart';
import 'tiles.dart';

class PageList extends StatefulWidget {
  const PageList({super.key});

  @override
  State<PageList> createState() => PageListState();
}

class PageListState extends State<PageList> {
  bool _dragging = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PdfGridCubit, PdfGridState>(
      buildWhen: (prev, curr) => !_dragging,
      builder: (context, state) {
        if (state.status == PdfGridStatus.preparing) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state.status == PdfGridStatus.error) {
          return Center(
            child: Text('Lỗi: ${state.error}'),
          );
        }

        // 1) Số trang đã tải xong (được Cubit cập nhật bằng nextPageIndex)
        final int loadedCount = state.nextPageIndex;

        // 2) Hiển thị thêm một ít placeholder để cuộn mượt
        const int kPlaceholders = 9; // nếu crossAxisCount=3 => 3 hàng
        final int visibleCount =
            (loadedCount + kPlaceholders).clamp(0, state.pageCount);

        return ReorderableGridView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 0.7,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          itemCount: visibleCount,
          onReorder: (oldIndex, newIndex) {
            _dragging = false;
            context.read<PdfGridCubit>().reorderPage(oldIndex, newIndex);
            context.read<PdfGridCubit>().startAutoLoading();
          },
          onReorderStart: (_) {
            _dragging = true;
            context.read<PdfGridCubit>().stopAutoLoading();
          },
          itemBuilder: (context, index) {
            if (index < loadedCount) {
              final page = state.pages[index];

              return GestureDetector(
                key: ValueKey(page.originalIndex),
                onTap: () {
                  if (page.isSelected) {
                    AnalyticLogger.instance.logEventWithScreen(
                        event: SplitPdfEvent.user_unSelect_page_split);
                  } else {
                    AnalyticLogger.instance.logEventWithScreen(
                        event: SplitPdfEvent.user_select_page_split);
                  }
                  context.read<PdfGridCubit>().toggleSelection(index);
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                      color: page.isSelected
                          ? AppColors.pr
                          : AppColors.colorE6E6E6,
                    ),
                  ),
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: Image.file(
                          File(page.filePath),
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        top: 8,
                        right: 8,
                        child: page.isSelected
                            ? Assets.icons.checkboxFill.svg(width: 16)
                            : Assets.icons.unCheckbox.svg(width: 16),
                      ),
                      Positioned(
                        bottom: 8,
                        right: 8,
                        child: GestureDetector(
                          onTap: () async {
                            final result = await showImagePreviewDialog(
                              context,
                              imagePath: page.filePath,
                              isSelect: page.isSelected,
                            );
                            if (result != null && context.mounted) {
                              context
                                  .read<PdfGridCubit>()
                                  .toggleSelection(index);
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(
                                    alpha: 0.25,
                                  ),
                                  blurRadius: 10,
                                )
                              ],
                            ),
                            child: Assets.icons.zoom.svg(width: 20),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
            }
            // Các ô từ loadedCount .. visibleCount-1 -> placeholder (chưa tải)
            return ShimmerTile(
              key: ValueKey('loading3_$index'),
            );
          },
        );
      },
    );
  }
}
