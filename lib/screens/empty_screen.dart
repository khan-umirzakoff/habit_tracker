import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

/// Figma "empty" page — node 178:5570
/// Figma frame: 390×844, fill: #333333
/// Pixel-perfect: barcha o'lchamlar Figma qiymatlaridan olingan
class EmptyScreen extends StatelessWidget {
  const EmptyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    // Figma frame width: 390. Scale factor for proportional sizing
    final scale = screenWidth / 390;

    return Scaffold(
      backgroundColor: AppColors.background, // fill_WPAZ5M: #333333
      body: Column(
        children: [
          // === STATUS BAR SPACER ===
          // Figma: Status Bar - iPhone, layout_LP0A4B: h:44
          SizedBox(height: MediaQuery.of(context).padding.top),

          // === HEADER DECORATION ===
          // Figma: Node 178-5851, x:120.5, y:60, w:147, h:64
          // Gap from status bar (y=44) to header (y=60) = 16
          SizedBox(height: 16 * scale),

          SvgPicture.asset(
            'assets/images/checkmark_ornament.svg',
            width: 147 * scale,
            height: 64 * scale,
          ),

          // === DATE NAVIGATION BAR ===
          // Figma: Group at y:103, h:111. Inner buttons at y:154 (103+51), h:60
          // Header decoration ends at y=124. Date nav inner starts at y=154.
          // Gap = 154 - 124 = 30
          SizedBox(height: 30 * scale),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 55 * scale),
            child: SizedBox(
              height: 60 * scale,
              child: _buildDateNavRow(scale),
            ),
          ),

          // === CONTENT COLUMN (text + stats + illustration) ===
          // Figma: y:230. Date nav ends at y=214. Gap = 16
          SizedBox(height: 16 * scale),

          // "All Schelduled for Today"
          // Figma: w:230, style: w400, 15px, opacity: 0.4, textAlign: CENTER
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 79 * scale),
            child: SizedBox(
              width: 230 * scale,
              child: Text(
                'All Schelduled for Today',
                textAlign: TextAlign.center,
                style: AppTextStyles.bodyRegular.copyWith(
                  fontSize: 15 * scale,
                  color: AppColors.textPrimary.withValues(alpha: 0.4),
                ),
              ),
            ),
          ),

          SizedBox(height: 12 * scale), // column gap: 12

          // === STATS ROW ===
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/icons/notification_bell.svg',
                width: 24 * scale,
                height: 24 * scale,
                colorFilter: const ColorFilter.mode(
                  AppColors.accentYellow,
                  BlendMode.srcIn,
                ),
              ),
              SizedBox(width: 4 * scale),
              Container(
                width: 74 * scale,
                height: 32 * scale,
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(30 * scale),
                ),
                alignment: Alignment.center,
                child: Text(
                  '0 Habits',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.bodySemiBold.copyWith(fontSize: 15 * scale),
                ),
              ),
              SizedBox(width: 4 * scale),
              Text(
                '~%',
                style: AppTextStyles.percentText.copyWith(fontSize: 15 * scale),
              ),
            ],
          ),

          SizedBox(height: 12 * scale), // column gap: 12

          // === EMPTY ILLUSTRATION ===
          // Figma: w:230, h:62
          SvgPicture.asset(
            'assets/images/empty_illustration.svg',
            width: 230 * scale,
            height: 62 * scale,
          ),

          // === DECORATIVE WAVE ===
          // Figma: Node 178-5991, x:145, y:399, w:100, h:100
          // Content ends ~y=366. Gap = 399 - 366 = 33
          SizedBox(height: 33 * scale),

          SvgPicture.asset(
            'assets/images/decorative_wave.svg',
            width: 100 * scale,
            height: 100 * scale,
          ),

          // === MOTIVATIONAL TEXT ===
          // Figma: x:38, y:510, w:314, h:51
          // Wave ends at y=499. Gap = 510 - 499 = 11
          SizedBox(height: 11 * scale),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 38 * scale),
            child: SizedBox(
              width: 314 * scale,
              height: 51 * scale,
              child: Text(
                "Hayotingizni o'zgartrishni istasangiz odatlaringizni boshqarishni o'rganing. Xozirda sizda birorta ham Habbit kiritilmagan!",
                textAlign: TextAlign.center,
                style: AppTextStyles.caption.copyWith(
                  fontSize: 12 * scale,
                  color: AppColors.textPrimary.withValues(alpha: 0.2),
                ),
              ),
            ),
          ),

          // === GAP TO BOTTOM NAV ===
          // Figma: Text ends at y=561. Bottom nav at y=755. Gap = 194
          // Use Spacer to fill remaining space (adapts to screen height)
          const Spacer(),

          // === BOTTOM NAV BAR ===
          // Figma: x:87, y:755, w:216, h:60
          _buildBottomNavBar(scale),

          // Bottom padding: 844 - 815 = 29
          SizedBox(height: 29 * scale),
        ],
      ),
    );
  }

  /// Date navigation row: [← arrow] [21 Dekabr] [→ arrow]
  /// Figma: layout_DZNE34: row, alignItems: center, gap: 4px
  Widget _buildDateNavRow(double scale) {
    return Row(
      children: [
        // Left arrow — layout_UNI2C0: 60×60
        _buildCircleNavButton(
          svgPath: 'assets/icons/arrow_left.svg',
          scale: scale,
        ),
        SizedBox(width: 4 * scale),
        // Date label — layout_U2DH30: 150×60
        Expanded(child: _buildDateLabel(scale)),
        SizedBox(width: 4 * scale),
        // Right arrow — layout_UNI2C0: 60×60
        _buildCircleNavButton(
          svgPath: 'assets/icons/arrow_right.svg',
          scale: scale,
        ),
      ],
    );
  }

  /// Circle nav button (← or →)
  /// Figma: outer 60×60 fill_MXDWZC #222222, inner 52×52 fill_WPAZ5M #333333 at (4,4)
  /// Icon 24×24 at (18,18)
  Widget _buildCircleNavButton({
    required String svgPath,
    required double scale,
  }) {
    final outerSize = 60 * scale;
    final innerSize = 52 * scale;
    final innerPad = 4 * scale;

    return SizedBox(
      width: outerSize,
      height: outerSize,
      child: Stack(
        children: [
          // Outer circle
          Container(
            width: outerSize,
            height: outerSize,
            decoration: BoxDecoration(
              color: AppColors.surface, // #222222
              shape: BoxShape.circle,
            ),
          ),
          // Inner circle
          Positioned(
            left: innerPad,
            top: innerPad,
            child: Container(
              width: innerSize,
              height: innerSize,
              decoration: BoxDecoration(
                color: AppColors.background, // #333333
                shape: BoxShape.circle,
              ),
            ),
          ),
          // Icon centered
          Center(
            child: SvgPicture.asset(
              svgPath,
              width: 24 * scale,
              height: 24 * scale,
            ),
          ),
        ],
      ),
    );
  }

  /// Date label "21 Dekabr"
  /// Figma: outer 150×60 fill_MXDWZC #222222 borderRadius:100
  /// Inner 142×52 at (4,4) fill_WPAZ5M #333333 borderRadius:100
  /// Text at (27,17) style_YYS1UC: w500, 22px, textAlign:CENTER
  Widget _buildDateLabel(double scale) {
    final outerH = 60 * scale;
    final innerPad = 4 * scale;
    final innerH = 52 * scale;

    return SizedBox(
      height: outerH,
      child: Stack(
        children: [
          // Outer pill
          Container(
            decoration: BoxDecoration(
              color: AppColors.surface, // #222222
              borderRadius: BorderRadius.circular(100 * scale),
            ),
          ),
          // Inner pill
          Positioned(
            left: innerPad,
            top: innerPad,
            right: innerPad,
            child: Container(
              height: innerH,
              decoration: BoxDecoration(
                color: AppColors.background, // #333333
                borderRadius: BorderRadius.circular(100 * scale),
              ),
            ),
          ),
          // Date text centered
          Center(
            child: Text(
              '21 Dekabr',
              textAlign: TextAlign.center,
              style: AppTextStyles.dateTitle.copyWith(fontSize: 22 * scale),
            ),
          ),
        ],
      ),
    );
  }

  /// Bottom Navigation Bar
  /// Figma: layout_84CDO6: w:216, h:60
  /// Background pill: layout_HS8RNS: 216×60, fill_MXDWZC #222222, borderRadius:1000
  Widget _buildBottomNavBar(double scale) {
    return SizedBox(
      width: 216 * scale,
      height: 60 * scale,
      child: Stack(
        children: [
          // Background pill
          Container(
            decoration: BoxDecoration(
              color: AppColors.surface, // #222222
              borderRadius: BorderRadius.circular(1000),
            ),
          ),

          // Home button (active) — layout_9ZO15N: x:4, y:4, w:100, h:52
          Positioned(
            left: 4 * scale,
            top: 4 * scale,
            child: Container(
              width: 100 * scale,
              height: 52 * scale,
              decoration: BoxDecoration(
                color: AppColors.textPrimary.withValues(alpha: 0.1), // white 10%
                borderRadius: BorderRadius.circular(1000),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Home icon — 24×24
                  SvgPicture.asset(
                    'assets/icons/home_icon.svg',
                    width: 24 * scale,
                    height: 24 * scale,
                    colorFilter: const ColorFilter.mode(
                      AppColors.textPrimary,
                      BlendMode.srcIn,
                    ),
                  ),
                  SizedBox(width: 4 * scale),
                  // "Home" — style_FLT4KI: w500, 15px
                  Text(
                    'Home',
                    style: AppTextStyles.navLabel.copyWith(fontSize: 15 * scale),
                  ),
                ],
              ),
            ),
          ),

          // Plus button — layout_X4CU24: x:106, y:4, w:52, h:52
          Positioned(
            left: 106 * scale,
            top: 4 * scale,
            child: Container(
              width: 52 * scale,
              height: 52 * scale,
              decoration: BoxDecoration(
                color: AppColors.textPrimary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(1000),
              ),
              child: Center(
                child: SvgPicture.asset(
                  'assets/icons/plus_icon.svg',
                  width: 24 * scale,
                  height: 24 * scale,
                ),
              ),
            ),
          ),

          // Calendar button — layout_X2SZ3J: x:160, y:4, w:52, h:52
          Positioned(
            left: 160 * scale,
            top: 4 * scale,
            child: Container(
              width: 52 * scale,
              height: 52 * scale,
              decoration: BoxDecoration(
                color: AppColors.textPrimary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(1000),
              ),
              child: Center(
                child: SvgPicture.asset(
                  'assets/icons/calendar_icon.svg',
                  width: 24 * scale,
                  height: 24 * scale,
                  colorFilter: const ColorFilter.mode(
                    AppColors.textPrimary,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
