import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static const pr = Color(0xffE00000);
  static const adBorder = Color(0xffEDEDED);
  static const adBackground = Colors.white;
  static const bg = Color(0xFF181818);
  static const pptx = Color(0xffF2590C);
  static const doc = Color(0xff2979FF);
  static const excel = Color(0xff388E3C);
  static const pdf = Color(0xffE52120);
  static const color222 = Color(0xFF222222);
  static const divider = Color(0xFFF4F3F5);
  static const b7 = Color(0xFFEDEDED);
  static const b65 = Color(0xFF595959);
  static const b15 = Color(0xFFD9D9D9);
  static const b10 = Color(0xFFE6E6E6);
  static const colorE6E6E6 = Color(0xffE6E6E6);
  static const Color moradoPurple = Color(0xFF8C8C8C);
  static const purple = Color(0xFF7A6DFC);
  static const teal = Color(0xFF0EBFA1);
  static const redFF = Color(0xFFFF4A40);
  static const Color whiteSmoke = Color(0xFFF5F5F5);
  static const Color cerebralGrey = Color(0xFFCCCCCC);
  static const Color color80 = Color(0xff808080);
  static const Color color40 = Color(0xff404040);
  static const Color color5F7794 = Color(0xff5F7794);
  static const Color b25 = Color(0xFFBFBFBF);
  static const Color b75 = Color(0xFF404040);
  static const Color f2f2 = Color(0xFFF2F2F2);
  static const Color b2 = Color(0xFFFAFAFA);
  static const Color ff59 = Color(0xFFFF5959);
  static const Color color666 = Color(0xff666666);
  static const Color color26 = Color(0xff262626);
  static const Color colorEB0 = Color(0xFFEB0000);
  static const Color colorD10 = Color(0xFFD10000);
  static const Color colorA6 = Color(0xffA6A6A6);

  static Shader linearGradient = const LinearGradient(
    colors: [
      Color(0xff79E3BD),
      Color(0xff48c6d7),
    ],
  ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));

  static const dialogGradient = LinearGradient(
    colors: [
      Color(0xFFFFFFFF),
      Color(0xFFCDCCFF),
      // Colors.black
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const prGradient = LinearGradient(
    colors: [
      ff59,
      pr,
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
