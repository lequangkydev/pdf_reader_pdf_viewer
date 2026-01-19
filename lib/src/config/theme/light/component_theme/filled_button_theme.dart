part of '../light_theme.dart';

class MyFilledButtonTheme extends FilledButtonThemeData {
  @override
  ButtonStyle? get style => FilledButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: 14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      );
}
