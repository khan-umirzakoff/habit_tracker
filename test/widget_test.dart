// ignore: unused_import
import 'package:flutter_test/flutter_test.dart';

import 'package:habit_tracker/main.dart';
import 'package:flutter/material.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1080, 2400); // Typical mobile size
    tester.view.devicePixelRatio = 3.0;

    await tester.pumpWidget(const HabitTrackerApp());
    await tester.pump(const Duration(seconds: 4));
    await tester.pumpAndSettle();

    // reset
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
  });
}
