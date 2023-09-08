import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xo_game/utils/color_manager.dart';

class ThemeManager {
  static TextStyle defaultTextStyle(
      {double fontSize = 20, Color color = ColorsManager.defaultTextColor}) {
    return GoogleFonts.bungee(fontSize: fontSize, color: color);
  }
}
