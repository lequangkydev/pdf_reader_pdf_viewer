import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../config/di/di.dart';
import '../../../config/navigation/app_router.dart';
import '../../constants/app_colors.dart';
import '../../extension/context_extension.dart';
import '../../utils/style_utils.dart';

class DialogWidget extends StatelessWidget {
  const DialogWidget({
    super.key,
    this.title,
    this.subTitle,
    this.confirmText,
    this.onDelete,
  });

  final String? title;
  final String? subTitle;
  final String? confirmText;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 0,
      // update color theo design
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(8.r),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 16.h,
          ),
          Text(
            title!,
            style: StyleUtils.style.b75.s16.regular,
          ),
          SizedBox(
            height: 16.h,
          ),
          SizedBox(
            height: 10.h,
          ),
          Container(
            decoration: BoxDecoration(
              color: AppColors.b15,
              border: const Border(top: BorderSide(color: AppColors.b15)),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(8.r),
                bottomRight: Radius.circular(8.r),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: context.maybePop,
                    child: Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(8.r),
                        ),
                        color: Colors.white,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        context.l10n.cancel,
                        style: StyleUtils.style.b50.s16.semiBold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 1),
                Expanded(
                  child: GestureDetector(
                    onTap: () async {
                      await context.maybePop();
                      onDelete?.call();
                    },
                    child: Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(8.r),
                        ),
                        color: Colors.white,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        confirmText ?? context.l10n.cancel,
                        style: StyleUtils.style.red.s16.semiBold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void show({
    required String title,
    required VoidCallback onDelete,
    String? confirmText,
  }) {
    final currentCtx = getIt<AppRouter>().navigatorKey.currentContext;
    if (currentCtx == null) {
      return;
    }
    showDialog(
      barrierColor: Colors.black.withValues(alpha: 0.25),
      context: currentCtx,
      builder: (context) {
        return DialogWidget(
          title: title,
          confirmText: confirmText,
          onDelete: onDelete,
        );
      },
    );
  }
}
