import 'dart:async';
import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vtn_flutter_pdf/pdf.dart';
import 'package:vtn_flutter_pdfviewer/pdfviewer.dart';

import '../../../../module/admob/utils/cached_banner_ad_util.dart';
import '../../../../module/admob/widget/ads/cached_banner_ad.dart';
import '../../../../module/file_system/file_path_manager.dart';
import '../../../config/navigation/app_router.dart';
import '../../../data/model/file_model.dart';
import '../../../gen/assets.gen.dart';
import '../../../global/global.dart';
import '../../../shared/constants/app_colors.dart';
import '../../../shared/extension/context_extension.dart';
import '../../../shared/extension/number_extension.dart';
import '../../../shared/widgets/app_bar/custom_appbar.dart';
import '../../../shared/widgets/bottom_sheet/password_bottom_sheet.dart';
import '../../../shared/widgets/dialog/loading_dialog.dart';
import 'cubit/add_image_cubit.dart';
import 'cubit/add_signature_cubit.dart';
import 'cubit/add_style_pdf_cubit.dart';
import 'cubit/add_text_cubit.dart';
import 'cubit/add_watermark_cubit.dart';
import 'cubit/edit_pdf_cubit.dart';
import 'cubit/edit_tool_type_cubit.dart';
import 'cubit/position_tool_cubit.dart';
import 'cubit/select_detail_tool_cubit.dart';
import 'enum/pdf_tool_enum.dart';
import 'model/edit_pdf_state.dart';
import 'widgets/add_text_bottom_sheet.dart';
import 'widgets/pdf_editable_item.dart';
import 'widgets/tool_edit_pdf.dart';

part 'widgets/edit_pdf_appbar.dart';

final GlobalKey positionToolKey = GlobalKey();
BuildContext? contextEditPdf;

@RoutePage()
class EditPdfScreen extends StatefulWidget implements AutoRouteWrapper {
  const EditPdfScreen({
    super.key,
    required this.pdfFile,
    this.password,
  });

  final FileModel pdfFile;
  final String? password;

  @override
  State<EditPdfScreen> createState() => _EditPdfScreenState();

  @override
  Widget wrappedRoute(BuildContext context) {
    contextEditPdf = context;
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => EditToolTypeCubit(),
        ),
        BlocProvider(
          create: (context) => SelectDetailToolCubit(),
        ),
        BlocProvider(
          create: (context) => AddTextCubit(),
        ),
        BlocProvider(
          create: (context) => AddImageCubit(),
        ),
        BlocProvider(
          create: (context) => AddWatermarkCubit(),
        ),
        BlocProvider(
          create: (context) => PositionToolCubit(),
        ),
        BlocProvider(
          create: (context) => EditPdfCubit(),
        ),
        BlocProvider(
          create: (context) => AddStylePdfCubit(),
        ),
        BlocProvider(
          create: (context) => AddSignatureCubit(),
        ),
      ],
      child: this,
    );
  }
}

class _EditPdfScreenState extends State<EditPdfScreen> {
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();
  final PdfViewerController _pdfViewerController = PdfViewerController();
  final UndoHistoryController _undoController = UndoHistoryController();
  String? _password;

  late SelectDetailToolCubit detailToolCubit;
  late AddStylePdfCubit stylePdfCubit;

  @override
  void initState() {
    super.initState();
    _password = widget.password;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    detailToolCubit = context.read<SelectDetailToolCubit>();
    stylePdfCubit = context.read<AddStylePdfCubit>();
    context.read<AddStylePdfCubit>().setPdfViewCtrl(_pdfViewerController);
    context.read<AddStylePdfCubit>().setPdfViewKey(_pdfViewerKey);
  }

  @override
  void dispose() {
    contextEditPdf = null;
    _pdfViewerController.dispose();
    _undoController.dispose();
    super.dispose();
  }

