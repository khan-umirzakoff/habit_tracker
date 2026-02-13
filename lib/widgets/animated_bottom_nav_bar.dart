import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';

class AnimatedBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const AnimatedBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // Scale factor for responsive sizing (assuming context size relative to design 390)
    final double scale = MediaQuery.of(context).size.width / 390.0;

    return Container(
      width: 216 * scale,
      height: 60 * scale,
      decoration: BoxDecoration(
        color: const Color(0xFF222222), // fill_MZJG53 from Figma
        borderRadius: BorderRadius.circular(1000),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Items Row
          // To achieve the specific positioning (4, 106, 160) and widths (100, 52, 52)
          // We can use an AnimatedPositioned approach or a Row with AnimatedContainers.
          // Since the total width is fixed (216), and spacing matters:
          // Home (0) -> x:4. Width: 100 or 52.
          // Add (1) -> x:106 (if Home wide) OR x:? (if Home small).
          // Figma layout is absolute positioning. "Home" is x:4. "Add" x:106. "Calendar" x:160.
          // BUT: If Home shrinks to 52, does Add move left?
          // User said: "home torayib icon holatga o'tsin" (home shrink to icon).
          // If Home shrinks (100 -> 52), valid gap is 4px.
          // So 4 + 52 + 4 = 60. Then Add starts at 60?
          // If Add expands (52 -> 100).
          // Total width required: 52 (Home) + 4 + 100 (Add) + 4 + 52 (Cal) = 212.
          // Container width 216. 212 fits comfortably with 2px padding on ends?
          // Or 4px gap means: 4 (start) + 52 + gap(4) + 100 + gap(4) + 52 + 4 (end)? = 220? No.
          // Let's check Figma again.
          // Home Active: Home(100) + gap(?) + Add(52) + gap(?) + Cal(52).
          // 106 - (4+100) = 2px gap?
          // 4 (x) + 100 (w) = 104. Add x is 106. Gap is 2px.
          // 160 (x) - (106+52) = 160 - 158 = 2px gap.
          // So gaps are 2px.
          // Total width: 4 + 100 + 2 + 52 + 2 + 52 + 4 = 216.
          // Perfect. 216 is the container width.

          // So logic: Row with MainAxisAlignment.center (or specific padding).
          // Gap: 2px.
          // Items: AnimatedContainer(duration: 300ms, width: isActive ? 100 : 52).

          Row(
            mainAxisAlignment: MainAxisAlignment.center, // or SpaceEvenly with small details
            children: [
              _buildNavItem(
                index: 0,
                iconPath: 'assets/icons/home_icon.svg',
                label: 'Home',
                scale: scale,
                isSelected: currentIndex == 0,
              ),
              SizedBox(width: 2 * scale),
              _buildNavItem(
                index: 1,
                iconPath: 'assets/icons/plus_icon.svg',
                label: 'Add', // Or whatever "Habbit" or "New"? User said "+ Add". Figma has icon. I'll use "Add".
                scale: scale,
                isSelected: currentIndex == 1,
                isPlus: true, // Special styling for plus icon?
              ),
              SizedBox(width: 2 * scale),
              _buildNavItem(
                index: 2,
                iconPath: 'assets/icons/calendar_icon.svg',
                label: 'History', // Or Calendar
                scale: scale,
                isSelected: currentIndex == 2,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem({
    required int index,
    required String iconPath,
    required String label,
    required double scale,
    required bool isSelected,
    bool isPlus = false,
  }) {
    // Dimensions
    final double width = isSelected ? 100.0 * scale : 52.0 * scale;
    final double height = 52.0 * scale;

    return GestureDetector(
      onTap: () => onTap(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: AppColors.textPrimary.withValues(alpha: 0.1), // fill_8HYCYF 10% opacity
          borderRadius: BorderRadius.circular(1000),
       ),
       child: SingleChildScrollView(
         scrollDirection: Axis.horizontal,
         physics: const NeverScrollableScrollPhysics(),
         child: Container(
           width: width, // Constraint text layout
           padding: EdgeInsets.symmetric(horizontal: isSelected ? 0 : 0), // Centering handled by alignment
           height: height,
           child: Row(
             mainAxisAlignment: MainAxisAlignment.center,
             crossAxisAlignment: CrossAxisAlignment.center,
             children: [
                // Icon
                Opacity(
                  opacity: isSelected ? 1.0 : 0.4, // Inactive items have 0.4 opacity in Figma for Calendar?
                  // Home active: 1.0. Add/Cal inactive? 
                  // Figma Home Active: Home(1.0), Add(1.0?), Cal(0.4).
                  // Let's assume standard behavior: Selected=1.0, Unselected=0.4 (unless it's the Plus button which might be distinct).
                  // Plus button in Figma (178:3304) -> Group 48100455 (Image SVG). Opacity?
                  // Let's stick to 0.4 for inactive, 1.0 for active, except maybe Plus can be brighter.
                  child: SvgPicture.asset(
                    iconPath,
                    width: 24 * scale,
                    height: 24 * scale,
                    colorFilter: ColorFilter.mode(
                      AppColors.textPrimary,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
                
                // Text (Only if selected)
                if (isSelected) ...[
                  SizedBox(width: 4 * scale), // Gap 4px
                  // Use Flexible to prevent overflow during animation? 
                  // Or just Text. The AnimatedContainer clips content usually? No.
                  // SingleChildScrollView with NeverScrollable should handle clipping if width is small?
                  // Actually the conditional 'if (isSelected)' causes a jump if inserted immediately.
                  // Better to use AnimatedOpacity + Align/Size/Row.
                  // But for "silliq" (smooth), simpler is often better:
                  // The container expands, and text appears. 
                  // Let's just use the if(isSelected) for now, as 300ms is fast.
                  // Scale width first, then text appears?
                  Text(
                    label,
                    style: GoogleFonts.inter(
                      fontSize: 15 * scale,
                      fontWeight: FontWeight.w500,
                      height: 1.193,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ],
             ],
           ),
         ),
       ),
      ),
    );
  }
}
