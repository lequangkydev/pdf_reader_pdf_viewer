import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../shared/constants/app_colors.dart';
import '../../../shared/extension/context_extension.dart';

class GoToPagePopup extends StatefulWidget {
  const GoToPagePopup({super.key, required this.pageCount});

  final int pageCount;

  static Future<int?> show({
    required BuildContext context,
    required int pageCount,
  }) {
    return showDialog(
      context: context,
      builder: (context) => GoToPagePopup(
        pageCount: pageCount,
      ),
    );
  }

  @override
  State<GoToPagePopup> createState() => _GoToPagePopupState();
}

class _GoToPagePopupState extends State<GoToPagePopup> {
  final controller = TextEditingController();

  String? errorText;

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.r),
        borderSide: const BorderSide(
          color: AppColors.colorE6E6E6,
        ));
    return Center(
      child: Container(
        width: 328.r,
        padding: EdgeInsets.all(16.r),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              context.l10n.goToPage,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            20.verticalSpace,
            Text(
              context.l10n.pageNumber,
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
                color: const Color(0xff666666),
              ),
            ),
            4.verticalSpace,
            TextField(
              controller: controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 19,
                  horizontal: 16,
                ).r,
                errorBorder: border.copyWith(
                  borderSide: const BorderSide(color: AppColors.pdf),
                ),
                focusedErrorBorder: border.copyWith(
                  borderSide: const BorderSide(color: AppColors.pdf),
                ),
                errorStyle: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.pdf,
                ),
                border: border,
                enabledBorder: border,
                focusedBorder: border,
                hintText: context.l10n.enterPageNumber(1, widget.pageCount),
                hintStyle: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xffbfbfbf),
                ),
                errorText: errorText,
              ),
            ),
            20.verticalSpace,
            Row(
              children: [
                Expanded(
                  child: FilledButton(
                    style: FilledButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 12.r),
                      backgroundColor: AppColors.b7,
                      foregroundColor: AppColors.color80,
                    ),
                    onPressed: context.maybePop,
                    child: Text(
                      context.l10n.cancel,
                    ),
                  ),
                ),
                16.horizontalSpace,
                Expanded(
                  child: FilledButton(
                    style: FilledButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 12.r),
                    ),
                    onPressed: () {
                      final pageNumber = int.tryParse(controller.text);
                      if (pageNumber == null ||
                          pageNumber < 1 ||
                          pageNumber > widget.pageCount) {
                        setState(() {
                          errorText = context.l10n.invalid;
                        });
                        return;
                      }
                      context.maybePop(pageNumber);
                    },
                    child: Text(
                      context.l10n.go,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
