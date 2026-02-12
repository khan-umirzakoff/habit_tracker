import 'package:flutter/material.dart';

class AppColors {
  // Main Background
  static const Color background = Color(0xFF333333); // fill_Y3MWJT

  // Surface Colors
  static const Color surfaceInput = Color(0xFF262626); // fill_ZT9M34
  static const Color darkerSurface = Color(0xFF222222); // fill_5NF45Z

  // Text Colors
  static const Color textPrimary = Color(0xFFFFFFFF); // fill_ED2KH0
  static const Color textSecondary = Color(0xFFDBD8D3); // fill_DXF8K5
  static const Color textPlaceholder = Color(0xFF6E6D6B); // fill_KJBTAZ
  
  // Accents
  static const Color accentGreen = Color(0xFF9BDA88); // fill_5WH1S4
  static const Color yellow = Color(0xFFFEBB64); // fill_QPH4IC
  static const Color red = Color(0xFFCA5555); // fill_LCOSH4
  static const Color blue = Color(0xFF88ADDA); // fill_7MYHWE
  static const Color lightGray = Color(0xFFD2D2D2); // fill_A4NQ8X
  static const Color purple = Color(0xFFB488DA); // fill_I5CR4I
  
  // Strokes
  static const Color strokeDark = Color(0xFF353535); // stroke_V6VA6B
  
  // Shadows (Simulated as colors for now, but used in box shadows)
  static const Color shadowDark = Color(0x73000000); // rgba(0,0,0,0.45) -> 0.45 * 255 = 114.75 -> 72 hex
  static const Color shadowLight = Color(0x40FFFFFF); // rgba(255,255,255,0.25) -> 0.25 * 255 = 63.75 -> 40 hex
  static const Color shadowLightStrong = Color(0x8CFFFFFF); // rgba(255,255,255,0.55) -> 0.55 * 255 = 140.25 -> 8C hex
}
