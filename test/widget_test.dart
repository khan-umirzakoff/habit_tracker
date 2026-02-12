// ignore: unused_import
import 'package:flutter_test/flutter_test.dart';

import 'package:habit_tracker/main.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const HabitTrackerApp());
    await tester.pumpAndSettle();
  });
}
