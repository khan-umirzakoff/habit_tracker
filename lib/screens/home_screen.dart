import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';
import 'dart:math' as math;

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
                SvgPicture.asset(
                  'assets/images/checkmark_ornament.svg',
                  width: 147 * scale,
                  height: 64 * scale,
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
                _buildHabitCard(
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
                  calendarColors: _card1CalendarColors(),
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
                _buildHabitCard(
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
                  calendarColors: _card2CalendarColors(),
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
                _buildHabitCard(
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
                  calendarColors: _card3CalendarColors(),
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
  Widget _buildHabitCard({
    required double scale,
    required String description,
    required String percentText,
    required Color percentColor,
    required String daysText,
    required Color daysColor,
    required String missedText,
    required Color missedColor,
    required bool hasMissedDouble,
    required double progressFillWidth,
    required List<Color> progressGradient,
    required String totalDays,
    required String currentDay,
    required String startDate,
    required String endDate,
    required List<Color> calendarColors,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16 * scale),
      child: Column(
        children: [
          // === MAIN CARD (Dynamic Height) ===
          // Figma structure converted to responsive flutter layout:
          // Container (Background) -> Stack details
          // - Date: Absolute top-left (x:20, y:0)
          // - Content: Padding (top:38, left:20, right:19, bottom:20)
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
                // Note: We need a bit of vertical space for them so they don't get clipped if content is pushed down?
                // Actually they are overlaying the "padding" area.
                // But since they are 'top:0', they sit flush with top edge.
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
                    38 * scale, // Push content down to start below dates
                    19 * scale, // Right padding 
                    20 * scale, // Bottom padding (approx 155 - 135 = 20)
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Description text
                      SizedBox(
                        width: 317 * scale, // Ensure full width usage
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

          SizedBox(height: 8 * scale),

          // === WEEKDAY LABELS (321×16) ===
          _buildWeekdayLabels(scale),

          SizedBox(height: 8 * scale),

          // === CALENDAR GRID ===
          // Figma: row, wrap, gap:1, fill width, cells 50×50
          _buildCalendarGrid(scale, calendarColors),
        ],
      ),
    );
  }

  // ===========================
  // STAT CIRCLE (45×45)
  // Figma: bg Ellipse #FFF opacity 0.1, colored Ellipse, text centered
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
          // Stat Rings (Background + Foreground)
          // Thickness: 6.75px (15% of 45px)
          CustomPaint(
            size: Size(45 * scale, 45 * scale),
            painter: _StatRingPainter(
              color: circleColor,
              hasMissedSegments: hasDoubleRing,
            ),
          ),
          // Text
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
  // Figma: outer 169×45 #3A3A3A stroke rgba(255,255,255,0.1) 2px radius:50
  //        inner: x:10,y:10, 149×25 #333 radius:50
  //        fill: x:10,y:10, w×25 gradient radius:100
  //        leftText: x:20,y:16  rightText: x:138,y:16
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
  // Figma SVG path: flat top, bottomLeft R=16, bottomRight R=7
  //        shadow: 0 2 4 rgba(0,0,0,0.15)
  //        text: center, w400, 13px, opacity 0.6
  // ===========================
  Widget _buildDateBadge({required double scale, required String text}) {
    return SizedBox(
      width: 70 * scale,
      height: 28 * scale,
      child: Stack(
        children: [
          // Badge shape — flat top, asymmetric curved bottom
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
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 2 * scale),
              child: Opacity(
                opacity: 0.6,
                child: Text(
                  text,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.visible, // Allow slight overflow if needed, or clip
                  style: GoogleFonts.inter(
                    fontSize: 12.5 * scale, // Slightly reduced from 13 to ensure fit
                    fontWeight: FontWeight.w400,
                    height: 1.193,
                    color: AppColors.textPrimary,
                    letterSpacing: -0.3, // Tighter spacing to fit long dates
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ===========================
  // WEEKDAY LABELS (321×16)
  // Figma: absolute positions
  // ===========================
  Widget _buildWeekdayLabels(double scale) {
    final days = [
      {'text': 'Du', 'x': 0.0},
      {'text': 'Se', 'x': 52.0},
      {'text': 'Chor', 'x': 97.0},
      {'text': 'Pa', 'x': 154.0},
      {'text': 'Ju', 'x': 205.0},
      {'text': 'Sha', 'x': 252.0},
      {'text': 'Ya', 'x': 307.0},
    ];

    return SizedBox(
      width: 321 * scale,
      height: 16 * scale,
      child: Stack(
        children: days.map((day) {
          return Positioned(
            left: (day['x'] as double) * scale,
            top: 0,
            child: Opacity(
              opacity: 0.3,
              child: Text(
                day['text'] as String,
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  fontSize: 13 * scale,
                  fontWeight: FontWeight.w400,
                  height: 1.193,
                  color: AppColors.textPrimary,
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
  // Figma: row, wrap, gap:1, fill width, cells 50×50
  // ===========================
  Widget _buildCalendarGrid(double scale, List<Color> colors) {
    // Calculate cell size: 7 cells per row + 6 gaps of 1px = 356px
    // cellSize = (356 - 6) / 7 = 50
    final cellSize = 50.0 * scale;
    final gap = 1.0 * scale;

    return SizedBox(
      width: 356 * scale,
      child: Wrap(
        spacing: gap,
        runSpacing: gap,
        children: colors.map((color) {
          return Container(
            width: cellSize,
            height: cellSize,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          );
        }).toList(),
      ),
    );
  }

  // ===========================
  // CALENDAR DATA
  // Each card has 35 cells (5 rows × 7 days)
  // Colors from Figma fills
  // ===========================

  // Card 1: green/yellow/red theme
  static List<Color> _card1CalendarColors() {
    const g = Color(0xFF9BDA88); // green (completed)
    const y = Color(0xFFFEBB64); // yellow (partial)
    const r = Color(0xFFCA5555); // red (missed)
    const w = Color(0xFFFFFFFF); // white (today/future)
    const d = Color(0xFF444444); // dark (empty/past unfilled)
    return [
      d, d, d, d, d, r, d,
      g, g, g, y, g, r, d,
      g, g, g, g, g, g, d,
      g, y, g, g, g, g, d,
      g, g, w, d, d, d, d,
    ];
  }

  // Card 2: blue/grey theme
  static List<Color> _card2CalendarColors() {
    const b = Color(0xFF88ADDA); // blue
    const gr = Color(0xFFD2D2D2); // grey
    const d = Color(0xFF444444); // dark
    const w = Color(0xFFFFFFFF); // white
    return [
      d, d, d, d, d, d, d,
      d, d, d, d, d, d, d,
      b, b, b, b, gr, b, d,
      b, b, b, w, d, d, d,
      d, d, d, d, d, d, d,
    ];
  }

  // Card 3: pink/purple theme
  static List<Color> _card3CalendarColors() {
    const p = Color(0xFFCB5B84); // pink
    const pu = Color(0xFFB488DA); // purple
    const r = Color(0xFFCA5555); // red
    const d = Color(0xFF444444); // dark
    const w = Color(0xFFFFFFFF); // white
    return [
      d, d, d, d, d, d, d,
      d, d, d, d, d, d, d,
      d, d, d, d, d, d, d,
      pu, pu, r, p, w, d, d,
      d, d, d, d, d, d, d,
    ];
  }
}

/// Arc painter for stat circles
/// Painter for Stat Circles (Background Ring + Foreground Arc/Segments)
class _StatRingPainter extends CustomPainter {
  final Color color;
  final bool hasMissedSegments;

  _StatRingPainter({required this.color, this.hasMissedSegments = false});

  @override
  void paint(Canvas canvas, Size size) {
    // Thickness: 6.75px / 45px = 15%
    final strokeWidth = size.width * 0.15;
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;

    // 1. Draw Background Ring (White with 10% opacity)
    final bgPaint = Paint()
      ..color = const Color(0xFFFFFFFF).withValues(alpha: 0.1)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      // Use butt cap for the full background ring to avoid overlap artifacts if any
      ..strokeCap = StrokeCap.butt; 

    canvas.drawCircle(center, radius, bgPaint);

    // 2. Draw Foreground Arc/Segments
    if (color != Colors.transparent) {
      final fgPaint = Paint()
        ..color = color
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.round;

      if (hasMissedSegments) {
        // Missed days: two segments based on SVG analysis and visual inspection
        final rect = Rect.fromCircle(center: center, radius: radius);
        
        // Segment 1: ~2 o'clock (Top Right)
        // -45deg to -15deg
        canvas.drawArc(rect, -math.pi / 4, math.pi / 6, false, fgPaint);
        
        // Segment 2: ~5:30 o'clock (Bottom Right)
        // 1.2 rad (~70 deg) length 30 deg
        canvas.drawArc(rect, 1.2, math.pi / 6, false, fgPaint);
        
      } else {
        // Normal progress: 75% arc (gap at top-left)
        // Use 270 degrees (1.5 * pi) starting from top (12 o'clock = -pi/2)
        final rect = Rect.fromCircle(center: center, radius: radius);
        canvas.drawArc(rect, -math.pi / 2, math.pi * 1.5, false, fgPaint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
