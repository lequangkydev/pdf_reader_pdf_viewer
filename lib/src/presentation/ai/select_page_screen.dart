import 'dart:io';
import 'dart:isolate';
import 'dart:typed_data';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:vtn_flutter_pdf/pdf.dart';

import '../../../../module/admob/utils/cached_banner_ad_util.dart';
import '../../../../module/admob/widget/ads/cached_banner_ad.dart';
import '../../../../module/tracking_screen/loggable_widget.dart';
import '../../config/navigation/app_router.dart';
import '../../data/model/file_model.dart';
import '../../shared/constants/app_colors.dart';
import '../../shared/extension/context_extension.dart';
import '../../shared/extension/number_extension.dart';
import '../../shared/extension/string_extension.dart';
import '../../shared/widgets/app_bar/custom_appbar.dart';
import '../../shared/widgets/bottom_sheet/password_bottom_sheet.dart';
import '../../shared/widgets/dialog/loading_dialog.dart';
import '../document_tool/split_pdf/cubit/pdf_grid/pdf_grid_cubit.dart';
import '../document_tool/split_pdf/cubit/pdf_grid/pdf_grid_state.dart';
import '../document_tool/split_pdf/cubit/split_pdf/split_pdf_cubit.dart';
import '../document_tool/split_pdf/widgets/page_list.dart';

@RoutePage()
class SelectPageScreen extends StatefulLoggableWidget
    implements AutoRouteWrapper {
  const SelectPageScreen({
    super.key,
    required this.pdfModel,
    this.isAITranslate = true,
  });

  final FileModel pdfModel;
  final bool isAITranslate;

  @override
  State<SelectPageScreen> createState() => _SelectPageScreenState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => PdfGridCubit()),
      ],
      child: this,
    );
  }
}

class _SelectPageScreenState extends State<SelectPageScreen> {
  String? password;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, _handleLockedPdf);
  }

  Future<void> _handleLockedPdf() async {
    final bytes = widget.pdfModel.file.readAsBytesSync();
    try {
      PdfDocument(inputBytes: bytes);
      context.read<PdfGridCubit>().prepare(original: bytes);
    } catch (e) {
      if (e is ArgumentError && e.message.contains('password')) {
        password = await showPasswordBottomSheet(
          pdfFile: widget.pdfModel.file,
          typePassword: TypePassword.enter,
          isOpen: false,
        );
        if (password.isValid && mounted) {
          context
              .read<PdfGridCubit>()
              .prepare(original: bytes, password: password);
        } else {
          context.maybePop();
        }
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('${context.l10n.anError}$e')),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) {
          return;
        }

        Navigator.of(context).pop();
      },
      child: Scaffold(
        appBar: CustomAppBar(title: context.l10n.selectPage),
        body: buildReorderListView(),
        bottomNavigationBar: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildBtn(),
            CachedBannerAd(cachedAdUtil: BannerAllUtil.instance)
          ],
        ),
      ),
    );
  }

  Widget buildReorderListView() {
    return Column(
      children: [
        12.vSpace,
        const Expanded(child: PageList()),
      ],
    );
  }

  Future<File?> convertToTempFile({
    required String fileName,
    required Uint8List bytes,
    required List<PageModel> pages,
  }) async {
    final selected = <int>[];
    for (final page in pages) {
      if (page.isSelected) {
        selected.add(page.originalIndex);
      }
    }
    if (selected.isEmpty) {
      return null;
    }

    try {
      final ttdIn = TransferableTypedData.fromList([bytes]);
      final ttdOut = await Isolate.run(
        () => splitPdfBytesTTD(ttdIn, Int32List.fromList(selected)),
      );
      final outBytes = ttdOut.materialize().asUint8List();

      final tempDir = await getTemporaryDirectory();
      final tempPath = '${tempDir.path}/$fileName.pdf';
      final file = await File(tempPath).writeAsBytes(outBytes);
      return file;
    } catch (e) {
      return null;
    }
  }

  Widget _buildBtn() {
    return BlocBuilder<PdfGridCubit, PdfGridState>(
      builder: (context, state) {
        final int selectedCount =
            state.pages.where((page) => page.isSelected).length;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: FilledButton(
            onPressed: () async {
              LoadingOverlay.show();

              final pages = context.read<PdfGridCubit>().state.pages;
              final countPage = pages.where((p) => p.isSelected).length;
              final bytes = context.read<PdfGridCubit>().state.unlockedBytes;
              if (bytes == null) {
                LoadingOverlay.hide();
                return;
              }
              final String previewPdf = state.pages[0].filePath;
              final file = await convertToTempFile(
                fileName: widget.isAITranslate ? 'translatePdf' : 'summaryPdf',
                bytes: bytes,
                pages: pages,
              );
              LoadingOverlay.hide();
              if (file == null) {
                return;
              }
              context.pushRoute(
                AIDetailRoute(
                  pdfFile: file,
                  previewPdf: File(previewPdf),
                  isAITranslate: widget.isAITranslate,
                  countPages: countPage,
                ),
              );
              return;
            },
            style: FilledButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 18),
              backgroundColor: selectedCount > 0 ? AppColors.pr : AppColors.b15,
            ),
            child: Text(context.l10n.continuePer),
          ),
        );
      },
    );
  }
}
