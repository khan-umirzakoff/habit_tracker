import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';
import '../widgets/habit_card.dart';

class SingleHabitScreen extends StatelessWidget {
  // Habit Name (Description) for Header
  final String habitName;

  // HabitCard Parameters
  final String description;
  final String percentText;
  final Color percentColor;
  final String daysText;
  final Color daysColor;
  final String missedText;
  final Color missedColor;
  final bool hasMissedDouble;
  final double progressFillWidth;
  final List<Color> progressGradient;
  final String totalDays;
  final String currentDay;
  final String startDate;
  final String endDate;
  final List<Color> calendarColors;

  const SingleHabitScreen({
    super.key,
    required this.habitName,
    required this.description,
    required this.percentText,
    required this.percentColor,
    required this.daysText,
    required this.daysColor,
    required this.missedText,
    required this.missedColor,
    required this.hasMissedDouble,
    required this.progressFillWidth,
    required this.progressGradient,
    required this.totalDays,
    required this.currentDay,
    required this.startDate,
    required this.endDate,
    required this.calendarColors,
  });

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
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(vertical: 20 * scale),
                child: HabitCard(
                  scale: scale,
                  description: description,
                  percentText: percentText,
                  percentColor: percentColor,
                  daysText: daysText,
                  daysColor: daysColor,
                  missedText: missedText,
                  missedColor: missedColor,
                  hasMissedDouble: hasMissedDouble,
                  progressFillWidth: progressFillWidth,
                  progressGradient: progressGradient,
                  totalDays: totalDays,
                  currentDay: currentDay,
                  startDate: startDate,
                  endDate: endDate,
                  calendarColors: calendarColors,
                  showCalendar: true, // Show calendar in details view
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
          GestureDetector(
            onTap: () => Navigator.pop(context),
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
          Expanded(
            child: Text(
              habitName,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.inter(
                fontSize: 17 * scale,
                fontWeight: FontWeight.w600,
                height: 1.193,
                color: const Color(0xFFDBD8D3),
              ),
            ),
          ),
          SizedBox(width: 16 * scale),
        ],
      ),
    );
  }
}
