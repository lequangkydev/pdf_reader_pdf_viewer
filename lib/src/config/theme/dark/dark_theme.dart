import 'package:flutter/material.dart';

import '../../../gen/colors.gen.dart';
import '../../../shared/constants/app_colors.dart';

part 'component_theme/text_theme_dark.dart';

ThemeData darkThemeData = ThemeData(
  colorScheme: const ColorScheme.dark(
    primary: AppColors.pr,
  ),
  useMaterial3: true,
  textTheme: MyTextThemeDark(),
);
