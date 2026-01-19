import 'package:flutter/material.dart';

import '../../../gen/colors.gen.dart';
import '../../../gen/fonts.gen.dart';
import '../../../shared/constants/app_colors.dart';

part 'component_theme/dialog_theme.dart';
part 'component_theme/filled_button_theme.dart';
part 'component_theme/icon_button_theme.dart';
part 'component_theme/outlined_button_theme.dart';
part 'component_theme/text_button_theme.dart';
part 'component_theme/text_theme.dart';

ThemeData lightThemeData = ThemeData(
  colorScheme: const ColorScheme.light(
    primary: AppColors.pr,
  ),
  useMaterial3: true,
  textTheme: MyTextTheme(),
  dialogTheme: MyDialogTheme(),
  filledButtonTheme: MyFilledButtonTheme(),
  iconButtonTheme: MyIconButtonTheme(),
  outlinedButtonTheme: MyOutlinedButtonTheme(),
  textButtonTheme: MyTextButtonTheme(),
  sliderTheme: SliderThemeData(
    trackHeight: 5,
    activeTrackColor: AppColors.pr,
    inactiveTrackColor: Colors.grey.shade300,
    thumbColor: Colors.white,
    overlayColor: Colors.black12,
    thumbShape: const RoundSliderThumbShape(),
    tickMarkShape: const RoundSliderTickMarkShape(tickMarkRadius: 5),
    activeTickMarkColor: AppColors.pr,
    inactiveTickMarkColor: Colors.grey.shade400,
    valueIndicatorShape: const PaddleSliderValueIndicatorShape(),
    valueIndicatorColor: AppColors.pr,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.pr,
      minimumSize: const Size(47, 47),
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      textStyle: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        fontFamily: FontFamily.sFProDisplay,
      ),
    ),
  ),
);
