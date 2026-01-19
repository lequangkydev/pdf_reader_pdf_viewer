import 'package:flutter/material.dart';

import '../../../gen/assets.gen.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    this.title,
    this.actionWidget,
    this.leadingWidget,
    this.color,
    this.showLeading = true,
    this.onBack,
    this.centerTitle = true,
    this.titleWidget,
  });

  final String? title;
  final Widget? titleWidget;
  final List<Widget>? actionWidget;
  final Widget? leadingWidget;
  final Color? color;
  final bool showLeading;
  final VoidCallback? onBack;
  final bool centerTitle;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: centerTitle,
      elevation: 0,
      shadowColor: color,
      backgroundColor: color,
      scrolledUnderElevation: 0,
      automaticallyImplyLeading: showLeading,
      title: titleWidget ??
          Text(
            title ?? '',
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: 18,
            ),
          ),
      actions: actionWidget,
      leading: showLeading
          ? GestureDetector(
              onTap: () {
                if (onBack != null) {
                  onBack?.call();
                } else {
                  Navigator.of(context).pop();
                }
              },
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: leadingWidget ??
                    Assets.icons.arrowBack.svg(width: 24, height: 24),
              ),
            )
          : const SizedBox.shrink(),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
