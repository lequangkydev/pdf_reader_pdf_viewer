import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as p;

import '../../../module/admob/utils/inter_ad_util.dart';
import '../../../module/admob/utils/utils.dart';
import '../../../module/admob/widget/ads/banner_ad.dart';
import '../../config/navigation/app_router.dart';
import '../../data/model/document_model.dart';
import '../../data/model/pdf_language_model.dart';
import '../../data/model/translate_model.dart';
import '../../services/ai_service.dart';
import '../../shared/constants/app_colors.dart';
import '../../shared/extension/context_extension.dart';
import '../../shared/extension/number_extension.dart';
import '../../shared/widgets/app_bar/custom_appbar.dart';
import '../../shared/widgets/dialog/error_dialog.dart';
import '../../shared/widgets/dialog/loading_dialog.dart';

@RoutePage()
class AIDetailScreen extends StatefulWidget {
  const AIDetailScreen({
    super.key,
    required this.pdfFile,
    required this.previewPdf,
    this.isAITranslate = true,
    required this.countPages,
  });

  final File pdfFile;
  final File previewPdf;
  final bool isAITranslate;
  final int countPages;

  @override
  State<AIDetailScreen> createState() => _AIDetailScreenState();
}

class _AIDetailScreenState extends State<AIDetailScreen> {
  late String fileName;

  List<PdfLanguage> languages = []; // 🔹 Danh sách ngôn ngữ trả về từ API
  PdfLanguage? selectedLanguage; // 🔹 Ngôn ngữ đang chọn
  SummaryType selectedSummary = SummaryType.informative;

  @override
  void initState() {
    super.initState();
    fileName = p.basename(widget.pdfFile.path);
    if (widget.isAITranslate) {
      _fetchLanguages();
    }
  }

  Future<void> _fetchLanguages() async {
    try {
      final list = AIService().listLanguages;

      if (list.isNotEmpty && mounted) {
        setState(() {
          languages = list;
          selectedLanguage = list.firstWhere(
            (e) => e.code.toLowerCase() == 'english',
            orElse: () => list.first,
          );
        });
      } else {
        debugPrint('⚠️ Không có dữ liệu ngôn ngữ trả về.');
      }
    } catch (e, s) {
      debugPrint('❌ Lỗi khi load ngôn ngữ: $e');
      debugPrint('$s');
    }
  }

  void _showBottomSheet() {
    final isTranslate = widget.isAITranslate;
    final items = isTranslate ? languages : SummaryType.values;
    final title =
        isTranslate ? context.l10n.language : context.l10n.summaryStyle;

    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        final screenHeight = MediaQuery.of(context).size.height;
        return StatefulBuilder(
          builder: (context, setModalState) {
            return SafeArea(
              child: SizedBox(
                height: screenHeight * (isTranslate ? 0.8 : 0.6),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppColors.color222,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Flexible(
                        child: ListView.separated(
                          shrinkWrap: true,
                          padding: const EdgeInsets.symmetric(
                              vertical: 12, horizontal: 16),
                          itemCount: items.length,
                          separatorBuilder: (_, __) => const Divider(
                            height: 1,
                            color: Color(0xffF5F5F5),
                          ),
                          itemBuilder: (_, index) {
                            final item = items[index];
                            final isSelected = isTranslate
                                ? item == selectedLanguage
                                : item == selectedSummary;

                            return GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: () {
                                setModalState(() {});
                                setState(() {
                                  if (isTranslate) {
                                    selectedLanguage = item as PdfLanguage;
                                  } else {
                                    selectedSummary = item as SummaryType;
                                  }
                                });
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 14.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        isTranslate
                                            ? (item as PdfLanguage).name
                                            : (item as SummaryType).label,
                                      ),
                                    ),
                                    if (isSelected)
                                      const Icon(Icons.check,
                                          color: AppColors.pr, size: 24),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final isTranslate = widget.isAITranslate;

    return Scaffold(
      appBar: CustomAppBar(
        title: isTranslate ? context.l10n.aITranslate : context.l10n.aISummary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // ======= PDF Preview Section =======
            Container(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              decoration: BoxDecoration(
                color: const Color(0xffF9F9F9),
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: const Color(0xffE5E5E5)),
              ),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: const Color(0xffE2E2E2)),
                    ),
                    child: Image.file(
                      widget.previewPdf,
                      fit: BoxFit.cover,
                      height: 150,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    fileName,
                    style: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      color: AppColors.color222,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${widget.pdfFile.lengthSync().convertByte} - ${widget.countPages} pages',
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // ======= Selection Field =======
            Text(
              isTranslate
                  ? context.l10n.translateTo
                  : context.l10n.summaryStyle,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 8),

            InkWell(
              onTap: _showBottomSheet,
              borderRadius: BorderRadius.circular(10),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: const Color(0xffE0E0E0)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          isTranslate
                              ? selectedLanguage?.name ?? 'English'
                              : selectedSummary.label,
                          style: TextStyle(
                            color: Color(0xff1A1A1A),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    const Icon(Icons.keyboard_arrow_down_rounded,
                        color: Colors.grey),
                  ],
                ),
              ),
            ),

            const Spacer(),

            // ======= Action Button =======
            FilledButton(
              onPressed: () async {
                if (isTranslate) {
                  await InterAdUtil.instance
                      .showInterAd(adConfig: adUnitsConfig.interTranslate);
                  LoadingOverlay.show(isTranslate: true);
                  try {
                    final result = await AIService().translatePdf(
                      file: widget.pdfFile,
                      language: selectedLanguage?.code ?? 'english',
                    );
                    LoadingOverlay.hide();
                    final data = result['data']?['data'];
                    if (data == null) {
                      throw Exception('Không tìm thấy dữ liệu bản dịch');
                    }
                    final resultTranslate = TranslateModel.fromJson(
                      Map<String, dynamic>.from(data as Map),
                    );

                    context.pushRoute(
                        AIResultRoute(translateModel: resultTranslate));
                  } catch (e) {
                    LoadingOverlay.hide();
                    showErrorDialog(e.toString(), '');
                  }
                } else {
                  await InterAdUtil.instance
                      .showInterAd(adConfig: adUnitsConfig.interSummary);
                  LoadingOverlay.show(isSummary: true);
                  try {
                    final result = await AIService().summarizePdf(
                      file: widget.pdfFile,
                      summaryType: selectedSummary,
                    );
                    LoadingOverlay.hide();
                    final summary = DocumentModel.fromJson(
                      Map<String, dynamic>.from(result['data']['data'] as Map),
                    );
                    context.pushRoute(AIResultRoute(summaryModel: summary));
                  } catch (e) {
                    LoadingOverlay.hide();
                    showErrorDialog(e.toString(), '');
                  }
                }
              },
              child: Text(
                isTranslate
                    ? context.l10n.startTranslate
                    : context.l10n.startSummary,
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBanner(adConfig: adUnitsConfig.bannerAll),
    );
  }
}
