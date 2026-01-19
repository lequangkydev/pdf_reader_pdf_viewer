import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../module/log_event_app/language_event.dart';
import '../../../../module/tracking_screen/screen_logger.dart';
import '../../../config/di/di.dart';
import '../../../gen/assets.gen.dart';
import '../../../shared/constants/app_colors.dart';
import '../../../shared/enum/language.dart';
import '../../../shared/extension/context_extension.dart';
import '../../../shared/extension/number_extension.dart';
import '../cubit/language_cubit.dart';

class LanguageItem extends StatelessWidget {
  const LanguageItem({
    super.key,
    required this.language,
    this.selectedLanguage,
    this.isSystem = false,
  });

  final Languages language;
  final Languages? selectedLanguage;
  final bool isSystem;

  @override
  Widget build(BuildContext context) {
    final isSelected = language == selectedLanguage &&
        isSystem == context.read<LanguageCubit>().state.isSystemLanguage;

    return GestureDetector(
      onTap: () {
        AnalyticLogger.instance.logEventWithScreen(
          event: LanguageEvent.Select_ITEM_Language,
        );
        getIt<LanguageCubit>().update(LanguageState(
          language: language,
          isSystemLanguage: isSystem,
        ));
      },
      behavior: HitTestBehavior.opaque,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: isSelected ? AppColors.pr : const Color(0xffF2F2F2),
              ),
              borderRadius: BorderRadius.circular(12),
              color: Colors.white,
            ),
            padding: const EdgeInsets.fromLTRB(16, 14, 12, 14),
            child: Row(
              children: [
                if (isSystem)
                  Assets.images.languages.system.image(width: 22)
                else
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: const Color(0xffA6D0FF),
                        // strokeAlign: 2,
                      ),
                    ),
                    child: CircleAvatar(
                      radius: 10,
                      backgroundColor: Colors.transparent,
                      backgroundImage: Image.asset(
                        language.flagPath,
                        fit: BoxFit.fill,
                      ).image,
                    ),
                  ),
                12.hSpace,
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: RichText(
                          text: TextSpan(
                            text: isSystem
                                ? context.l10n.systemLanguage
                                : language.name,
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xff1B1B1B),
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: isSystem || language == Languages.english
                                    ? ''
                                    : ' (${language.note}) ',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 13.sp,
                                  color: const Color(0xff1B1B1B),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      6.hSpace,
                      if (isSelected)
                        Assets.icons.circleFilled.svg(width: 20)
                      else
                        Assets.icons.circle.svg(width: 20)
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
