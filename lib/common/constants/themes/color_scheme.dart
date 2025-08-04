import 'package:flutter/material.dart';
import 'package:simple_chat_demo/common/constants/color_swatch.dart';

class AppColorScheme extends ColorScheme {
  AppColorScheme.light() : super.light(primary: primarySwatch);

  static BlackSwatch blackSwatch = BlackSwatch(0xFF000000);
  static WhiteSwatch whiteSwatch = WhiteSwatch(0xFF131313);
  static PrimarySwatch primarySwatch = PrimarySwatch(0xFF11E799);
}
