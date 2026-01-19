import 'dart:async';
import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pdfx/pdfx.dart';
import 'package:vtn_flutter_pdfviewer/pdfviewer.dart';

import '../../../../module/tracking_screen/loggable_widget.dart';
import '../../../module/file_system/file_path_manager.dart';
import '../../config/navigation/app_router.dart';
import '../../data/model/file_model.dart';
import '../../gen/assets.gen.dart';
import '../../shared/constants/app_colors.dart';
import '../../shared/extension/context_extension.dart';
import '../../shared/extension/number_extension.dart';
import '../../shared/utils/toast_util.dart';
import '../../shared/widgets/color_size/color_tab.dart';
import '../../shared/widgets/color_size/cubit/select_color_cubit.dart';
import '../../shared/widgets/dialog/loading_dialog.dart';
import 'cubit/brush_pdf_cubit.dart';
import 'cubit/brush_pdf_state.dart';
import 'painter/brush_painter.dart';
import 'widgets/edit_pdf_font_slider.dart';

@RoutePage()
class BrushPdfScreen extends StatefulLoggableWidget
    implements AutoRouteWrapper {
  const BrushPdfScreen({
    super.key,
    required this.pdfFile,
    this.password,
  });

  final FileModel pdfFile;
  final String? password;

  @override
  State<BrushPdfScreen> createState() => _BrushPdfScreenState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => BrushPdfCubit(),
        ),
        BlocProvider(
          create: (context) => SelectColorCubit(),
        )
      ],
      child: this,
    );
  }
}

class _BrushPdfScreenState extends State<BrushPdfScreen> {
  late BrushPdfCubit brushCubit;
  PdfDocument? pdfDocument;
  double screenWidth = 0;

  @override
  void initState() {
    super.initState();
    // gán trực tiếp, không setState trong initState
    brushCubit = context.read<BrushPdfCubit>();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      screenWidth = MediaQuery.of(context).size.width;

      // 1) lấy kích thước trang (isolate bên trong cubit)
      await brushCubit.getPageSize(
        widget.pdfFile.file.path,
        screenWidth,
        widget.password,
      );
    });
  }

  Future<void> saveHandler() async {
    LoadingOverlay.show();
    try {
      await brushCubit.saveBrushToPdf(widget.pdfFile.file, widget.password);
      if (mounted) {
        ToastUtil.showMess(mess: context.l10n.savedSuccessfully);
      }

      try {
        final isCacheOfApp = await FilePathManager.instance
            .isFileInAppCache(widget.pdfFile.file.path);
        final newFile = File(widget.pdfFile.file.path);
        final result = isCacheOfApp
            ? File(await FilePathManager.instance.saveFileToDownloads(
                newFile.path, 'download${DateTime.now().millisecond}.pdf'))
            : widget.pdfFile.file;

        LoadingOverlay.hide();
        if (mounted) {
          context.replaceRoute(
            FileSuccessRoute(
              fileModel: widget.pdfFile.copyWith(file: result),
              title: context.l10n.editPdfSuccess,
            ),
          );
        }
      } catch (error) {
        debugPrint("error:$error");
        debugPrint('Error while saving edited PDF: $error');
        if (context.mounted) {
          LoadingOverlay.hide();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(error.toString())),
          );
        }
      }
    } catch (e) {
      LoadingOverlay.hide();
      debugPrint('Error: $e');
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BrushPdfCubit, BrushPdfState>(
      bloc: brushCubit,
      listenWhen: (previous, current) =>
          previous.focusedPage != current.focusedPage,
      listener: (_, __) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            scrolledUnderElevation: 0,
            leading: IconButton(
              onPressed: context.maybePop,
              icon: const Icon(
                Icons.close,
                color: Colors.black,
                size: 24,
              ),
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: brushCubit.undo,
                  icon: Assets.icons.undo.svg(
                    colorFilter: ColorFilter.mode(
                      state.undoStack.isEmpty ? Colors.grey : AppColors.pr,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: brushCubit.redo,
                  icon: Assets.icons.redo.svg(
                    colorFilter: ColorFilter.mode(
                      state.redoStack.isEmpty ? Colors.grey : AppColors.pr,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ],
            ),
            actions: [
              IconButton(
                onPressed: state.undoStack.isNotEmpty ? saveHandler : null,
                icon: Assets.icons.check.svg(),
              ),
              16.hSpace,
            ],
          ),
          body: SfPdfViewer.file(
            widget.pdfFile.file,
            password: widget.password,
            pageBuilder: (context, index, child, pageSize) {
              final displayHeight = pageSize.height;
              return Stack(
                children: [
                  GestureDetector(
                    onPanUpdate: (details) {
                      double clampedX =
                          details.localPosition.dx.clamp(0, screenWidth);
                      final double clampedY =
                          details.localPosition.dy.clamp(0, displayHeight);

                      if (context.isRTL) {
                        clampedX = screenWidth - clampedX;
                      }

                      brushCubit.brushPoint(
                        index,
                        Offset(
                          clampedX,
                          clampedY + (state.strokeWidth / 2),
                        ),
                        displayHeight,
                      );
                    },
                    onPanStart: (_) {
                      brushCubit.saveBrushState();
                    },
                    onPanEnd: (_) {
                      brushCubit.brushPoint(index, Offset.zero, displayHeight);
                    },
                    child: Directionality(
                      textDirection: TextDirection.ltr,
                      child: Hero(
                        tag: 'page:$index',
                        child: child,
                      ),
                    ),
                  ),

                  // chỉ vẽ lớp brush của page hiện tại (BlocSelector có thể tối ưu thêm)
                  if (state.brushPoints.isNotEmpty)
                    IgnorePointer(
                      child: Stack(
                        children: state.brushPoints
                            .where((e) => e.currentPage == index)
                            .map((e) {
                          return CustomPaint(
                            size: Size(double.infinity, displayHeight),
                            painter: BrushPainter(
                              points: e.points,
                              isRTL: context.isRTL,
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                ],
              );
            },
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.symmetric(vertical: 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                BlocListener<SelectColorCubit, Color?>(
                  listenWhen: (previous, current) => previous != current,
                  listener: (_, color) {
                    brushCubit.onChangeColor(color ?? AppColors.pr);
                  },
                  bloc: context.read<SelectColorCubit>(),
                  child: ColorsTab(
                    selectColorCubit: context.read<SelectColorCubit>(),
                    initialColor: state.color,
                  ),
                ),
                16.vSpace,
                EditPdfFontSlider(
                  label: state.strokeWidth.toString(),
                  value: state.strokeWidth,
                  min: 1,
                  max: 32,
                  onChanged: brushCubit.onChangeStrokeWidth,
                  prefix: Text(
                    context.l10n.size,
                    style: const TextStyle(fontSize: 12),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
