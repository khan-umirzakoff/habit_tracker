import 'dart:ui';

/// Figma "empty" page (node 178:5570) dan olingan ranglar
class AppColors {
  AppColors._();

  // Asosiy fon — fill_WPAZ5M: #333333
  static const Color background = Color(0xFF333333);

  // Surface / card fon — fill_MXDWZC: #222222
  static const Color surface = Color(0xFF222222);

  // Asosiy matn rangi — fill_C5SW9P: #FFFFFF
  static const Color textPrimary = Color(0xFFFFFFFF);

  // Darkerroq surface — fill_5NF45Z (onboarding'da ishlatilgan)
  static const Color darkerSurface = Color(0xFF1A1A1A);

  // Notification bell — fill_SX8GVK: #FFBB00
  static const Color accentYellow = Color(0xFFFFBB00);

  // Avatar border — fill_VIPOG4: #FEBB64
  static const Color avatarBorder = Color(0xFFFEBB64);

  // Green accent — fill_L342D4: #9BDA88
  static const Color greenAccent = Color(0xFF9BDA88);

  // D9D9D9 — fill_6AD7HO: #D9D9D9 (illustration element)
  static const Color grey = Color(0xFFD9D9D9);

  // Card inner surface — fill_CUQ4YJ: #383838
  static const Color surfaceLight = Color(0xFF383838);

  // fill_NCESQG: #F6F6F6
  static const Color lightGrey = Color(0xFFF6F6F6);

  // Gradient fon (date nav header) — fill_7L1DOB
  // linear-gradient(180deg, #333333 0%, rgba(51,51,51,0.9) 80%, rgba(51,51,51,0.75) 90%, rgba(51,51,51,0) 100%)
  static const Color gradientStart = Color(0xFF333333);
  static const Color gradientEnd = Color(0x00333333);
}
