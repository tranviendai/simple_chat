import 'package:flutter/material.dart';

class BlackSwatch extends ColorSwatch<int> {
  BlackSwatch(int primary)
    : super(primary, {
        500: const Color(0xFF2B2B2B),
        700: const Color(0xFF141414),
        800: const Color(0xFF6A737D),
        900: const Color(0xFF222222),
        1000: const Color(0xFF131313),
      });
}

class WhiteSwatch extends ColorSwatch<int> {
  WhiteSwatch(int primary)
    : super(primary, {
        50: const Color.fromRGBO(255, 255, 255, 0.05),
        100: const Color(0x33FFFFFF),
        1000: const Color(0xFFFFFFFF),
      });
}

class PrimarySwatch extends ColorSwatch<int> {
  PrimarySwatch(int primary) : super(primary, {1000: const Color(0xFF11E799)});
}
