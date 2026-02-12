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

          // === HEADER AREA with gradient ===
          // Figma: y:103 (bu status bar + header gap)
          // Gap between status bar and date nav: 103 - 44 = 59
          SizedBox(height: 59 * scale),

          // === DATE NAVIGATION BAR ===
          // Figma: Group 1000004732 → Group 1000004730
          // layout_Q97QMO: x:55, w:278, h:60
          // Inner: Frame 2087327709, layout_DZNE34: row, gap:4px
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 55 * scale),
            child: SizedBox(
              height: 60 * scale,
              child: _buildDateNavRow(scale),
            ),
          ),

          // === HEADER SECTION ===
          // Figma: Frame 2087327716, layout_EUEQEQ
          // y:230, header starts at 230. Date nav ends at 103+111=214. Gap: 230-214=16
          SizedBox(height: 16 * scale),

          // "All Schelduled for Today"
          // Figma: layout_P9VWOM, textAlign: CENTER
          // style_YJNKX6: w400, 15px, opacity: 0.4
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

          SizedBox(height: 12 * scale), // gap: 12

          // === STATS ROW ===
          // Figma: Frame 2087327713, layout_HZREDV: row, gap:4
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Notification bell — layout_YAF845: 24×24, fill_SX8GVK: #FFBB00
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
              // "0 Habits" badge — layout_KLJ82O: 74×32, fill_MXDWZC: #222222, borderRadius: 30px
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
              // "~%" — style_3I33CO: w600, 15px, letterSpacing: -4%
              Text(
                '~%',
                style: AppTextStyles.percentText.copyWith(fontSize: 15 * scale),
              ),
            ],
          ),

          SizedBox(height: 12 * scale),

          // === EMPTY ILLUSTRATION ===
          // Figma: Group 1000004723, layout_DHPC7A: w:230, h:62
          SvgPicture.asset(
            'assets/images/empty_illustration.svg',
            width: 230 * scale,
            height: 62 * scale,
          ),

          // === SPACER TO PUSH CONTENT DOWN ===
          const Spacer(),

          // === CHECKMARK ORNAMENT ===
          // Figma: Group 48100458, layout_F7J6S5: w:147, h:64
          SvgPicture.asset(
            'assets/images/checkmark_ornament.svg',
            width: 147 * scale,
            height: 64 * scale,
          ),

          SizedBox(height: 20 * scale),

          // === AVATAR (Mask group) ===
          // Figma: layout_SVFB2H: w:100, h:100
          ClipOval(
            child: Image.asset(
              'assets/images/avatar.png',
              width: 100 * scale,
              height: 100 * scale,
              fit: BoxFit.cover,
            ),
          ),

          SizedBox(height: 12 * scale),

          // === MOTIVATIONAL TEXT ===
          // Figma: layout_YXUKPB: x:38, w:314
          // style_BOE4LX: w400, 12px, lineHeight: 1.417, textAlign: CENTER
          // opacity: 0.2
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 38 * scale),
            child: Text(
              "Hayotingizni o'zgartrishni istasangiz odatlaringizni boshqarishni o'rganing. Xozirda sizda birorta ham Habbit kiritilmagan!",
              textAlign: TextAlign.center,
              style: AppTextStyles.caption.copyWith(
                fontSize: 12 * scale,
                color: AppColors.textPrimary.withValues(alpha: 0.2),
              ),
            ),
          ),

          const Spacer(),

          // === BOTTOM NAV BAR ===
          // Figma: Group 1000004729, layout_84CDO6: w:216, h:60
          _buildBottomNavBar(scale),

          // Bottom padding
          SizedBox(height: 29 * scale), // 844 - 755 - 60 = 29 (bottom gap)
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
