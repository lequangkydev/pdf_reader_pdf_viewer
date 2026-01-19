import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

import '../../../module/admob/utils/utils.dart';
import '../../../module/admob/widget/ads/banner_ad.dart';
import '../../config/navigation/app_router.dart';
import '../../gen/assets.gen.dart';
import '../../shared/extension/context_extension.dart';
import '../../shared/extension/number_extension.dart';
import '../../shared/widgets/app_bar/custom_appbar.dart';

@RoutePage()
class AIGuideScreen extends StatelessWidget {
  const AIGuideScreen({super.key, required this.isTranslate});

  final bool isTranslate;

  @override
  Widget build(BuildContext context) {
    final image = isTranslate
        ? Assets.images.aiTranslate.image(fit: BoxFit.contain)
        : Assets.images.aiSummary.image(fit: BoxFit.contain);

    final descriptionKey = isTranslate
        ? context.l10n.ai_translate_description
        : context.l10n.ai_summary_description;

    final features = isTranslate
        ? [
            context.l10n.translate1,
            context.l10n.translate2,
            context.l10n.translate3,
            context.l10n.translate4,
          ]
        : [
            context.l10n.summary1,
            context.l10n.summary2,
            context.l10n.summary3,
            context.l10n.summary4,
          ];

    final buttonText = isTranslate
        ? context.l10n.startAITranslate
        : context.l10n.startAISummary;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: isTranslate ? context.l10n.aITranslate : context.l10n.aISummary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            image,
            20.vSpace,
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  HtmlWidget(
                    descriptionKey,
                    textStyle: const TextStyle(
                      fontSize: 14,
                      height: 1.3,
                      color: Color(0xff222222),
                    ),
                  ),
                  8.vSpace,
                  ...features.map(
                    (f) => HtmlWidget(
                      '• $f',
                      textStyle: const TextStyle(
                        fontSize: 14,
                        height: 1.3,
                        color: Color(0xff222222),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: FilledButton(
              onPressed: () {
                context.pushRoute(
                  PdfFilePickerRoute(
                    isAI: true,
                    isAITranslate: isTranslate,
                  ),
                );
              },
              child: Text(buttonText),
            ),
          ),
          40.vSpace,
          CustomBanner(adConfig: adUnitsConfig.bannerAll),
        ],
      ),
    );
  }
}
