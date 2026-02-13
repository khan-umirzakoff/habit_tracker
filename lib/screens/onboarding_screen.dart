import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';
import 'main_screen.dart';
import 'empty_screen.dart';

/// Figma "3-page" — node 178:2433
/// Frame 2087327733: column, gap:20, w:320
class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    // Figma frame: 390×844
    // Content group (178-2433): x:34, y:128, w:320
    final scale = screenWidth / 390;
    final horizontalPadding = 34 * scale;

    return Scaffold(
      backgroundColor: AppColors.background, // #333333
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Figma: Content at y=128, status bar h=44
              // Gap = 128 - 44 = 84
              SizedBox(height: 84 * scale),

              // === TITLE ===
              // Figma: style_G2KPN6: SF Pro Display, w800, 62px, lineHeight: 0.871em
              // fill: #FFFFFF, textAlign: LEFT
              Text(
                "Take Control of Your Life",
                style: GoogleFonts.inter(
                  fontSize: 62 * scale,
                  fontWeight: FontWeight.w800,
                  height: 0.871,
                  color: AppColors.textPrimary, // #FFFFFF
                ),
              ),

              // Figma column gap: 20px
              SizedBox(height: 20 * scale),

              // === DESCRIPTION ===
              // Figma: style_80F8G3: SF Pro Display, w500, 15px, lineHeight: 1.193em
              // fill: #FFFFFF, opacity: 0.8, textAlign: LEFT
              Opacity(
                opacity: 0.8,
                child: Text(
                  "Build better routines, track progress, and stay consistent every day with simple tools that turn small actions into lasting habits.",
                  style: GoogleFonts.inter(
                    fontSize: 15 * scale,
                    fontWeight: FontWeight.w500,
                    height: 1.193,
                    color: AppColors.textPrimary, // #FFFFFF
                  ),
                ),
              ),

              // Figma column gap: 20px
              SizedBox(height: 20 * scale),

              // === GOOGLE LOGIN BUTTON ===
              // Figma: Group 13, w:320, h:56
              _buildGoogleButton(context, scale),

              SizedBox(height: 20 * scale),
            ],
          ),
        ),
      ),
    );
  }

  /// Google Login Button
  /// Figma: Rectangle 14 — w:320, h:56, fill: #FFFFFF, borderRadius: 16
  /// Inner row: gap:8, at x:82, y:18
  /// Google icon: 20×20
  /// Text: style_HT9W0U — SF Pro Display, w500, 17px, fill: #222222
  Widget _buildGoogleButton(BuildContext context, double scale) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const MainScreen()),
        );
      },
      child: Container(
        width: 320 * scale,
        height: 56 * scale,
        decoration: BoxDecoration(
          color: Colors.white, // fill: #FFFFFF
          borderRadius: BorderRadius.circular(16 * scale),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Google icon — 20×20
            SvgPicture.asset(
              'assets/icons/google_icon.svg',
              width: 20 * scale,
              height: 20 * scale,
            ),
            SizedBox(width: 8 * scale), // gap: 8
            // Button text — w500, 17px, #222222
            Text(
              "Gmail orqali kirish",
              style: GoogleFonts.inter(
                fontSize: 17 * scale,
                fontWeight: FontWeight.w500,
                height: 1.193,
                color: AppColors.surface, // #222222
              ),
            ),
          ],
        ),
      ),
    );
  }
}
