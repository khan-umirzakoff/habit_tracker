import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTheme {
  static ThemeData get darkTheme {
    return ThemeData(
      scaffoldBackgroundColor: AppColors.background,
      primaryColor: AppColors.accentGreen,
      // Using Inter to approximate SF Pro Display
      fontFamily: GoogleFonts.inter().fontFamily,
      textTheme: TextTheme(
        // style_KT0GRA: 62px, w800
        displayLarge: GoogleFonts.inter(
          fontSize: 62,
          fontWeight: FontWeight.w800,
          color: AppColors.textPrimary,
          height: 0.87,
        ),
        // style_HYJ9VC: Habit title
        titleMedium: GoogleFonts.inter(
          fontSize: 16, // Estimated
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
        ), 
        // style_R9PTAU: 17px, w500
        bodyLarge: GoogleFonts.inter(
          fontSize: 17,
          fontWeight: FontWeight.w500,
          color: AppColors.textPrimary,
          height: 1.19,
        ),
         // style_RVX8KZ: 15px, w500
        bodyMedium: GoogleFonts.inter(
          fontSize: 15,
          fontWeight: FontWeight.w500,
          color: AppColors.textPrimary,
           height: 1.19,
        ),
         // style_1MCZ4S: 15px, w600 (Labels)
        labelLarge: GoogleFonts.inter(
          fontSize: 15,
          fontWeight: FontWeight.w600,
          color: AppColors.textSecondary,
           height: 1.19,
        ),
      ),
      colorScheme: const ColorScheme.dark(
        primary: AppColors.accentGreen,
        secondary: AppColors.accentGreen,
        surface: AppColors.surfaceInput,
      ),
      useMaterial3: true,
    );
  }
}
