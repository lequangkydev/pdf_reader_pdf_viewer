import 'package:flutter/material.dart';

import '../../gen/colors.gen.dart';
import '../../gen/fonts.gen.dart';
import '../constants/app_colors.dart';

mixin StyleUtils {
  static TextStyle get style => const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        fontFamily: FontFamily.sFProDisplay,
      );
}

extension TypographiesColor on TextStyle {
  TextStyle get white => copyWith(color: Colors.white);

  TextStyle get black => copyWith(color: Colors.black);

  TextStyle get b75 => copyWith(color: MyColors.p75);

  TextStyle get b50 => copyWith(color: MyColors.p50);

  TextStyle get b25 => copyWith(color: MyColors.p25);

  TextStyle get pr => copyWith(color: AppColors.pr);

  TextStyle get b65 => copyWith(color: AppColors.b65);

  TextStyle get green => copyWith(color: AppColors.excel);

  TextStyle get red => copyWith(color: AppColors.pdf);

  TextStyle get blue => copyWith(color: AppColors.doc);

  TextStyle get orange => copyWith(color: AppColors.pptx);

  TextStyle get purple => copyWith(color: AppColors.purple);

  TextStyle get teal => copyWith(color: AppColors.teal);
}

extension TypographiesWeight on TextStyle {
  TextStyle get bold => copyWith(fontWeight: FontWeight.bold);

  TextStyle get italic => copyWith(fontStyle: FontStyle.italic);

  TextStyle get semiBold => copyWith(fontWeight: FontWeight.w600);

  TextStyle get medium => copyWith(fontWeight: FontWeight.w500);

  TextStyle get regular => copyWith(fontWeight: FontWeight.w400);

  TextStyle get light => copyWith(fontWeight: FontWeight.w300);

  TextStyle get thin => copyWith(fontWeight: FontWeight.w100);
}

extension TypographiesSize on TextStyle {
  TextStyle get s10 => copyWith(fontSize: 10);

  TextStyle get s12 => copyWith(fontSize: 12);

  TextStyle get s14 => copyWith(fontSize: 14);

  TextStyle get s15 => copyWith(fontSize: 15);

  TextStyle get s16 => copyWith(fontSize: 16);

  TextStyle get s17 => copyWith(fontSize: 17);

  TextStyle get s18 => copyWith(fontSize: 18);

  TextStyle get s20 => copyWith(fontSize: 20);

  TextStyle get s21 => copyWith(fontSize: 21);

  TextStyle get s22 => copyWith(fontSize: 22);

  TextStyle get s23 => copyWith(fontSize: 23);

  TextStyle get s24 => copyWith(fontSize: 24);

  TextStyle get s25 => copyWith(fontSize: 25);

  TextStyle get s28 => copyWith(fontSize: 28);

  TextStyle get s36 => copyWith(fontSize: 36);

  TextStyle get s40 => copyWith(fontSize: 40);

  TextStyle get s72 => copyWith(fontSize: 72);
}

extension TypographiesLineHeight on TextStyle {
  TextStyle get h18 => copyWith(height: 18 / fontSize!);

  TextStyle get h21 => copyWith(height: 21 / fontSize!);

  TextStyle get h24 => copyWith(height: 24 / fontSize!);

  TextStyle get h30 => copyWith(height: 30 / fontSize!);

  TextStyle get h36 => copyWith(height: 36 / fontSize!);
}
