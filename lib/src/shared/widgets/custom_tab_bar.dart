import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/app_colors.dart';

class CustomTabBar extends StatelessWidget {
  const CustomTabBar({
    super.key,
    required this.controller,
    required this.tabs,
    this.onTap,
    this.isScrollable = true,
  });

  final TabController controller;
  final List<Widget> tabs;
  final void Function(int index)? onTap;
  final bool isScrollable;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0x0f000000),
        borderRadius: BorderRadius.circular(9.r),
      ),
      padding: EdgeInsets.all(2.r),
      child: _TabBar(
        controller: controller,
        tabs: tabs,
        onTap: onTap,
        isScrollable: isScrollable,
      ),
    );
  }
}

class _TabBar extends TabBar {
  const _TabBar({
    required super.tabs,
    required super.controller,
    super.isScrollable = true,
    super.onTap,
  });

  @override
  TabBarIndicatorSize? get indicatorSize => TabBarIndicatorSize.tab;

  @override
  Decoration? get indicator => BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(7.r),
        boxShadow: const [
          BoxShadow(
            color: Color(0x1F000000),
            blurRadius: 3,
            spreadRadius: 1,
            offset: Offset(0, 2),
          ),
        ],
      );

  @override
  EdgeInsetsGeometry? get labelPadding =>
      EdgeInsets.symmetric(horizontal: 12.w, vertical: 3.h);

  @override
  Color? get labelColor => Colors.black;

  @override
  Color? get unselectedLabelColor => AppColors.moradoPurple;

  @override
  Color? get dividerColor => Colors.transparent;
}
