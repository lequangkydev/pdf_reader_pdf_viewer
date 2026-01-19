import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/model/file_model.dart';
import '../../../gen/gens.dart';
import '../../../shared/constants/app_colors.dart';
import '../../../shared/extension/context_extension.dart';
import '../../../shared/extension/number_extension.dart';
import '../../../shared/screen/cubit/bottom_tab_cubit.dart';
import '../../../shared/widgets/bottom_sheet/ai_bottom_sheet.dart';
import '../../permission/cubit/storage_status_cubit.dart';

class AIAssistant extends StatelessWidget {
  const AIAssistant({super.key, this.fileModel});

  final FileModel? fileModel;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StoragePermissionCubit, bool>(
      builder: (context, state) {
        if (!state) {
          return const SizedBox.shrink();
        }
        return BlocBuilder<BottomTabCubit, BottomTab>(
          builder: (context, state) {
            if (state == BottomTab.more) {
              return const SizedBox.shrink();
            }
            return GestureDetector(
              onTap: () => showAiBottomSheet(pdfFile: fileModel),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                margin: const EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                    color: AppColors.pr,
                    borderRadius: BorderRadius.circular(50),
                    gradient: AppColors.prGradient,
                    border: Border.all(
                      color: Colors.white.withValues(alpha: .5),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.pr.withValues(alpha: .15),
                        blurRadius: 25,
                      )
                    ]),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Assets.icons.aiPdf.svg(),
                    8.hSpace,
                    Text(
                      context.l10n.aIAssistant,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
