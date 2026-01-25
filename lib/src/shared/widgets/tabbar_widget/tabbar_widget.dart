import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../presentation/document/cubit/tab_cubit.dart';
import '../../../presentation/document/document_screen.dart';
import '../../constants/app_colors.dart';
import '../../cubit/shell_document_tab_cubit.dart';
import '../../enum/app_enum.dart';
import '../../extension/number_extension.dart';
import '../../screen/widget/search_file.dart';
import '../../utils/style_utils.dart';

class CommonTabBar extends StatefulWidget {
  const CommonTabBar({
    super.key,
    required this.tabController,
    required this.tabs,
    required this.tabViews,
    this.decoration,
    this.padding,
    this.initialIndex = 0,
    this.documentType,
  });

  final TabController tabController;
  final List<CustomTab> tabs;
  final List<Widget> tabViews;
  final Decoration? decoration;
  final EdgeInsetsGeometry? padding;
  final int initialIndex;
  final DocumentType? documentType;

  @override
  State<CommonTabBar> createState() => _CommonTabBarState();
}

class _CommonTabBarState extends State<CommonTabBar> {
  final ValueNotifier<int> selectedTabIndexNotifier = ValueNotifier<int>(0);
  final PageController pageController = PageController();

  @override
  void initState() {
    super.initState();
    selectedTabIndexNotifier.value = widget.initialIndex;
    widget.tabController.addListener(_onTabChange);
    pageController.addListener(_onPageChange);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      pageController.jumpToPage(widget.initialIndex);
    });
  }

  void _onTabChange() {
    if (!widget.tabController.indexIsChanging) {
      selectedTabIndexNotifier.value = widget.tabController.index;
      pageController.jumpToPage(widget.tabController.index);
    }
  }

  void _onPageChange() {
    final pageIndex = pageController.page?.round();

    if (pageIndex != null && pageIndex != selectedTabIndexNotifier.value) {
      selectedTabIndexNotifier.value = pageIndex;
      widget.tabController.animateTo(pageIndex);
    }
  }

  @override
  void dispose() {
    widget.tabController.removeListener(_onTabChange);
    pageController.removeListener(_onPageChange);
    selectedTabIndexNotifier.dispose();
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        BlocBuilder<ShellDocumentTabCubit, TabBarType>(
          builder: (context, state) {
            return SizedBox(
              height: 130,
              child: Stack(
                children: [
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    transitionBuilder: (child, animation) => FadeTransition(
                      opacity: animation,
                      child: child,
                    ),
                    child: Container(
                      key: ValueKey(state),
                      height: 140,
                      decoration: BoxDecoration(
                        gradient: state.backgroundGradient,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: SafeArea(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Expanded(child: SearchFile()),
                          ValueListenableBuilder<int>(
                            valueListenable: selectedTabIndexNotifier,
                            builder: (context, selectedIndex, _) {
                              final selectedTab =
                                  TabBarType.values[selectedIndex];
                              return Container(
                                padding: widget.padding,
                                decoration: widget.decoration,
                                child: TabBar(
                                  onTap: (index) {
                                    selectedTabIndexNotifier.value = index;
                                    pageController.jumpToPage(index);
                                  },
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 5),
                                  overlayColor:
                                      WidgetStateProperty.resolveWith<Color?>(
                                    (Set<WidgetState> states) {
                                      return states
                                              .contains(WidgetState.focused)
                                          ? null
                                          : Colors.transparent;
                                    },
                                  ),
                                  controller: widget.tabController,
                                  dividerColor: Colors.transparent,
                                  labelStyle: selectedTab.valueStyle,
                                  unselectedLabelStyle: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.colorA6,
                                    fontStyle: FontStyle.normal,
                                  ),
                                  labelPadding: EdgeInsets.zero,
                                  indicatorColor: selectedTab.valueColor,
                                  tabs: widget.tabs.asMap().entries.map(
                                    (entry) {
                                      final isSelected =
                                          entry.key == selectedIndex;

                                      return Tab(
                                        height: 36,
                                        child: Container(
                                          alignment: Alignment.center,
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 12),
                                          decoration: BoxDecoration(
                                            gradient: isSelected
                                                ? entry.value.tabBarType
                                                    .gradientTab
                                                : null,
                                          ),
                                          child: Text(
                                            entry.value.tabBarType.valueString,
                                            style: isSelected
                                                ? selectedTab.valueStyle
                                                : const TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w400,
                                                    color: AppColors.color666,
                                                  ),
                                          ),
                                        ),
                                      );
                                    },
                                  ).toList(),
                                  indicatorSize: TabBarIndicatorSize.tab,
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        6.vSpace,
        Expanded(
          child: MediaQuery.removePadding(
            context: context,
            removeTop: true,
            child: PageView(
              controller: pageController,
              children: widget.tabViews,
              onPageChanged: (index) {
                if (widget.documentType == DocumentType.document) {
                  context.read<TabCubit>().update(TabBarType.values[index]);
                }
                widget.tabController.animateTo(index);
                context
                    .read<ShellDocumentTabCubit>()
                    .update(TabBarType.values[index]);
              },
            ),
          ),
        ),
      ],
    );
  }
}

class CustomTab extends StatelessWidget {
  const CustomTab({
    super.key,
    required this.tabBarType,
    this.height = 44,
    this.isSelect = false,
  });

  final TabBarType tabBarType;
  final double height;
  final bool isSelect;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: height,
      child: _buildTextIcon(),
    );
  }

  Widget _buildTextIcon() {
    return Container(
      decoration: UnderlineTabIndicator(
        borderSide: BorderSide(
          width: 2.0,
          color: isSelect ? tabBarType.valueColor : Colors.transparent,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Text(
          tabBarType.valueString,
          maxLines: 1,
          style: isSelect
              ? tabBarType.valueStyle
              : StyleUtils.style.s14.semiBold.copyWith(
                  color: const Color(0xff091D40),
                ),
        ),
      ),
    );
  }
}
