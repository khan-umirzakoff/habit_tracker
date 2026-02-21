import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../api/api_client.dart';
import '../data/habit_view_mapper.dart';
import '../theme/app_colors.dart';
import '../widgets/habit_card.dart';
import 'profile_screen.dart';
import 'single_habit_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime _selectedDate = DateTime.now();
  bool _loading = true;
  String? _error;
  List<HabitViewData> _habits = const [];

  @override
  void initState() {
    super.initState();
    _loadHabits();
  }

  Future<void> _loadHabits() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final apiHabits = await ApiClient.instance.getHabits(date: _selectedDate);
      final mapped = apiHabits.map(HabitViewData.fromApi).toList();
      if (!mounted) return;
      setState(() {
        _habits = mapped;
      });
    } on ApiException catch (e) {
      if (!mounted) return;
      setState(() {
        _error = e.message;
      });
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _error = 'Serverga ulanishda xatolik';
      });
    } finally {
      if (mounted) {
        setState(() => _loading = false);
      }
    }
  }

  Future<void> _changeDate(int delta) async {
    setState(() {
      _selectedDate = _selectedDate.add(Duration(days: delta));
    });
    await _loadHabits();
  }

  void _openHabit(HabitViewData habit) {
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

  double _avgProgress() {
    if (_habits.isEmpty) return 0;
    final sum = _habits.fold<double>(0, (acc, h) {
      final numeric = double.tryParse(h.percentText.replaceAll('%', '')) ?? 0;
      return acc + numeric;
    });
    return (sum / _habits.length).clamp(0, 100);
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final scale = screenWidth / 390;
    final avg = _avgProgress();

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
                  '${avg.round()}%',
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
            _HomeProgressBar(percentage: avg / 100, scale: scale),
            SizedBox(height: 16 * scale),
            _buildBody(scale),
            SizedBox(height: 100 * scale),
          ],
        ),
      ),
    );
  }

  Widget _buildBody(double scale) {
    if (_loading && _habits.isEmpty) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 40 * scale),
        child: const CircularProgressIndicator(),
      );
    }

    if (_error != null && _habits.isEmpty) {
      return Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24 * scale),
            child: Text(
              _error!,
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                color: Colors.white70,
                fontSize: 14 * scale,
              ),
            ),
          ),
          SizedBox(height: 12 * scale),
          ElevatedButton(
            onPressed: _loadHabits,
            child: const Text('Qayta urinish'),
          ),
        ],
      );
    }

    if (_habits.isEmpty) {
      return Text(
        "Hozircha habbit yo‘q",
        style: GoogleFonts.inter(color: Colors.white70, fontSize: 15 * scale),
      );
    }

    return Column(
      children: [
        for (int i = 0; i < _habits.length; i++) ...[
          GestureDetector(
            onTap: () => _openHabit(_habits[i]),
            child: HabitCard(
              scale: scale,
              description: _habits[i].description,
              percentText: _habits[i].percentText,
              percentColor: _habits[i].percentColor,
              daysText: _habits[i].daysText,
              daysColor: _habits[i].daysColor,
              missedText: _habits[i].missedText,
              missedColor: _habits[i].missedColor,
              hasMissedDouble: _habits[i].hasMissedDouble,
              progressFillWidth: _habits[i].progressFillWidth,
              progressGradient: _habits[i].progressGradient,
              totalDays: _habits[i].totalDays,
              currentDay: _habits[i].currentDay,
              startDate: _habits[i].startDate,
              endDate: _habits[i].endDate,
              calendarColors: _habits[i].calendarColors,
            ),
          ),
          if (i < _habits.length - 1) ...[
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
          ],
        ],
      ],
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
    final safePercentage = percentage.clamp(0.0, 1.0);
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
                    width: (230 * safePercentage) * scale,
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
