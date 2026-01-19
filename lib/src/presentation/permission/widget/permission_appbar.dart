part of '../permission_screen.dart';

class PermissionAppbar extends AppBar {
  PermissionAppbar(
    this.context, {
    super.key,
    this.onActionTapped,
  });

  final BuildContext context;
  final VoidCallback? onActionTapped;

  @override
  Widget? get title => Text(
        context.l10n.permission,
        style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            fontFamily: FontFamily.sFProDisplay),
      );

  @override
  bool? get centerTitle => true;

  @override
  double? get toolbarHeight => 100;

  @override
  Size get preferredSize => const Size.fromHeight(100);

  @override
  bool get automaticallyImplyLeading => false;
}
