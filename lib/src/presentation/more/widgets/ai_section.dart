import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../config/navigation/app_router.dart';
import '../../../data/local/shared_preferences_manager.dart';
import '../../../gen/assets.gen.dart';
import '../../../shared/constants/app_colors.dart';
import '../../../shared/extension/context_extension.dart';

class AiAssistantSection extends StatelessWidget {
  const AiAssistantSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.l10n.aIAssistant,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Color(0xff404040),
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _AiOptionButton(
                icon: Assets.icons.aiTranslate,
                label: context.l10n.aITranslate,
                onTap: () {
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
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _AiOptionButton(
                icon: Assets.icons.aiSummary,
                label: context.l10n.aISummary,
                onTap: () {
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
            ),
          ],
        ),
      ],
    );
  }
}

class _AiOptionButton extends StatelessWidget {
  const _AiOptionButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final SvgGenImage icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        decoration: BoxDecoration(
          color: AppColors.pr.withValues(alpha: .03),
          border: Border.all(color: AppColors.f2f2),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon.svg(width: 24),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: AppColors.color26,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
