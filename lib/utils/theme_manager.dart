// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xo_game/utils/color_manager.dart';

class ThemeManager {
  static TextStyle defaultTextStyle(
      {double fontSize = 20,
      Color color = ColorsManager.defaultTextColor,
      bool withFontFamily = true}) {
    if (withFontFamily)
      return GoogleFonts.bungee(fontSize: fontSize, color: color);
    else
      return TextStyle(fontSize: fontSize, color: color);
  }
}
