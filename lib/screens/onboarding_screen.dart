import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../theme/app_colors.dart';
import 'dashboard_screen.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacer(),
              // Title: Take Control of Your Life
              Text(
                "Take Control of Your Life",
                style: Theme.of(context).textTheme.displayLarge?.copyWith(
                  height: 0.87, // style_KT0GRA
                  letterSpacing: -1.0, // Adjusting for tight heading
                ),
              ),
              const SizedBox(height: 24),
              // Description
              Text(
                "Build better routines, track progress, and stay consistent every day with simple tools that turn small actions into lasting habits.",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.textPrimary.withValues(alpha: 0.8), // Opacity 0.8
                  height: 1.4, // Increased line height for readability
                  fontSize: 17, // Using 17px as per style_RVX8KZ (actually bodyMedium is 15 in theme, bodyLarge is 17. Figma said style_RVX8KZ)
                  // Let's check theme mapping: bodyMedium was style_RVX8KZ (15px).
                  // But the text looks substantial. Let's stick to theme or override.
                  // Figma data says: textStyle: style_RVX8KZ. 
                  // In AppTheme: bodyMedium: GoogleFonts.inter(fontSize: 15...
                  // I'll stick to bodyMedium but maybe override fontSize if it feels too small, 
                  // but 15px is standard for body text.
                ),
              ),
              const Spacer(),
              // Google Login Button
              _buildGoogleButton(context),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGoogleButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushReplacement(
           MaterialPageRoute(builder: (_) => const DashboardScreen()),
        );
      },
      child: Container(
        height: 56,
        decoration: BoxDecoration(
          color: Colors.white, // fill_ED2KH0
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/icons/google_icon.svg',
              width: 24,
              height: 24,
            ),
            const SizedBox(width: 12),
            Text(
              "Gmail orqali kirish",
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: AppColors.darkerSurface, // fill_5NF45Z
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
