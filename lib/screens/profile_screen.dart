import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';

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
            height: 240 * scale,
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
                        SvgPicture.asset(
                          'assets/images/avatar_frame_connected.svg',
                          width: 147 * scale,
                          height: 64 * scale,
                        ),
                        // Gap to reach Name (Figma Top: 140).
                        SizedBox(height: 16 * scale),
                        // Name
                        Text(
                          "Abbos Janizakov",
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
                          "abbosjanizakov@gmail.com",
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
                        _buildLogoutButton(scale),
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

  Widget _buildLogoutButton(double scale) {
    return Container(
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
    );
  }

  Widget _buildHeader(BuildContext context, double scale) {
    return Container(
      width: double.infinity,
      height: 60 * scale,
      decoration: const BoxDecoration(
        color: Colors.transparent,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(width: 16 * scale),
          GestureDetector(
            onTap: () => Navigator.pop(context),
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
          SizedBox(width: 12 * scale),
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
          color: Colors.white.withOpacity(0.05),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildMenuItem("Barcha Habbitlarim", scale),
          SizedBox(height: 4 * scale),
          _buildMenuItem("Eng sara ko’rsatkichlar", scale),
          SizedBox(height: 4 * scale),
          _buildMenuItem("Eng yomon ko’rsatkichlar", scale),
          SizedBox(height: 4 * scale),
          _buildMenuItem("Habbit qo’shish", scale),
        ],
      ),
    );
  }

  Widget _buildMenuItem(String text, double scale) {
    return Container(
      width: double.infinity,
      height: 52 * scale,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
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
          color: Colors.white.withOpacity(0.7),
        ),
      ),
    );
  }
}
