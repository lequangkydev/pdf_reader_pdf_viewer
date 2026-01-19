import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart' as ui;
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:uuid/uuid.dart';
import 'package:vtn_flutter_pdf/pdf.dart';

import '../../../module/admob/utils/utils.dart';
import '../../../module/admob/widget/ads/banner_ad.dart';
import '../../../module/file_system/file_path_manager.dart';
import '../../config/di/di.dart';
import '../../config/navigation/app_router.dart';
import '../../data/model/document_model.dart';
import '../../data/model/file_model.dart';
import '../../data/model/translate_model.dart';
import '../../gen/assets.gen.dart';
import '../../shared/extension/context_extension.dart';
import '../../shared/extension/number_extension.dart';
import '../../shared/screen/cubit/bottom_tab_cubit.dart';
import '../../shared/widgets/app_bar/custom_appbar.dart';
import '../../shared/widgets/bottom_sheet/rename_bottom_sheet.dart';
import '../../shared/widgets/dialog/loading_dialog.dart';
import '../all_documents/cubit/pdf_cubit.dart';

@RoutePage()
class AIResultScreen extends StatelessWidget {
  AIResultScreen({super.key, this.summaryModel, this.translateModel});

  final DocumentModel? summaryModel;
  final TranslateModel? translateModel;
  final GlobalKey previewKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: context.l10n.result,
        onBack: context.maybePop,
        actionWidget: [
          GestureDetector(
            child: Assets.icons.backHome.svg(),
            onTap: () async {
              if (context.mounted) {
                getIt<BottomTabCubit>().changeTab(BottomTab.document);
                context.router.popUntilRoot();
              }
            },
          ),
          16.hSpace,
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: SingleChildScrollView(child: _buildPreviewCard(context)),
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: _buildDownloadButton(context),
          ),
          20.vSpace,
          CustomBanner(adConfig: adUnitsConfig.bannerAll),
        ],
      ),
    );
  }

  Widget _buildPreviewCard(BuildContext context) {
    final bool isTranslate = translateModel != null;
    final bool isSummary = summaryModel != null;

    if (!isTranslate && !isSummary) {
      return _buildEmptyCard(context);
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xffF5F5F5),
          width: 0.5,
        ),
      ),
      child: RepaintBoundary(
        key: previewKey,
        child: isTranslate
            ? _buildTranslateView(context, translateModel!)
            : _buildSummaryView(context, summaryModel!),
      ),
    );
  }

  Widget _buildEmptyCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xffF5F5F5), width: 0.5),
      ),
      child: const Center(
        child: Text(
          'No data to preview.',
          style: TextStyle(color: Colors.grey),
        ),
      ),
    );
  }

  Widget _buildRichLine(String label, String content) {
    return RichText(
      text: TextSpan(
        text: '$label: ',
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black,
          fontSize: 15,
        ),
        children: [
          TextSpan(
            text: content,
            style: const TextStyle(
              fontWeight: FontWeight.normal,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDownloadButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: FilledButton.icon(
        onPressed: () async {
          final newName = await showRenameDialog(
            context: context,
            defaultName: summaryModel != null
                ? 'pdfSummary${DateTime.now().millisecondsSinceEpoch}'
                : (translateModel != null
                    ? 'pdfTranslate${DateTime.now().millisecondsSinceEpoch}'
                    : 'pdfAI${DateTime.now().millisecondsSinceEpoch}'),
          );
          if (newName == null) {
            return;
          }
          LoadingOverlay.show();
          final result = await exportToPdf(newName);
          LoadingOverlay.hide();
          if (result != null) {
            final file = FileModel(
              id: const Uuid().v1(),
              file: result,
            );
            getIt<PdfCubit>().addFile(file);
            context.replaceRoute(
              FileSuccessRoute(
                fileModel: file,
                title: context.l10n.downloadSuccess,
                aiSuccess: true,
              ),
            );
          }
        },
        icon: Assets.icons.download.svg(),
        label: Text(
          context.l10n.download,
          style: const ui.TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: ui.FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Future<File?> exportToPdf(String name) async {
    try {
      // 1️⃣ Chụp ảnh từ RepaintBoundary
      final boundary = previewKey.currentContext!.findRenderObject()!
          as ui.RenderRepaintBoundary;
      final image = await boundary.toImage(pixelRatio: 3);
      final byteData = await image.toByteData(format: ImageByteFormat.png);
      final pngBytes = byteData!.buffer.asUint8List();

      // 2️⃣ Gọi hàm tạo PDF từ ảnh (không cần lưu file ảnh tạm)
      final pdfBytes = await _generatePdfFromMemoryImage(pngBytes);

      // 3️⃣ Lưu PDF ra file để xem thử
      final filePath = await FilePathManager.instance
          .saveBytesToDownloads(pdfBytes, '$name.pdf');
      final file = File(filePath);
      print('✅ PDF exported: ${file.path}');
      return file;
    } catch (e, st) {
      print('❌ exportToPdf error: $e');
      return null;
    }
  }

  Future<List<int>> _generatePdfFromMemoryImage(Uint8List pngBytes) async {
    final document = PdfDocument();
    final pdfImage = PdfBitmap(pngBytes);
    final page = document.pages.add();

    final pageSize = page.getClientSize();
    final imageWidth = pdfImage.width.toDouble();
    final imageHeight = pdfImage.height.toDouble();

    final pageAspect = pageSize.width / pageSize.height;
    final imageAspect = imageWidth / imageHeight;

    double drawWidth;
    double drawHeight;

    if (imageAspect > pageAspect) {
      drawWidth = pageSize.width;
      drawHeight = pageSize.width / imageAspect;
    } else {
      drawHeight = pageSize.height;
      drawWidth = pageSize.height * imageAspect;
    }

    final offsetX = (pageSize.width - drawWidth) / 2;
    final offsetY = (pageSize.height - drawHeight) / 2;

    page.graphics.drawImage(
      pdfImage,
      Rect.fromLTWH(offsetX, offsetY, drawWidth, drawHeight),
    );

    final bytes = await document.save();
    document.dispose();
    return bytes;
  }

  Widget _buildTranslateView(BuildContext context, TranslateModel model) {
    if ((model.content ?? '').trim().isEmpty) {
      return Text(
        context.l10n.noTranslate,
        style: const TextStyle(fontSize: 14, color: Colors.grey),
      );
    }

    return HtmlWidget(
      model.content!,
      textStyle: const TextStyle(
        fontSize: 14,
        height: 1.4,
        color: Color(0xff222222),
      ),
    );
  }

  Widget _buildSummaryView(BuildContext context, DocumentModel model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.l10n.preview,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 12),
        _buildRichLine(context.l10n.title, model.title ?? '—'),
        _buildRichLine(context.l10n.type, model.type ?? '—'),
        const SizedBox(height: 8),
        _buildRichLine(context.l10n.summary, model.summary ?? '—'),
        const SizedBox(height: 12),
        if ((model.keyPoints ?? '').isNotEmpty)
          ..._buildKeyPoints(model.keyPoints!, context),
        if ((model.conclusion ?? '').isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 12),
            child: _buildRichLine(context.l10n.conclusion, model.conclusion!),
          ),
      ],
    );
  }

  List<Widget> _buildKeyPoints(String keyPoints, BuildContext context) {
    final points = keyPoints.split('\n').where((e) => e.trim().isNotEmpty);
    return [
      Text(
        context.l10n.keyPoint,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 15,
        ),
      ),
      const SizedBox(height: 8),
      ...points.map(
        (e) => Padding(
          padding: const EdgeInsets.only(bottom: 4),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('• '),
              Expanded(child: Text(e.trim())),
            ],
          ),
        ),
      ),
    ];
  }
}
