part of '../edit_pdf_screen.dart';

class EditPdfAppBar extends StatelessWidget implements PreferredSizeWidget {
  const EditPdfAppBar({
    super.key,
    required this.pdfFile,
    required this.password,
    required this.undoController,
    required this.pdfViewerController,
  });

  final FileModel pdfFile;
  final String? password;
  final UndoHistoryController undoController;
  final PdfViewerController pdfViewerController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SelectDetailToolCubit, DetailToolEditEnum?>(
      builder: (context, state) {
        return CustomAppBar(
          leadingWidget: Assets.icons.icClose.svg(),
          onBack: () {
            if (state != null) {
              context.read<SelectDetailToolCubit>().clearDetailTool();
              context.read<EditToolTypeCubit>().clearTool();
            } else {
              Navigator.of(context).popUntil(
                  (route) => route.settings.name == ViewPdfRoute.name);
            }
          },
          titleWidget: BlocBuilder<SelectDetailToolCubit, DetailToolEditEnum?>(
            builder: (context, state) {
              final l10n = context.l10n;
              final title = switch (state) {
                DetailToolEditEnum.waterMark => l10n.addWatermark,
                DetailToolEditEnum.addImage => l10n.addImage,
                DetailToolEditEnum.addText => l10n.addText,
                _ => l10n.editPdf,
              };

              if (state != null && state.isStyle) {
                return _buildUndoRedoActions(context);
              }
              return Text(
                title,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                ),
              );
            },
          ),
          actionWidget: [
            BlocBuilder<SelectDetailToolCubit, DetailToolEditEnum?>(
              builder: (context, detailTool) {
                if (detailTool == null) {
                  return const SizedBox.shrink();
                }

                return GestureDetector(
                  onTap: () async {
                    try {
                      LoadingOverlay.show();
                      final editPdfCubit = context.read<EditPdfCubit>();
                      final position = context.read<PositionToolCubit>().state;
                      final currentPage = editPdfCubit.state.currentPage;
                      final currentPageSize =
                          editPdfCubit.state.currentPageSize;

                      final hasAnnotation =
                          context.read<AddStylePdfCubit>().hasAnnotation;
                      FileModel baseFile = pdfFile;
                      // 1. Lưu annotation nếu có
                      if (hasAnnotation) {
                        final result = await saveAnnotation();
                        if (result != null) {
                          baseFile = result;
                        }
                      }
                      // 2. Lưu text nếu có
                      final hasText =
                          context.read<AddTextCubit>().state.text.isNotEmpty;
                      if (hasText & context.mounted) {
                        final result =
                            await context.read<AddTextCubit>().onSavePressed(
                                  pdfFile: baseFile,
                                  password: password,
                                  position: position,
                                  currentPage: currentPage,
                                  currentPageSize: currentPageSize,
                                );
                        if (result != null) {
                          baseFile = result;
                        }
                      }

                      // 3. Lưu image / watermark nếu có
                      final hasImage =
                          context.read<AddImageCubit>().state.image != null;
                      if (hasImage) {
                        final result =
                            await context.read<AddImageCubit>().onSavePressed(
                                  pdfFile: baseFile,
                                  password: password,
                                  position: position,
                                  currentPage: currentPage,
                                  currentPageSize: currentPageSize,
                                );
                        if (result != null) {
                          baseFile = result;
                        }
                      }

                      final hasWatermark = context
                          .read<AddWatermarkCubit>()
                          .state
                          .text
                          .isNotEmpty;
                      if (hasWatermark) {
                        final result = await context
                            .read<AddWatermarkCubit>()
                            .onSavePressed(
                              pdfFile: baseFile,
                              password: password,
                              position: position,
                              currentPage: currentPage,
                              currentPageSize: currentPageSize,
                            );
                        if (result != null) {
                          baseFile = result;
                        }
                      }
                      // 4. Navigate success
                      await savePdfAndNavigate(context, baseFile);
                    } catch (error) {
                      showToast(error.toString());
                    } finally {
                      LoadingOverlay.hide();
                    }
                  },
                  child: Assets.icons.check.svg(),
                );
              },
            ),
            16.hSpace,
          ],
        );
      },
    );
  }

  Widget _buildUndoButton() {
    return ValueListenableBuilder(
      valueListenable: undoController,
      builder: (context, value, child) {
        return IconButton(
          onPressed: undoController.value.canUndo ? undoController.undo : null,
          icon: Assets.icons.undo.svg(
            width: 24,
            colorFilter: ColorFilter.mode(
              undoController.value.canUndo ? AppColors.pr : Colors.grey,
              BlendMode.srcIn,
            ),
          ),
        );
      },
    );
  }

  Widget _buildRedoButton() {
    return ValueListenableBuilder(
      valueListenable: undoController,
      builder: (context, value, child) {
        return IconButton(
          onPressed: undoController.value.canRedo ? undoController.redo : null,
          icon: Assets.icons.redo.svg(
            width: 24,
            colorFilter: ColorFilter.mode(
              undoController.value.canRedo ? AppColors.pr : Colors.grey,
              BlendMode.srcIn,
            ),
          ),
        );
      },
    );
  }

  Widget _buildUndoRedoActions(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Spacer(),
        _buildUndoButton(),
        _buildRedoButton(),
        const Spacer(),
      ],
    );
  }

  Future<FileModel?> saveAnnotation() async {
    try {
      final bytes = await pdfViewerController.saveDocument();
      PdfSection? section;
      final PdfDocument document = PdfDocument(inputBytes: bytes);
      // tạo 1 document để set lại password
      final PdfDocument lockedDocument = PdfDocument();
      for (int i = 0; i < document.pages.count; i++) {
        final PdfPage page = document.pages[i];
        final PdfTemplate template = page.createTemplate();

        if (section == null ||
            section.pageSettings.size.width != template.size.width ||
            section.pageSettings.size.height != template.size.height) {
          section = lockedDocument.sections!.add();
          section.pageSettings.size = template.size;
          section.pageSettings.margins.all = 0;
        }

        final PdfPage newPage = section.pages.add();
        newPage.graphics.drawPdfTemplate(template, Offset.zero);

        for (int j = 0; j < page.annotations.count; j++) {
          newPage.annotations.add(page.annotations[j]);
        }
      }

      // for (int i = 0; i < document.pages.count; i++) {
      //   final PdfPage page = document.pages[i];
      //
      //   final PdfTemplate template = page.createTemplate();
      //
      //   if (section == null || section.pageSettings.size != template.size) {
      //     section = lockedDocument.sections!.add();
      //     section.pageSettings.size = template.size;
      //     section.pageSettings.margins.all = 0;
      //   }
      //   section.pages.add().graphics.drawPdfTemplate(template, Offset.zero);
      //   for (int j = 0; j < page.annotations.count; j++) {
      //     final PdfAnnotation annotation = page.annotations[j];
      //     section.pages[i].annotations.add(annotation);
      //   }
      // }

      if (password != null) {
        lockedDocument.security.userPassword = password!;
      }
      final List<int> lockedPdfBytes = lockedDocument.saveSync();

      final file = await pdfFile.file.writeAsBytes(lockedPdfBytes, flush: true);
      return pdfFile.copyWith(file: file);
    } catch (error) {
      return null;
    }
  }

  Future<void> savePdfAndNavigate(
      BuildContext context, FileModel fileModel) async {
    try {
      final bytes = PdfDocument(
              inputBytes: await fileModel.file.readAsBytes(),
              password: password)
          .saveSync();

      final isCacheOfApp =
          await FilePathManager.instance.isFileInAppCache(fileModel.file.path);

      final file = await fileModel.file.writeAsBytes(bytes, flush: true);
      final newFile = File(file.path);
      final result = isCacheOfApp
          ? File(await FilePathManager.instance.saveFileToDownloads(
              newFile.path, 'download${DateTime.now().toIso8601String()}.pdf'))
          : file;

      if (context.mounted) {
        context.replaceRoute(
          FileSuccessRoute(
            fileModel: fileModel.copyWith(file: result),
            title: context.l10n.editPdfSuccess,
          ),
        );
      }
    } catch (error) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(error.toString())),
        );
      }
    }
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
