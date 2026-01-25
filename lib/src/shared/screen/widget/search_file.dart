import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../config/navigation/app_router.dart';
import '../../../gen/assets.gen.dart';
import '../../constants/app_colors.dart';
import '../../cubit/shell_document_tab_cubit.dart';
import '../../enum/app_enum.dart';
import '../../widgets/bottom_sheet/sort_bottom_sheet.dart';

class SearchFile extends StatelessWidget {
  const SearchFile({super.key, this.isMoreScreen = false});

  final bool isMoreScreen;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShellDocumentTabCubit, TabBarType>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Expanded(
                child: RichText(
                  text: TextSpan(
                    text: 'PDF ',
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                    ),
                    children: [
                      TextSpan(
                        text: 'Reader',
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          color: state.valueColor,
                          fontSize: 24,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (!isMoreScreen)
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.white,
                    border: Border.all(
                      color: AppColors.adBorder,
                    ),
                  ),
                  child: Row(
                    spacing: 20,
                    children: [
                      GestureDetector(
                          onTap: () =>
                              context.pushRoute(SearchRoute(tabBarType: state)),
                          child: Assets.icons.search.svg()),
                      GestureDetector(
                        onTap: showSortBottomSheet,
                        child: Assets.icons.icExpandList.svg(),
                      ),
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
