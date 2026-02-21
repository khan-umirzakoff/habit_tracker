import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../api/api_client.dart';
import '../data/habit_view_mapper.dart';
import '../theme/app_colors.dart';
import '../widgets/habit_card.dart';
import 'single_habit_screen.dart';

class HistoryScreen extends StatefulWidget {
  final VoidCallback? onBack;
  final bool showBackButton;

  const HistoryScreen({super.key, this.onBack, this.showBackButton = false});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
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
      final apiHabits = await ApiClient.instance.getHabits(
        date: DateTime.now(),
      );
      if (!mounted) return;
      setState(() {
        _habits = apiHabits.map(HabitViewData.fromApi).toList();
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

  void _openHabit(HabitViewData habit) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SingleHabitScreen(
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
                  if (_loading && _habits.isEmpty)
                    const Center(child: CircularProgressIndicator()),
                  if (_error != null && _habits.isEmpty) ...[
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20 * scale),
                      child: Text(
                        _error!,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.inter(color: Colors.white70),
                      ),
                    ),
                    SizedBox(height: 12 * scale),
                    Center(
                      child: ElevatedButton(
                        onPressed: _loadHabits,
                        child: const Text('Qayta urinish'),
                      ),
                    ),
                  ],
                  if (!_loading && _error == null && _habits.isEmpty)
                    Center(
                      child: Text(
                        "Hozircha habbit yo‘q",
                        style: GoogleFonts.inter(color: Colors.white70),
                      ),
                    ),
                  for (final habit in _habits) ...[
                    GestureDetector(
                      onTap: () => _openHabit(habit),
                      child: HabitCard(
                        scale: scale,
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
                        showCalendar: false,
                      ),
                    ),
                    SizedBox(height: 20 * scale),
                  ],
                  SizedBox(height: 100 * scale),
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
          if (!widget.showBackButton) SizedBox(width: 52 * scale),
          if (widget.showBackButton)
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                if (widget.onBack != null) {
                  widget.onBack!();
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
