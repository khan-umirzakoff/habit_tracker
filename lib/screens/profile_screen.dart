import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';
import 'history_screen.dart';
import 'add_habit_screen.dart';
import 'onboarding_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final scale = screenWidth / 390;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // Background Pattern (Figma 178:2835) - Restored and Brightened
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 300 * scale,
            child: Opacity(
              opacity: 0.15, // Reduced from 0.4 to fix "too bright" issue
              child: SvgPicture.asset(
                'assets/images/profile_header_pattern_v2.svg',
                fit: BoxFit.cover,
                alignment: Alignment.topCenter,
              ),
            ),
          ),
          // Main Content
          SafeArea(
            child: Column(
              children: [
                _buildHeader(context, scale),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        // Avatar Section - Dumbbell shape (Figma 178:2956)
                        SizedBox(
                          width: 147 * scale,
                          height: 64 * scale,
                          child: Stack(
                            children: [
                              SvgPicture.asset(
                                'assets/images/avatar_frame_connected.svg',
                                width: 147 * scale,
                                height: 64 * scale,
                              ),
                              // Faqat chap tarafdagi logotip qismi (64x64 maydon)
                              Positioned(
                                left: 0,
                                top: 0,
                                bottom: 0,
                                width: 64 * scale,
                                child: GestureDetector(
                                  behavior: HitTestBehavior.opaque,
                                  onTap: () {
                                    // Ekranni to'liq yopib, home_screen ga barcha stacklarni tozalab chiqish
                                    Navigator.of(
                                      context,
                                    ).popUntil((route) => route.isFirst);
                                  },
                                  child: const SizedBox.expand(),
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Gap to reach Name (Figma Top: 140).
                        SizedBox(height: 16 * scale),
                        // Name
                        Text(
                          "Abdulbosit Umirzoqov", // Updated name
                          textAlign: TextAlign.center,
                          style: GoogleFonts.inter(
                            fontSize: 17 * scale,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                        // Gap to reach Email
                        SizedBox(height: 1 * scale),
                        // Email
                        Text(
                          "khanumirzakoff@gmail.com", // Updated email
                          textAlign: TextAlign.center,
                          style: GoogleFonts.tinos(
                            fontSize: 15 * scale,
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.italic,
                            color: const Color(0xFF9BDA88),
                          ),
                        ),
                        // Gap to reach Logout
                        SizedBox(height: 7 * scale),
                        // Logout Button
                        _buildLogoutButton(context, scale),
                        // Gap to reach Menu
                        SizedBox(height: 35 * scale),
                        // Menu
                        _ProfileMenuWidget(scale: scale),
                        SizedBox(height: 50 * scale), // Bottom padding
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLogoutButton(BuildContext context, double scale) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => const OnboardingScreen()),
          (route) => false,
        );
      },
      child: Container(
        width: 104 * scale,
        height: 42 * scale,
        decoration: BoxDecoration(
          color: const Color(0xFF222222),
          borderRadius: BorderRadius.circular(100 * scale),
        ),
        child: Stack(
          children: [
            Positioned(
              left: 3 * scale,
              top: 3 * scale,
              child: Container(
                width: 98 * scale,
                height: 36 * scale,
                decoration: BoxDecoration(
                  color: const Color(0xFF333333),
                  borderRadius: BorderRadius.circular(100 * scale),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.logout, color: Colors.white, size: 16 * scale),
                    SizedBox(width: 4 * scale),
                    Text(
                      "Chiqish",
                      style: GoogleFonts.inter(
                        fontSize: 15 * scale,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, double scale) {
    return Container(
      width: double.infinity,
      height: 60 * scale,
      decoration: const BoxDecoration(color: Colors.transparent),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            // Bosish maydonini (hitbox) kengaytirish uchun:
            behavior: HitTestBehavior.opaque,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 16 * scale,
                vertical: 10 * scale,
              ),
              child: SvgPicture.asset(
                'assets/icons/arrow_back_icon.svg',
                width: 24 * scale,
                height: 24 * scale,
                colorFilter: const ColorFilter.mode(
                  Colors.white,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
          SizedBox(width: 2 * scale),
          Text(
            "Profile",
            style: GoogleFonts.inter(
              fontSize: 17 * scale,
              fontWeight: FontWeight.w600,
              height: 1.193,
              color: const Color(0xFFDBD8D3),
            ),
          ),
          Spacer(),
        ],
      ),
    );
  }
}

class _ProfileMenuWidget extends StatelessWidget {
  final double scale;

  const _ProfileMenuWidget({required this.scale});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300 * scale,
      padding: EdgeInsets.all(5 * scale),
      decoration: BoxDecoration(
        color: const Color(0xFF222222),
        borderRadius: BorderRadius.circular(22 * scale),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.05),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.25),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildMenuItem(
            context: context,
            text: "Barcha Habbitlarim",
            scale: scale,
            onTap: () {
              Navigator.of(
                context,
              ).push(MaterialPageRoute(builder: (_) => const HistoryScreen()));
            },
          ),
          SizedBox(height: 4 * scale),
          _buildMenuItem(
            context: context,
            text: "Eng sara ko’rsatkichlar",
            scale: scale,
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Bu bo‘lim keyingi bosqichda ulanadi'),
                ),
              );
            },
          ),
          SizedBox(height: 4 * scale),
          _buildMenuItem(
            context: context,
            text: "Eng yomon ko’rsatkichlar",
            scale: scale,
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Bu bo‘lim keyingi bosqichda ulanadi'),
                ),
              );
            },
          ),
          SizedBox(height: 4 * scale),
          _buildMenuItem(
            context: context,
            text: "Habbit qo’shish",
            scale: scale,
            onTap: () {
              Navigator.of(
                context,
              ).push(MaterialPageRoute(builder: (_) => const AddHabitScreen()));
            },
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem({
    required BuildContext context,
    required String text,
    required double scale,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 52 * scale,
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(18 * scale),
        ),
        alignment: Alignment.center,
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(
            fontSize: 17 * scale,
            fontWeight: FontWeight.w400,
            height: 1.193,
            color: Colors.white.withValues(alpha: 0.7),
          ),
        ),
      ),
    );
  }
}
