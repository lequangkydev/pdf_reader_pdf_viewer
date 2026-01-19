part of '../light_theme.dart';

class MyOutlinedButtonTheme extends OutlinedButtonThemeData {
  @override
  ButtonStyle? get style => OutlinedButton.styleFrom(
        side: const BorderSide(
          color: AppColors.pr,
        ),
        padding: EdgeInsets.symmetric(vertical: 14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w700,
        ),
        foregroundColor: AppColors.pr,
      );
}
