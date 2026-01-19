import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../config/di/di.dart';
import '../../../config/navigation/app_router.dart';
import '../../../data/local/shared_preferences_manager.dart';
import '../../../data/model/file_model.dart';
import '../../../gen/assets.gen.dart';
import '../../../shared/constants/app_colors.dart';
import '../../../shared/extension/context_extension.dart';
import '../../../shared/extension/number_extension.dart';

Future<void> showAiBottomSheet({FileModel? pdfFile}) async {
  final ctx = getIt<AppRouter>().navigatorKey.currentContext;
  if (ctx == null) {
    return;
  }
  showModalBottomSheet(
    context: ctx,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) {
      return AIBottomSheet(pdfFile: pdfFile);
    },
  );
}

class AIBottomSheet extends StatelessWidget {
  const AIBottomSheet({super.key, this.pdfFile});

  //trường hợp từ view pdf
  final FileModel? pdfFile;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 27),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Visibility(
                  visible: false,
                  maintainSize: true,
                  maintainState: true,
                  maintainAnimation: true,
                  child: Assets.icons.icClose.svg(),
                ),
                Expanded(
                  child: Text(
                    context.l10n.aIAssistant,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: context.maybePop,
                  child: Assets.icons.icClose.svg(),
                ),
              ],
            ),
            const SizedBox(height: 16),
            12.vSpace,
            _buildSheetButton(
              context,
              Assets.icons.aiTranslate,
              context.l10n.aITranslate,
              () {
                context.maybePop();
                if (pdfFile != null) {
                  context.pushRoute(SelectPageRoute(pdfModel: pdfFile!));
                  return;
                }
                final showAI =
                    SharedPreferencesManager.instance.showAiTranslateGuide();
                if (showAI) {
                  SharedPreferencesManager.instance.setShowAITranslateGuide();
                  context.pushRoute(AIGuideRoute(isTranslate: true));
                } else {
                  context.pushRoute(
                    PdfFilePickerRoute(
                      isAI: true,
                    ),
                  );
                }
              },
            ),
            12.vSpace,
            _buildSheetButton(
              context,
              Assets.icons.aiSummary,
              context.l10n.aISummary,
              () {
                context.maybePop();
                if (pdfFile != null) {
                  context.pushRoute(
                    SelectPageRoute(
                      pdfModel: pdfFile!,
                      isAITranslate: false,
                    ),
                  );
                  return;
                }
                final showAI =
                    SharedPreferencesManager.instance.showAiSummaryGuide();
                if (showAI) {
                  SharedPreferencesManager.instance.setShowAISummaryGuide();
                  context.pushRoute(AIGuideRoute(isTranslate: false));
                } else {
                  context.pushRoute(
                    PdfFilePickerRoute(
                      isAI: true,
                      isAITranslate: false,
                    ),
                  );
                }
              },
            ),
            8.vSpace,
            TextButton(
              child: Text(
                context.l10n.giveFeedback,
                style: const TextStyle(
                  decoration: TextDecoration.underline,
                  decorationColor: AppColors.pr,
                  decorationThickness: 1.2,
                  color: AppColors.pr,
                  fontWeight: FontWeight.w500,
                ),
              ),
              onPressed: () {
                context.maybePop().then(
                      (value) => context.pushRoute(
                        const FeedbackRoute(),
                      ),
                    );
              },
            )
          ],
        ),
      ),
    );
  }

  Widget _buildSheetButton(
    BuildContext context,
    SvgGenImage icon,
    String label,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
            color: AppColors.colorD10.withValues(alpha: .03),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: AppColors.colorD10.withValues(alpha: .15),
            )),
        child: Row(
          children: [
            icon.svg(),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                label,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            4.hSpace,
            Icon(
              Icons.chevron_right,
              color: AppColors.colorD10.withValues(alpha: .5),
            ),
          ],
        ),
      ),
    );
  }
}
