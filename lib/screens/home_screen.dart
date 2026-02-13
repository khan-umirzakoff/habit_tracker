import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';
import '../widgets/habit_card.dart';
import '../data/habit_mock_data.dart';
import 'dart:math' as math;
import 'profile_screen.dart';

/// Figma "1-page" — node 178:3013
/// Frame: 390×1860 (scrollable), fill: #333333
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final scale = screenWidth / 390;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                // === STATUS BAR ===
                SizedBox(height: MediaQuery.of(context).padding.top),

                // === HEADER DECORATION ===
                SizedBox(height: 16 * scale),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/images/checkmark_ornament.svg',
                      width: 147 * scale,
                      height: 64 * scale,
                    ),
                    Positioned(
                      right: 0,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ProfileScreen(),
                            ),
                          );
                        },
                        child: Container(
                          width: 70 * scale,
                          height: 64 * scale,
                          color: Colors.transparent,
                        ),
                      ),
                    ),
                  ],
                ),

                // === DATE NAVIGATION ===
                SizedBox(height: 30 * scale),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 55 * scale),
                  child: SizedBox(
                    height: 60 * scale,
                    child: _buildDateNavRow(scale),
                  ),
                ),

                // === CONTENT COLUMN ===
                SizedBox(height: 16 * scale),
                Text(
                  'All Schelduled for Today',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontSize: 15 * scale,
                    fontWeight: FontWeight.w400,
                    height: 1.193,
                    color: AppColors.textPrimary.withValues(alpha: 0.4),
                  ),
                ),
                SizedBox(height: 12 * scale),

                // Stats row
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
                        '3 Habits',
                        style: GoogleFonts.inter(
                          fontSize: 15 * scale,
                          fontWeight: FontWeight.w600,
                          height: 1.193,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
                    SizedBox(width: 4 * scale),
                    Text(
                      '82%',
                      style: GoogleFonts.inter(
                        fontSize: 15 * scale,
                        fontWeight: FontWeight.w600,
                        height: 1.193,
                        letterSpacing: -0.6,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12 * scale),

                // Weekly bar
                SvgPicture.asset(
                  'assets/images/empty_illustration.svg',
                  width: 230 * scale,
                  height: 62 * scale,
                ),

                // === HABIT CARDS ===
                SizedBox(height: 16 * scale),

                // Card 1 — yellow/green/red
                HabitCard(
                  scale: scale,
                  description: "Har kuni eng kamida 2.5 km ga yugurish, motivatsiya - ozish. 97 kg edim.",
                  percentText: '67%',
                  percentColor: const Color(0xFFFEBB64),
                  daysText: '40d',
                  daysColor: const Color(0xFF9BDA88),
                  missedText: '-2d',
                  missedColor: const Color(0xFFDA6157),
                  hasMissedDouble: true,
                  progressFillWidth: 120,
                  progressGradient: const [Color(0xFF9BDA88), Color(0xFFFF7124)],
                  totalDays: '60 day',
                  currentDay: '18',
                  startDate: '9.11.2025',
                  endDate: '9.1.2026',
                  calendarColors: HabitMockData.card1CalendarColors,
                ),

                SizedBox(height: 20 * scale),

                // Separator
                Container(
                  width: 230 * scale,
                  height: 2 * scale,
                  decoration: BoxDecoration(
                    color: AppColors.textPrimary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(30 * scale),
                  ),
                ),
                SizedBox(height: 20 * scale),

                // Card 2 — grey/blue
                HabitCard(
                  scale: scale,
                  description: "Har kuni eng kamida 2.5 km ga yugurish, motivatsiya - ozish. 97 kg edim.",
                  percentText: '44%',
                  percentColor: const Color(0xFFD2D2D2),
                  daysText: '8d',
                  daysColor: const Color(0xFF88ADDA),
                  missedText: '0',
                  missedColor: Colors.transparent,
                  hasMissedDouble: false,
                  progressFillWidth: 73,
                  progressGradient: const [Color(0xFF88ADDA), Color(0xFFD2D2D2)],
                  totalDays: '20',
                  currentDay: '12',
                  startDate: '7.12.2025',
                  endDate: '27.12.2026',
                  calendarColors: HabitMockData.card2CalendarColors,
                ),

                SizedBox(height: 20 * scale),

                // Separator
                Container(
                  width: 230 * scale,
                  height: 2 * scale,
                  decoration: BoxDecoration(
                    color: AppColors.textPrimary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(30 * scale),
                  ),
                ),
                SizedBox(height: 20 * scale),

                // Card 3 — pink/purple
                HabitCard(
                  scale: scale,
                  description: "Har kuni eng kamida 2.5 km ga yugurish, motivatsiya - ozish. 97 kg edim.",
                  percentText: '57%',
                  percentColor: const Color(0xFFCB5B84),
                  daysText: '4d',
                  daysColor: const Color(0xFFB488DA),
                  missedText: '-1d',
                  missedColor: const Color(0xFFDA6157),
                  hasMissedDouble: true,
                  progressFillWidth: 98,
                  progressGradient: const [Color(0xFF88ADDA), Color(0xFFCB5B84)],
                  totalDays: '7 day',
                  currentDay: '3',
                  startDate: '17.12.2025',
                  endDate: '24.12.2026',
                  calendarColors: HabitMockData.card3CalendarColors,
                ),

                // Bottom padding
                SizedBox(height: 100 * scale),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ===========================
  // DATE NAVIGATION
  // ===========================
  Widget _buildDateNavRow(double scale) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildCircleNavButton(svgPath: 'assets/icons/arrow_left.svg', scale: scale),
        SizedBox(width: 4 * scale),
        Expanded(
          child: Container(
            height: 60 * scale,
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(100 * scale),
            ),
            child: Container(
              margin: EdgeInsets.all(4 * scale),
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(100 * scale),
              ),
              alignment: Alignment.center,
              child: Text(
                '21 Dekabr',
                style: GoogleFonts.inter(
                  fontSize: 22 * scale,
                  fontWeight: FontWeight.w500,
                  height: 1.193,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: 4 * scale),
        _buildCircleNavButton(svgPath: 'assets/icons/arrow_right.svg', scale: scale),
      ],
    );
  }

  Widget _buildCircleNavButton({required String svgPath, required double scale}) {
    return SizedBox(
      width: 60 * scale,
      height: 60 * scale,
      child: Stack(
        children: [
          Container(
            width: 60 * scale,
            height: 60 * scale,
            decoration: const BoxDecoration(
              color: AppColors.surface,
              shape: BoxShape.circle,
            ),
          ),
          Positioned(
            left: 4 * scale,
            top: 4 * scale,
            child: Container(
              width: 52 * scale,
              height: 52 * scale,
              decoration: const BoxDecoration(
                color: AppColors.background,
                shape: BoxShape.circle,
              ),
            ),
          ),
          Center(
            child: SvgPicture.asset(svgPath, width: 24 * scale, height: 24 * scale),
          ),
        ],
      ),
    );
  }

  // ===========================
  // HABIT CARD
  // Figma parent: column, gap:8, alignItems:center, fill width
  // Card Group 178:3030: 356×155, mode:none (absolute)
  //   - Rectangle bg: 356×155, #444 opacity 0.43, radius 22
  //   - Content Frame: x:20, y:38, w:317, h:97, column, gap:12
  //   - Date Frame: x:20, y:0 (positioned below card in group)
  // Then: weekday labels 321×16
  // Then: calendar grid (wrap, gap:1, cells 50×50)
  // ===========================
}
