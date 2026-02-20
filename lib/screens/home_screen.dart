import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';
import '../widgets/habit_card.dart';
import '../data/habit_mock_data.dart';
import 'profile_screen.dart';
import 'single_habit_screen.dart';

/// Figma "1-page" — node 178:3013
/// Frame: 390×1860 (scrollable), fill: #333333
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime _selectedDate = DateTime.now();

  static final List<_HomeHabitData> _habits = [
    _HomeHabitData(
      description:
          "Har kuni eng kamida 2.5 km ga yugurish, motivatsiya - ozish. 97 kg edim.",
      percentText: '67%',
      percentColor: Color(0xFFFEBB64),
      daysText: '40d',
      daysColor: Color(0xFF9BDA88),
      missedText: '-2d',
      missedColor: Color(0xFFDA6157),
      hasMissedDouble: true,
      progressFillWidth: 120,
      progressGradient: [Color(0xFF9BDA88), Color(0xFFFF7124)],
      totalDays: '60 day',
      currentDay: '18',
      startDate: '9.11.2025',
      endDate: '9.1.2026',
      calendarColors: HabitMockData.card1CalendarColors,
    ),
    _HomeHabitData(
      description:
          "Har kuni eng kamida 2.5 km ga yugurish, motivatsiya - ozish. 97 kg edim.",
      percentText: '44%',
      percentColor: Color(0xFFD2D2D2),
      daysText: '8d',
      daysColor: Color(0xFF88ADDA),
      missedText: '0',
      missedColor: Colors.transparent,
      hasMissedDouble: false,
      progressFillWidth: 73,
      progressGradient: [Color(0xFF88ADDA), Color(0xFFD2D2D2)],
      totalDays: '20',
      currentDay: '12',
      startDate: '7.12.2025',
      endDate: '27.12.2026',
      calendarColors: HabitMockData.card2CalendarColors,
    ),
    _HomeHabitData(
      description:
          "Har kuni eng kamida 2.5 km ga yugurish, motivatsiya - ozish. 97 kg edim.",
      percentText: '57%',
      percentColor: Color(0xFFCB5B84),
      daysText: '4d',
      daysColor: Color(0xFFB488DA),
      missedText: '-1d',
      missedColor: Color(0xFFDA6157),
      hasMissedDouble: true,
      progressFillWidth: 98,
      progressGradient: [Color(0xFF88ADDA), Color(0xFFCB5B84)],
      totalDays: '7 day',
      currentDay: '3',
      startDate: '17.12.2025',
      endDate: '24.12.2026',
      calendarColors: HabitMockData.card3CalendarColors,
    ),
  ];

  void _changeDate(int delta) {
    setState(() {
      _selectedDate = _selectedDate.add(Duration(days: delta));
    });
  }

  void _openHabit(_HomeHabitData habit) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => SingleHabitScreen(
          habitName: habit.description,
          description: habit.description,
          percentText: habit.percentText,
          percentColor: habit.percentColor,
          daysText: habit.daysText,
          daysColor: habit.daysColor,
          missedText: habit.missedText,
          missedColor: habit.missedColor,
          hasMissedDouble: habit.hasMissedDouble,
          progressFillWidth: habit.progressFillWidth,
          progressGradient: habit.progressGradient,
          totalDays: habit.totalDays,
          currentDay: habit.currentDay,
          startDate: habit.startDate,
          endDate: habit.endDate,
          calendarColors: habit.calendarColors,
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    const months = [
      'Yanvar',
      'Fevral',
      'Mart',
      'Aprel',
      'May',
      'Iyun',
      'Iyul',
      'Avgust',
      'Sentabr',
      'Oktabr',
      'Noyabr',
      'Dekabr',
    ];
    return '${date.day} ${months[date.month - 1]}';
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final scale = screenWidth / 390;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).padding.top),
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
            SizedBox(height: 30 * scale),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 55 * scale),
              child: SizedBox(
                height: 60 * scale,
                child: _buildDateNavRow(scale),
              ),
            ),
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
                    '${_habits.length} Habits',
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
                  '83%',
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
            _HomeProgressBar(percentage: 0.83, scale: scale),
            SizedBox(height: 16 * scale),
            GestureDetector(
              onTap: () => _openHabit(_habits[0]),
              child: HabitCard(
                scale: scale,
                description: _habits[0].description,
                percentText: _habits[0].percentText,
                percentColor: _habits[0].percentColor,
                daysText: _habits[0].daysText,
                daysColor: _habits[0].daysColor,
                missedText: _habits[0].missedText,
                missedColor: _habits[0].missedColor,
                hasMissedDouble: _habits[0].hasMissedDouble,
                progressFillWidth: _habits[0].progressFillWidth,
                progressGradient: _habits[0].progressGradient,
                totalDays: _habits[0].totalDays,
                currentDay: _habits[0].currentDay,
                startDate: _habits[0].startDate,
                endDate: _habits[0].endDate,
                calendarColors: _habits[0].calendarColors,
              ),
            ),
            SizedBox(height: 20 * scale),
            Container(
              width: 230 * scale,
              height: 2 * scale,
              decoration: BoxDecoration(
                color: AppColors.textPrimary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(30 * scale),
              ),
            ),
            SizedBox(height: 20 * scale),
            GestureDetector(
              onTap: () => _openHabit(_habits[1]),
              child: HabitCard(
                scale: scale,
                description: _habits[1].description,
                percentText: _habits[1].percentText,
                percentColor: _habits[1].percentColor,
                daysText: _habits[1].daysText,
                daysColor: _habits[1].daysColor,
                missedText: _habits[1].missedText,
                missedColor: _habits[1].missedColor,
                hasMissedDouble: _habits[1].hasMissedDouble,
                progressFillWidth: _habits[1].progressFillWidth,
                progressGradient: _habits[1].progressGradient,
                totalDays: _habits[1].totalDays,
                currentDay: _habits[1].currentDay,
                startDate: _habits[1].startDate,
                endDate: _habits[1].endDate,
                calendarColors: _habits[1].calendarColors,
              ),
            ),
            SizedBox(height: 20 * scale),
            Container(
              width: 230 * scale,
              height: 2 * scale,
              decoration: BoxDecoration(
                color: AppColors.textPrimary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(30 * scale),
              ),
            ),
            SizedBox(height: 20 * scale),
            GestureDetector(
              onTap: () => _openHabit(_habits[2]),
              child: HabitCard(
                scale: scale,
                description: _habits[2].description,
                percentText: _habits[2].percentText,
                percentColor: _habits[2].percentColor,
                daysText: _habits[2].daysText,
                daysColor: _habits[2].daysColor,
                missedText: _habits[2].missedText,
                missedColor: _habits[2].missedColor,
                hasMissedDouble: _habits[2].hasMissedDouble,
                progressFillWidth: _habits[2].progressFillWidth,
                progressGradient: _habits[2].progressGradient,
                totalDays: _habits[2].totalDays,
                currentDay: _habits[2].currentDay,
                startDate: _habits[2].startDate,
                endDate: _habits[2].endDate,
                calendarColors: _habits[2].calendarColors,
              ),
            ),
            SizedBox(height: 100 * scale),
          ],
        ),
      ),
    );
  }

  Widget _buildDateNavRow(double scale) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildCircleNavButton(
          svgPath: 'assets/icons/arrow_left.svg',
          scale: scale,
          onTap: () => _changeDate(-1),
        ),
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
                _formatDate(_selectedDate),
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
        _buildCircleNavButton(
          svgPath: 'assets/icons/arrow_right.svg',
          scale: scale,
          onTap: () => _changeDate(1),
        ),
      ],
    );
  }

  Widget _buildCircleNavButton({
    required String svgPath,
    required double scale,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
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
              child: SvgPicture.asset(
                svgPath,
                width: 24 * scale,
                height: 24 * scale,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HomeProgressBar extends StatelessWidget {
  final double percentage;
  final double scale;

  const _HomeProgressBar({required this.percentage, required this.scale});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 230 * scale,
      height: 62 * scale,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Opacity(
            opacity: 0.8,
            child: Image.asset(
              'assets/images/home_progress_glow_v2.png',
              width: 230 * scale,
              height: 60 * scale,
              fit: BoxFit.contain,
            ),
          ),
          Positioned(
            top: 0,
            child: Container(
              width: 230 * scale,
              height: 2 * scale,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(1 * scale),
              ),
              child: Row(
                children: [
                  Container(
                    width: (230 * percentage) * scale,
                    height: 2 * scale,
                    decoration: BoxDecoration(
                      color: const Color(0xFF9BDA88),
                      borderRadius: BorderRadius.circular(1 * scale),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _HomeHabitData {
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

  const _HomeHabitData({
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
}
