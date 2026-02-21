class ApiDailyStatus {
  final int id;
  final int? habbitId;
  final int status;
  final DateTime? date;

  const ApiDailyStatus({
    required this.id,
    required this.habbitId,
    required this.status,
    required this.date,
  });

  factory ApiDailyStatus.fromJson(Map<String, dynamic> json) {
    return ApiDailyStatus(
      id: _readInt(json['id']) ?? 0,
      habbitId: _readInt(json['habbit']),
      status: _readInt(json['status']) ?? 0,
      date: _readDate(json['date']),
    );
  }
}

class ApiHabit {
  final int id;
  final String title;
  final int duration;
  final DateTime? fromDate;
  final DateTime? toDate;
  final double percentageCompleted;
  final int successfulDays;
  final int failedDays;
  final int halfFailedDays;
  final int remainingDays;
  final int passedDays;
  final String color;
  final String icon;
  final List<ApiDailyStatus> dailyStatuses;

  const ApiHabit({
    required this.id,
    required this.title,
    required this.duration,
    required this.fromDate,
    required this.toDate,
    required this.percentageCompleted,
    required this.successfulDays,
    required this.failedDays,
    required this.halfFailedDays,
    required this.remainingDays,
    required this.passedDays,
    required this.color,
    required this.icon,
    required this.dailyStatuses,
  });

  factory ApiHabit.fromJson(Map<String, dynamic> json) {
    final statusesRaw = json['daily_statuses'];
    final statuses = statusesRaw is List
        ? statusesRaw
              .whereType<Map<String, dynamic>>()
              .map(ApiDailyStatus.fromJson)
              .toList()
        : const <ApiDailyStatus>[];

    return ApiHabit(
      id: _readInt(json['id']) ?? 0,
      title: (json['title'] as String?)?.trim() ?? '',
      duration: _readInt(json['duration']) ?? 0,
      fromDate: _readDate(json['from_date']),
      toDate: _readDate(json['to_date']),
      percentageCompleted: _readDouble(json['percentage_is_completed']) ?? 0.0,
      successfulDays: _readInt(json['successful_days']) ?? 0,
      failedDays: _readInt(json['failed_days']) ?? 0,
      halfFailedDays: _readInt(json['half_failed_days']) ?? 0,
      remainingDays: _readInt(json['remaining_days']) ?? 0,
      passedDays: _readInt(json['passed_days']) ?? 0,
      color: (json['color'] as String?) ?? 'light-green',
      icon: (json['icon'] as String?) ?? 'work',
      dailyStatuses: statuses,
    );
  }
}

class TokenPair {
  final String access;
  final String refresh;
  final String tokenType;
  final Map<String, dynamic>? user;

  const TokenPair({
    required this.access,
    required this.refresh,
    required this.tokenType,
    required this.user,
  });

  factory TokenPair.fromJson(Map<String, dynamic> json) {
    return TokenPair(
      access: (json['access'] as String?) ?? '',
      refresh: (json['refresh'] as String?) ?? '',
      tokenType: (json['token_type'] as String?) ?? 'Bearer',
      user: json['user'] is Map<String, dynamic>
          ? json['user'] as Map<String, dynamic>
          : null,
    );
  }
}

int? _readInt(dynamic value) {
  if (value is int) return value;
  if (value is num) return value.toInt();
  if (value is String) return int.tryParse(value);
  return null;
}

double? _readDouble(dynamic value) {
  if (value is double) return value;
  if (value is num) return value.toDouble();
  if (value is String) return double.tryParse(value);
  return null;
}

DateTime? _readDate(dynamic value) {
  if (value is String && value.isNotEmpty) {
    return DateTime.tryParse(value);
  }
  return null;
}
