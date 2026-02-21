import 'package:flutter/material.dart';

import '../api/api_models.dart';

class HabitViewData {
  final int id;
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

  const HabitViewData({
    required this.id,
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

  factory HabitViewData.fromApi(ApiHabit habit) {
    final primaryColor = _colorFromEnum(habit.color);
    final percent = habit.percentageCompleted.clamp(0.0, 1.0);
    final failedDays = habit.failedDays;
    final isMissed = failedDays > 0;

    final effectiveEndDate =
        habit.toDate ??
        habit.fromDate?.add(
          Duration(days: (habit.duration - 1).clamp(0, 9999)),
        );

    return HabitViewData(
      id: habit.id,
      description: habit.title.isEmpty ? 'Untitled habit' : habit.title,
      percentText: '${(percent * 100).round()}%',
      percentColor: _percentColor(primaryColor),
      daysText: '${habit.successfulDays}d',
      daysColor: primaryColor,
      missedText: isMissed
          ? '-$failedDays'
                'd'
          : '0',
      missedColor: isMissed ? const Color(0xFFDA6157) : Colors.transparent,
      hasMissedDouble: isMissed,
      progressFillWidth: (149 * percent).clamp(8, 149).toDouble(),
      progressGradient: [primaryColor, _accent(primaryColor)],
      totalDays: '${habit.duration} day',
      currentDay: '${habit.passedDays}',
      startDate: _formatDate(habit.fromDate),
      endDate: _formatDate(effectiveEndDate),
      calendarColors: _calendarColors(habit.dailyStatuses, primaryColor),
    );
  }
}

Color _colorFromEnum(String value) {
  switch (value) {
    case 'orange':
      return const Color(0xFFFEBB64);
    case 'red':
      return const Color(0xFFCA5555);
    case 'light-blue':
      return const Color(0xFF88ADDA);
    case 'light-gray':
      return const Color(0xFFD2D2D2);
    case 'purple':
      return const Color(0xFFB488DA);
    case 'pink':
      return const Color(0xFFCB5B84);
    case 'light-green':
    default:
      return const Color(0xFF9BDA88);
  }
}

Color _accent(Color color) {
  if (color == const Color(0xFF9BDA88)) return const Color(0xFFFF7124);
  if (color == const Color(0xFFFEBB64)) return const Color(0xFFFF7124);
  if (color == const Color(0xFF88ADDA)) return const Color(0xFFD2D2D2);
  if (color == const Color(0xFFD2D2D2)) return const Color(0xFF88ADDA);
  if (color == const Color(0xFFB488DA)) return const Color(0xFFCB5B84);
  if (color == const Color(0xFFCB5B84)) return const Color(0xFF88ADDA);
  return const Color(0xFFD2D2D2);
}

Color _percentColor(Color primary) {
  if (primary == const Color(0xFF9BDA88)) return const Color(0xFFFEBB64);
  if (primary == const Color(0xFF88ADDA)) return const Color(0xFFD2D2D2);
  return primary;
}

String _formatDate(DateTime? date) {
  if (date == null) return '-';
  return '${date.day}.${date.month}.${date.year}';
}

List<Color> _calendarColors(List<ApiDailyStatus> statuses, Color primary) {
  final sorted = [...statuses]
    ..sort((a, b) {
      final da = a.date ?? DateTime.fromMillisecondsSinceEpoch(0);
      final db = b.date ?? DateTime.fromMillisecondsSinceEpoch(0);
      return da.compareTo(db);
    });

  final mapped = sorted.map((status) {
    switch (status.status) {
      case 2:
        return primary;
      case 1:
        return const Color(0xFFFEBB64);
      case -1:
        return const Color(0xFFCA5555);
      case 0:
      default:
        return const Color(0xFF444444);
    }
  }).toList();

  const target = 35;
  if (mapped.length >= target) {
    return mapped.sublist(mapped.length - target);
  }
  return [
    ...mapped,
    ...List.filled(target - mapped.length, const Color(0xFF444444)),
  ];
}
