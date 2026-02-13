import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';

class AddHabitScreen extends StatelessWidget {
  const AddHabitScreen({super.key});

  @override
  Widget build(BuildContext context) {
     // Scale factor
    final double scale = MediaQuery.of(context).size.width / 390.0;

    return Scaffold(
      backgroundColor: const Color(0xFF333333), // Header bg color
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context, scale),
            // Placeholder for form content
            Expanded(
              child: Center(
                child: Text(
                  "Add Habit Form",
                  style: GoogleFonts.inter(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, double scale) {
    // 178:2544 Header
    // Height 100 (including status bar). SafeArea handles status bar.
    // Content: Back Icon (x:16), Title (x:52)
    // Divider at bottom.
    
    // We use a Container with height ~60 for the actual bar content
    return Container(
      width: double.infinity,
      height: 60 * scale, // Approx toolbar height
      decoration: BoxDecoration(
        color: const Color(0xFF333333),
        border: Border(
           bottom: BorderSide(
             color: Colors.white.withValues(alpha: 0.05),
             width: 1,
           ),
        ),
      ),
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          // Back Button (x:16)
          Positioned(
            left: 16 * scale,
            child: GestureDetector(
              onTap: () {
                // Navigate back to Home? 
                // In MainScreen, we just switch index? 
                // Or if this screen was pushed, pop. 
                // But passing a callback to switch tab is better if using MainScreen.
                // For now, let's assume it switches tab. 
                // But AddHabitScreen doesn't have reference to MainScreen state easily.
                // Start by finding ancestor or using global key?
                // Simplest: The "Back" button usually means "Cancel".
                // We'll leave it empty for now or use `Navigator.pop` if we push it.
                // But we are in IndexedStack.
                // We might need to pass a callback `onBack`.
              },
              child: SvgPicture.asset(
                'assets/icons/arrow_back_icon.svg', // Need to check if available
                width: 24 * scale,
                height: 24 * scale,
                 colorFilter: const ColorFilter.mode(
                    Colors.white,
                    BlendMode.srcIn,
                 ),
              ),
            ),
          ),
          
          // Title (x:52)
          Positioned(
             left: 52 * scale,
             child: Text(
               "Habbit qo’shish",
               style: GoogleFonts.inter( // SF Pro Display in Figma, using Inter as substitute
                  fontSize: 17 * scale,
                  fontWeight: FontWeight.w600,
                  height: 1.193,
                  color: const Color(0xFFDBD8D3),
               ),
             ),
          ),
        ],
      ),
    );
  }
}
