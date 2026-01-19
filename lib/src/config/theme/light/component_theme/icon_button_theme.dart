part of '../light_theme.dart';

class MyIconButtonTheme extends IconButtonThemeData {
  @override
  ButtonStyle? get style => IconButton.styleFrom(
        foregroundColor: AppColors.pr,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        iconSize: 24,
      );
}