  Future<void> _handleDocumentLoadFailed(
      PdfDocumentLoadFailedDetails details) async {
    if (details.description.contains('password')) {
      final password = await showPasswordBottomSheet(
        pdfFile: widget.pdfFile.file,
        typePassword: TypePassword.enter,
        isOpen: true,
      );

      if (password != null && context.mounted) {
        setState(() {
          _password = password;
        });
        return;
      }

      if (mounted) {
        context.maybePop();
        return;
      }
    }
    if (mounted) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(details.description)));
      context.maybePop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<SelectDetailToolCubit, DetailToolEditEnum?>(
          listener: (context, state) async {
            final addTextCubit = context.read<AddTextCubit>();
            final addWatermarkCubit = context.read<AddWatermarkCubit>();
            if (state == DetailToolEditEnum.addText) {
              showTextEditorBottomSheet(
                context: contextEditPdf!,
                title: context.l10n.addText,
                text: addTextCubit.state.text,
                color: addTextCubit.state.colorText,
                onTextChanged: addTextCubit.onTextChanged,
                onColorChanged: addTextCubit.onColorChanged,
              );
            }
            if (state == DetailToolEditEnum.waterMark) {
              showTextEditorBottomSheet(
                context: context,
                title: context.l10n.watermarkContent,
                text: addWatermarkCubit.state.text,
                color: addWatermarkCubit.state.colorText,
                onTextChanged: addWatermarkCubit.onTextChanged,
                onColorChanged: addWatermarkCubit.onColorChanged,
              );
            }
            if (state == DetailToolEditEnum.brush) {
              await context.pushRoute(
                BrushPdfRoute(
                  pdfFile: widget.pdfFile,
                  password: _password,
                ),
              );
              if (context.mounted) {
                context.read<SelectDetailToolCubit>().clearDetailTool();
              }
              return;
            }
          },
        ),
      ],
      child: PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) {
          if (didPop) {
            return;
          }
          final DetailToolEditEnum? stateStyle =
              context.read<SelectDetailToolCubit>().state;
          if (stateStyle != null && stateStyle.isStyle) {
            return;
          }
          Navigator.of(context)
              .popUntil((route) => route.settings.name == ViewPdfRoute.name);
        },
        child: Scaffold(
          backgroundColor: Colors.transparent,
          resizeToAvoidBottomInset: true,
          appBar: EditPdfAppBar(
            pdfFile: widget.pdfFile,
            password: _password,
            pdfViewerController: _pdfViewerController,
            undoController: _undoController,
          ),
          body: SfPdfViewer.file(
            key: _pdfViewerKey,
            widget.pdfFile.file,
            password: _password,
            controller: _pdfViewerController,
            undoController: _undoController,
            maxZoomLevel: 1,
            canShowPasswordDialog: false,
            canShowScrollHead: false,
            canShowScrollStatus: false,
            enableDoubleTapZooming: false,
            canShowTextSelectionMenu: false,
            canShowPageLoadingIndicator: false,
            onPageChanged: (details) {
              if (context.read<SelectDetailToolCubit>().state == null) {
                context.read<EditPdfCubit>().updatePage(details.newPageNumber);
              }
            },
            onTextSelectionChanged: (details) {
              if (!mounted) {
                return;
              }
              stylePdfCubit.selectText(
                detail: details,
                currentTool: detailToolCubit.state,
              );
            },
            onDocumentLoadFailed: (details) {
              _handleDocumentLoadFailed(details);
              context.read<EditPdfCubit>().setFailure(details.error);
            },
            onDocumentLoaded: (PdfDocumentLoadedDetails details) {
              context.read<EditPdfCubit>().setSuccess();
            },
            pageBuilder: (contextPageBuilder, index, child, pageSize) {
              return ClipRect(
                child: Stack(
                  children: [
                    child,
                    BlocBuilder<EditPdfCubit, EditPdfState>(
                      builder: (context, stateEdit) {
                        if (stateEdit.currentPage != index + 1) {
                          return const SizedBox.shrink();
                        }
                        return PdfEditableItem(pageSize: pageSize);
                      },
                    ),
                  ],
                ),
              );
            },
          ),
          bottomNavigationBar: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const ToolEditPDf(),
              CachedBannerAd(cachedAdUtil: BannerAllUtil.instance)
            ],
          ),
        ),
      ),
    );
  }
}
