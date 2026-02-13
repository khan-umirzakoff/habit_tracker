import 'package:flutter/material.dart';

class HabitMockData {
  // Card 1: green/yellow/red theme
  static List<Color> get card1CalendarColors {
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
  static List<Color> get card2CalendarColors {
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
  static List<Color> get card3CalendarColors {
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
