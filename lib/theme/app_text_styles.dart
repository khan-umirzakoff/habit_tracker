import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

/// Figmadan olingan text style'lar (SF Pro Display → Inter bilan almashtrilgan)
class AppTextStyles {
  AppTextStyles._();

  // style_DY0L01: SF Pro, w590, 17px, lineHeight 1.294 — Status bar time
  static TextStyle statusBarTime = GoogleFonts.inter(
    fontSize: 17,
    fontWeight: FontWeight.w600,
    height: 1.294,
    color: AppColors.textPrimary,
  );

  // style_YYS1UC: SF Pro Display, w500, 22px, lineHeight 1.193 — Date title "21 Dekabr"
  static TextStyle dateTitle = GoogleFonts.inter(
    fontSize: 22,
    fontWeight: FontWeight.w500,
    height: 1.193,
    color: AppColors.textPrimary,
  );

  // style_YJNKX6: SF Pro Display, w400, 15px, lineHeight 1.193 — "All Schelduled for Today"
  static TextStyle bodyRegular = GoogleFonts.inter(
    fontSize: 15,
    fontWeight: FontWeight.w400,
    height: 1.193,
    color: AppColors.textPrimary,
  );

  // style_YNOE7Y: SF Pro Display, w600, 15px, lineHeight 1.193 — "0 Habits"
  static TextStyle bodySemiBold = GoogleFonts.inter(
    fontSize: 15,
    fontWeight: FontWeight.w600,
    height: 1.193,
    color: AppColors.textPrimary,
  );

  // style_3I33CO: SF Pro Display, w600, 15px, lineHeight 1.193, letterSpacing -4% — "~%"
  static TextStyle percentText = GoogleFonts.inter(
    fontSize: 15,
    fontWeight: FontWeight.w600,
    height: 1.193,
    letterSpacing: -0.6, // -4% of 15px
    color: AppColors.textPrimary,
  );

  // style_BOE4LX: SF Pro Display, w400, 12px, lineHeight 1.417 — motivational text
  static TextStyle caption = GoogleFonts.inter(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    height: 1.417,
    color: AppColors.textPrimary,
  );

  // style_FLT4KI: SF Pro Display, w500, 15px, lineHeight 1.193 — "Home" nav label
  static TextStyle navLabel = GoogleFonts.inter(
    fontSize: 15,
    fontWeight: FontWeight.w500,
    height: 1.193,
    color: AppColors.textPrimary,
  );
}
