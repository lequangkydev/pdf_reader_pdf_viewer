import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../config/navigation/app_router.dart';
import '../../../gen/assets.gen.dart';
import '../../constants/app_colors.dart';
import '../../cubit/shell_document_tab_cubit.dart';
import '../../enum/app_enum.dart';
import '../../widgets/bottom_sheet/sort_bottom_sheet.dart';

class SearchFile extends StatefulWidget {
  const SearchFile({super.key, this.padding});

  final EdgeInsets? padding;

  @override
  State<SearchFile> createState() => _SearchFileState();
}

class _SearchFileState extends State<SearchFile> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShellDocumentTabCubit, TabBarType>(
      builder: (context, state) {
        return Padding(
          padding: widget.padding ??
              const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
          child: Row(
            children: [
              Expanded(
                child: RichText(
                  text: TextSpan(
                    text: 'PDF ',
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                    children: [
                      TextSpan(
                        text: 'Reader',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: state.valueColor,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(40),
                  border: Border.all(color: AppColors.f2f2),
                ),
                child: Row(
                  children: [
                    GestureDetector(
                        onTap: () =>
                            context.pushRoute(SearchRoute(tabBarType: state)),
                        child: Assets.icons.search.svg()),
                    20.horizontalSpace,
                    GestureDetector(
                      onTap: showSortBottomSheet,
                      child: Assets.icons.icExpandList.svg(),
                    ),
                    20.horizontalSpace,
                    GestureDetector(
                      onTap: () {
                        context.pushRoute(
                          DocumentSelectRoute(
                            tabBarType:
                                context.read<ShellDocumentTabCubit>().state,
                          ),
                        );
                      },
                      child: Assets.icons.icAllList.svg(),
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
