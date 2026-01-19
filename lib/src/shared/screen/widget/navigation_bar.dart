part of '../shell_screen.dart';

class MainNavigationBar extends StatefulWidget {
  const MainNavigationBar({
    super.key,
    required this.selectedTab,
    required this.onTabChange,
  });

  final BottomTab selectedTab;
  final void Function(int index) onTabChange;

  @override
  State<MainNavigationBar> createState() => _MainNavigationBarState();
}

class _MainNavigationBarState extends State<MainNavigationBar>
    with PermissionMixin {
  bool select = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 78.h,
            decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(
                top: BorderSide(
                  color: AppColors.f2f2,
                ),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: buildItem(
                    icon: widget.selectedTab == BottomTab.document
                        ? Assets.icons.tabbar.documentFilled
                        : Assets.icons.tabbar.document,
                    label: context.l10n.document,
                    isActive: widget.selectedTab == BottomTab.document,
                    onTap: () => widget.onTabChange(0),
                  ),
                ),
                Expanded(
                  child: buildItem(
                    icon: widget.selectedTab == BottomTab.recent
                        ? Assets.icons.tabbar.clockFilled
                        : Assets.icons.tabbar.clock,
                    label: context.l10n.recent,
                    isActive: widget.selectedTab == BottomTab.recent,
                    onTap: () => widget.onTabChange(1),
                  ),
                ),
                Expanded(
                  child: buildItem(
                    icon: widget.selectedTab == BottomTab.bookmark
                        ? Assets.icons.tabbar.bookmarkFilled
                        : Assets.icons.tabbar.bookmark,
                    label: context.l10n.bookmark,
                    isActive: widget.selectedTab == BottomTab.bookmark,
                    onTap: () => widget.onTabChange(2),
                  ),
                ),
                Expanded(
                  child: buildItem(
                    icon: widget.selectedTab == BottomTab.more
                        ? Assets.icons.tabbar.categoryFilled
                        : Assets.icons.tabbar.category,
                    label: context.l10n.more,
                    isActive: widget.selectedTab == BottomTab.more,
                    onTap: () => widget.onTabChange(3),
                  ),
                ),
              ],
            ),
          ),
          CachedBannerAd(cachedAdUtil: BannerAllUtil.instance)
        ],
      ),
    );
  }

  Widget buildItem({
    required SvgGenImage icon,
    required String label,
    bool isActive = false,
    void Function()? onTap,
  }) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        onTap!();
        setState(() {
          select = false;
        });
      },
      child: Column(
        children: [
          16.verticalSpace,
          icon.svg(
            height: 24.h,
          ),
          4.verticalSpace,
          FittedBox(
            child: Center(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: !isActive || select ? null : FontWeight.w600,
                  color: !isActive || select ? Color(0xffBFBFBF) : AppColors.pr,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
