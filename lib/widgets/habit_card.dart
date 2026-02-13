import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math' as math;
import '../theme/app_colors.dart';

class HabitCard extends StatelessWidget {
  final double scale;
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
  final bool showCalendar;

  const HabitCard({
    super.key,
    required this.scale,
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
    this.showCalendar = true,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16 * scale),
      child: Column(
        children: [
          // === MAIN CARD (Dynamic Height) ===
          Container(
            width: 356 * scale,
            decoration: BoxDecoration(
              color: const Color(0xFF444444).withValues(alpha: 0.43),
              borderRadius: BorderRadius.circular(22 * scale),
            ),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                // 1. Date badges — x:20, y:0 (Absolute)
                Positioned(
                  left: 20 * scale,
                  top: 0,
                  child: Row(
                    children: [
                      _buildDateBadge(scale: scale, text: startDate),
                      SizedBox(width: 2 * scale),
                      _buildDateBadge(scale: scale, text: endDate),
                    ],
                  ),
                ),

                // 2. Content — Starts at y:38.
                Padding(
                  padding: EdgeInsets.fromLTRB(
                    20 * scale,
                    38 * scale,
                    19 * scale,
                    20 * scale,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Description text
                      SizedBox(
                        width: 317 * scale,
                        child: Text(
                          description,
                          style: GoogleFonts.inter(
                            fontSize: 17 * scale,
                            fontWeight: FontWeight.w500,
                            height: 1.193,
                            color: AppColors.textPrimary.withValues(alpha: 0.8),
                          ),
                        ),
                      ),
                      SizedBox(height: 12 * scale),
                      // Stats row
                      Row(
                        children: [
                          _buildStatCircle(
                            scale: scale,
                            text: percentText,
                            circleColor: percentColor,
                          ),
                          SizedBox(width: 4 * scale),
                          _buildStatCircle(
                            scale: scale,
                            text: daysText,
                            circleColor: daysColor,
                          ),
                          SizedBox(width: 4 * scale),
                          _buildStatCircle(
                            scale: scale,
                            text: missedText,
                            circleColor: missedColor,
                            hasDoubleRing: hasMissedDouble,
                          ),
                          SizedBox(width: 4 * scale),
                          _buildProgressBar(
                            scale: scale,
                            fillWidth: progressFillWidth,
                            gradient: progressGradient,
                            leftText: totalDays,
                            rightText: currentDay,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          if (showCalendar) ...[
            SizedBox(height: 8 * scale),

            // === WEEKDAY LABELS (321×16) ===
            _buildWeekdayLabels(scale),

            SizedBox(height: 8 * scale),

            // === CALENDAR GRID ===
            _buildCalendarGrid(scale, calendarColors),
          ],
        ],
      ),
    );
  }

  // ===========================
  // STAT CIRCLE (45×45)
  // ===========================
  Widget _buildStatCircle({
    required double scale,
    required String text,
    required Color circleColor,
    bool hasDoubleRing = false,
  }) {
    return SizedBox(
      width: 45 * scale,
      height: 45 * scale,
      child: Stack(
        children: [
          CustomPaint(
            size: Size(45 * scale, 45 * scale),
            painter: _StatRingPainter(
              color: circleColor,
              hasMissedSegments: hasDoubleRing,
            ),
          ),
          Center(
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: 11 * scale,
                fontWeight: FontWeight.w400,
                height: 1.193,
                color: AppColors.textPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ===========================
  // PROGRESS BAR (169×45)
  // ===========================
  Widget _buildProgressBar({
    required double scale,
    required double fillWidth,
    required List<Color> gradient,
    required String leftText,
    required String rightText,
  }) {
    return SizedBox(
      width: 169 * scale,
      height: 45 * scale,
      child: Stack(
        children: [
          // Outer track
          Container(
            width: 169 * scale,
            height: 45 * scale,
            decoration: BoxDecoration(
              color: const Color(0xFF3A3A3A),
              borderRadius: BorderRadius.circular(50 * scale),
              border: Border.all(
                color: AppColors.textPrimary.withValues(alpha: 0.1),
                width: 2 * scale,
              ),
            ),
          ),
          // Inner track
          Positioned(
            left: 10 * scale,
            top: 10 * scale,
            child: Container(
              width: 149 * scale,
              height: 25 * scale,
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(50 * scale),
              ),
            ),
          ),
          // Fill
          Positioned(
            left: 10 * scale,
            top: 10 * scale,
            child: Container(
              width: fillWidth * scale,
              height: 25 * scale,
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: gradient),
                borderRadius: BorderRadius.circular(100 * scale),
              ),
            ),
          ),
          // Left text
          Positioned(
            left: 20 * scale,
            top: 16 * scale,
            child: Text(
              leftText,
              style: GoogleFonts.inter(
                fontSize: 12 * scale,
                fontWeight: FontWeight.w600,
                height: 1.193,
                color: AppColors.textPrimary,
                shadows: [
                  Shadow(
                    offset: const Offset(0, 1),
                    blurRadius: 1,
                    color: Colors.black.withValues(alpha: 0.5),
                  ),
                ],
              ),
            ),
          ),
          // Right text
          Positioned(
            left: 138 * scale,
            top: 16 * scale,
            child: Text(
              rightText,
              style: GoogleFonts.inter(
                fontSize: 12 * scale,
                fontWeight: FontWeight.w600,
                height: 1.193,
                color: AppColors.textPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ===========================
  // DATE BADGE (70×28)
  // ===========================
  Widget _buildDateBadge({required double scale, required String text}) {
    return SizedBox(
      width: 70 * scale,
      height: 28 * scale,
      child: Stack(
        children: [
          // Badge shape
          Container(
            width: 70 * scale,
            height: 28 * scale,
            decoration: BoxDecoration(
              color: const Color(0xFF444444),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(16 * scale),
                bottomRight: Radius.circular(7 * scale),
              ),
              boxShadow: [
                BoxShadow(
                  offset: const Offset(0, 2),
                  blurRadius: 4,
                  color: Colors.black.withValues(alpha: 0.15),
                ),
              ],
            ),
          ),
          // Text centered
          Center(
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: 13 * scale,
                fontWeight: FontWeight.w400,
                height: 1.193,
                color: AppColors.textPrimary.withValues(alpha: 0.6),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ===========================
  // WEEKDAY LABELS
  // ===========================
  Widget _buildWeekdayLabels(double scale) {
    // Only M, T, W, T, F, S, S
    final days = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];
    return SizedBox(
      width: 358 * scale, // Matches parent width (approx)
      height: 16 * scale,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween, // Distribute evenly
        children: days.map((day) {
          return SizedBox(
            width: 50 * scale, // Approx cell width
            child: Center(
              child: Text(
                day,
                style: GoogleFonts.inter(
                  fontSize: 13 * scale,
                  fontWeight: FontWeight.w500,
                  height: 1.193,
                  color: AppColors.textPrimary.withValues(alpha: 0.3),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  // ===========================
  // CALENDAR GRID
  // ===========================
  Widget _buildCalendarGrid(double scale, List<Color> cellColors) {
    return SizedBox(
      width: 358 * scale,
      child: Wrap(
        spacing: 1 * scale,
        runSpacing: 1 * scale,
        alignment: WrapAlignment.start,
        children: List.generate(cellColors.length, (index) {
          return Container(
            width: 50 * scale,
            height: 50 * scale,
            decoration: BoxDecoration(
              color: cellColors[index],
              shape: BoxShape.circle, // Changed to circle
            ),
          );
        }),
      ),
    );
  }
}

// ===========================
// PAINTER for STAT RINGS
// ===========================
class _StatRingPainter extends CustomPainter {
  final Color color;
  final bool hasMissedSegments; // If true, draw 2 segments

  _StatRingPainter({required this.color, this.hasMissedSegments = false});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    // Stroke width: 15% of 45 -> 6.75
    final strokeWidth = size.width * 0.15;

    final paintBg = Paint()
      ..color = Colors.white.withValues(alpha: 0.1) // 10% opacity white bg
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    // Draw background ring
    canvas.drawCircle(center, radius - strokeWidth / 2, paintBg);

    final paintFg = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    if (hasMissedSegments) {
      // Draw 2 distinct segments for "Missed" look
      // Just an approximation based on visual: top-left and bottom-right arcs?
      // Or just a dashed look. Simple way: 2 arcs.
      // Arc 1
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius - strokeWidth / 2),
        -math.pi / 2, // Start top
        math.pi / 1.5, // Sweep
        false,
        paintFg,
      );
    } else {
      // Full ring or specific percentage?
      // For "Percent" and "Streak" usually full ring is shown colored if 100%,
      // but here it seems these rings are just colored indicators, not progress.
      // Figma shows them as full colored rings in some states, or just indicator.
      // For now, draw full ring as "indicator" of that stat color.
      canvas.drawCircle(center, radius - strokeWidth / 2, paintFg);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
