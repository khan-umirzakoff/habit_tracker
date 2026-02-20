import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';
import '../widgets/habit_card.dart';
import '../data/habit_mock_data.dart';
import 'single_habit_screen.dart';
import 'dart:math' as math;

class HistoryScreen extends StatelessWidget {
  final VoidCallback? onBack;
  final bool showBackButton;

  const HistoryScreen({super.key, this.onBack, this.showBackButton = false});

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
              child: ListView(
                padding: EdgeInsets.symmetric(vertical: 20 * scale),
                children: [
                  // Card 1
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SingleHabitScreen(
                            habitName:
                                "Har kuni eng kamida 2.5 km ga yugurish, motivatsiya - ozish. 97 kg edim.",
                            description:
                                "Har kuni eng kamida 2.5 km ga yugurish, motivatsiya - ozish. 97 kg edim.",
                            percentText: '67%',
                            percentColor: const Color(0xFFFEBB64),
                            daysText: '40d',
                            daysColor: const Color(0xFF9BDA88),
                            missedText: '-2d',
                            missedColor: const Color(0xFFDA6157),
                            hasMissedDouble: true,
                            progressFillWidth: 120,
                            progressGradient: const [
                              Color(0xFF9BDA88),
                              Color(0xFFFF7124),
                            ],
                            totalDays: '60 day',
                            currentDay: '18',
                            startDate: '9.11.2025',
                            endDate: '9.1.2026',
                            calendarColors: HabitMockData.card1CalendarColors,
                          ),
                        ),
                      );
                    },
                    child: HabitCard(
                      scale: scale,
                      description:
                          "Har kuni eng kamida 2.5 km ga yugurish, motivatsiya - ozish. 97 kg edim.",
                      percentText: '67%',
                      percentColor: const Color(0xFFFEBB64),
                      daysText: '40d',
                      daysColor: const Color(0xFF9BDA88),
                      missedText: '-2d',
                      missedColor: const Color(0xFFDA6157),
                      hasMissedDouble: true,
                      progressFillWidth: 120,
                      progressGradient: const [
                        Color(0xFF9BDA88),
                        Color(0xFFFF7124),
                      ],
                      totalDays: '60 day',
                      currentDay: '18',
                      startDate: '9.11.2025',
                      endDate: '9.1.2026',
                      calendarColors: HabitMockData.card1CalendarColors,
                      showCalendar: false,
                    ),
                  ),
                  SizedBox(height: 20 * scale),

                  // Card 2
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SingleHabitScreen(
                            habitName:
                                "Har kuni eng kamida 2.5 km ga yugurish, motivatsiya - ozish. 97 kg edim.",
                            description:
                                "Har kuni eng kamida 2.5 km ga yugurish, motivatsiya - ozish. 97 kg edim.",
                            percentText: '44%',
                            percentColor: const Color(0xFFD2D2D2),
                            daysText: '8d',
                            daysColor: const Color(0xFF88ADDA),
                            missedText: '0',
                            missedColor: Colors.transparent,
                            hasMissedDouble: false,
                            progressFillWidth: 73,
                            progressGradient: const [
                              Color(0xFF88ADDA),
                              Color(0xFFD2D2D2),
                            ],
                            totalDays: '20',
                            currentDay: '12',
                            startDate: '7.12.2025',
                            endDate: '27.12.2026',
                            calendarColors: HabitMockData.card2CalendarColors,
                          ),
                        ),
                      );
                    },
                    child: HabitCard(
                      scale: scale,
                      description:
                          "Har kuni eng kamida 2.5 km ga yugurish, motivatsiya - ozish. 97 kg edim.",
                      percentText: '44%',
                      percentColor: const Color(0xFFD2D2D2),
                      daysText: '8d',
                      daysColor: const Color(0xFF88ADDA),
                      missedText: '0',
                      missedColor: Colors.transparent,
                      hasMissedDouble: false,
                      progressFillWidth: 73,
                      progressGradient: const [
                        Color(0xFF88ADDA),
                        Color(0xFFD2D2D2),
                      ],
                      totalDays: '20',
                      currentDay: '12',
                      startDate: '7.12.2025',
                      endDate: '27.12.2026',
                      calendarColors: HabitMockData.card2CalendarColors,
                      showCalendar: false,
                    ),
                  ),
                  SizedBox(height: 20 * scale),

                  // Card 3
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SingleHabitScreen(
                            habitName:
                                "Har kuni eng kamida 2.5 km ga yugurish, motivatsiya - ozish. 97 kg edim.",
                            description:
                                "Har kuni eng kamida 2.5 km ga yugurish, motivatsiya - ozish. 97 kg edim.",
                            percentText: '57%',
                            percentColor: const Color(0xFFCB5B84),
                            daysText: '4d',
                            daysColor: const Color(0xFFB488DA),
                            missedText: '-1d',
                            missedColor: const Color(0xFFDA6157),
                            hasMissedDouble: true,
                            progressFillWidth: 98,
                            progressGradient: const [
                              Color(0xFF88ADDA),
                              Color(0xFFCB5B84),
                            ],
                            totalDays: '7 day',
                            currentDay: '3',
                            startDate: '17.12.2025',
                            endDate: '24.12.2026',
                            calendarColors: HabitMockData.card3CalendarColors,
                          ),
                        ),
                      );
                    },
                    child: HabitCard(
                      scale: scale,
                      description:
                          "Har kuni eng kamida 2.5 km ga yugurish, motivatsiya - ozish. 97 kg edim.",
                      percentText: '57%',
                      percentColor: const Color(0xFFCB5B84),
                      daysText: '4d',
                      daysColor: const Color(0xFFB488DA),
                      missedText: '-1d',
                      missedColor: const Color(0xFFDA6157),
                      hasMissedDouble: true,
                      progressFillWidth: 98,
                      progressGradient: const [
                        Color(0xFF88ADDA),
                        Color(0xFFCB5B84),
                      ],
                      totalDays: '7 day',
                      currentDay: '3',
                      startDate: '17.12.2025',
                      endDate: '24.12.2026',
                      calendarColors: HabitMockData.card3CalendarColors,
                      showCalendar: false,
                    ),
                  ),
                  SizedBox(
                    height: 100 * scale,
                  ), // Bottom padding for nav bar overlap
                ],
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
        children: [
          if (!showBackButton) SizedBox(width: 52 * scale),
          if (showBackButton)
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                if (onBack != null) {
                  onBack!();
                } else {
                  Navigator.pop(context);
                }
              },
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16 * scale),
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
          Text(
            "Barcha odatlar",
            style: GoogleFonts.inter(
              fontSize: 17 * scale,
              fontWeight: FontWeight.w600,
              height: 1.193,
              color: const Color(0xFFDBD8D3),
            ),
          ),
        ],
      ),
    );
  }
}
