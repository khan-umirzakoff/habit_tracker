import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';
import 'dart:math' as math;

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final scale = screenWidth / 390;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context, scale),
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 100 * scale,
                      height: 100 * scale,
                      decoration: const BoxDecoration(
                        color: AppColors.surface,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.person, size: 50 * scale, color: AppColors.textPrimary),
                    ),
                    SizedBox(height: 16 * scale),
                    Text(
                      "Profile",
                      style: GoogleFonts.inter(
                        fontSize: 24 * scale,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
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
      decoration: BoxDecoration(
        color: AppColors.background,
        border: Border(
           bottom: BorderSide(
             color: Colors.white.withValues(alpha: 0.05),
             width: 1,
           ),
        ),
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
