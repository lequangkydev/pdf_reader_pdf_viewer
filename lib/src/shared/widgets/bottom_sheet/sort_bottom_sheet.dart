import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../module/tracking_screen/loggable_widget.dart';
import '../../../config/di/di.dart';
import '../../../config/navigation/app_router.dart';
import '../../../gen/assets.gen.dart';
import '../../../presentation/document/cubit/sort_cubit.dart';
import '../../constants/app_colors.dart';
import '../../extension/context_extension.dart';
import '../../extension/number_extension.dart';
import '../../utils/style_utils.dart';

class SortBottomSheet extends StatefulWidget {
  const SortBottomSheet({super.key});

  @override
  State<SortBottomSheet> createState() => _SortBottomSheetState();
}

class _SortBottomSheetState extends State<SortBottomSheet> {
  late SortType selectedSort;

  @override
  void initState() {
    super.initState();
    selectedSort = context.read<SortCubit>().state;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(context.l10n.sortBy,
              style: StyleUtils.style.s16.b75.semiBold),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: SortType.values.length,
                itemBuilder: (context, index) {
                  final type = SortType.values[index];
                  return CheckBoxSelectItem<SortType>(
                    sortType: type,
                    selectedValue: selectedSort,
                    onTap: () {
                      setState(() {
                        selectedSort = type;
                      });
                    },
                  );
                },
              ),
              10.verticalSpace,
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        getIt<AppRouter>().maybePop();
                      },
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        backgroundColor: const Color(0xFFF2F2F2), // xám nhạt
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                      child: Text(
                        context.l10n.cancel,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey, // chữ xám
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        context.read<SortCubit>().updateSort(selectedSort);
                        getIt<AppRouter>().maybePop();
                      },
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        backgroundColor: AppColors.pr,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                      child: Text(
                        context.l10n.ok,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.white, // chữ trắng
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              20.verticalSpace,
            ],
          ),
        ),
      ],
    );
  }
}

Future<void> showSortBottomSheet() async {
  final ctx = getIt<AppRouter>().navigatorKey.currentContext;
  if (ctx == null) {
    return;
  }
  showModalBottomSheet(
    context: ctx,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
    ),
    isScrollControlled: true,
    builder: (context) {
      return Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: const SortBottomSheet(),
      );
    },
  );
}

class CheckBoxSelectItem<T> extends StatelessLoggableWidget {
  const CheckBoxSelectItem({
    super.key,
    this.styleTextRight,
    this.isShowBorder = true,
    required this.sortType,
    this.selectedValue,
    this.onTap,
  });

  final TextStyle? styleTextRight;
  final bool isShowBorder;
  final SortType sortType;
  final T? selectedValue;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
            border: Border(
          bottom: BorderSide(
            color: isShowBorder
                ? Colors.white.withOpacity(0.1)
                : Colors.transparent,
          ),
        )),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            sortType.iconWidget.svg(),
            8.hSpace,
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  sortType.title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff404040),
                  ),
                ),
                Text(
                  '(${sortType.labelString})',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Color(0xffBFBFBF),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 8),
            const Spacer(),
            if (sortType == selectedValue)
              Assets.icons.circleFilled.svg(width: 24)
            else
              Assets.icons.circle.svg(width: 24)
          ],
        ),
      ),
    );
  }
}
