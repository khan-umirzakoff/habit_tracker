import 'package:flutter/material.dart';
import '../widgets/animated_bottom_nav_bar.dart';
import 'home_screen.dart';
import 'add_habit_screen.dart';
import 'empty_screen.dart'; // Using EmptyScreen as placeholder for Calendar for now? Or just a placeholder Container.

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const AddHabitScreen(),
    const Scaffold(body: Center(child: Text("History/Calendar"))), // Placeholder
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // We use a Stack to float the Bottom Bar over the content
    // Content should have bottom padding to avoid obstruction?
    // HomeScreen has its own scrolling mechanism.
    // The Bottom Bar is 60px height + 30px bottom margin = 90px.
    // So HomeScreen content needs ~100px bottom padding.
    // I should pass a "bottomPadding" to screens or Wrap them in Padding?
    // But HomeScreen is already built.
    // I will wrap the _screens in a container with bottom padding?
    // No, the Background extends to bottom. The padding is for CONTENT.
    // HomeScreen's content uses `SingleChildScrollView`?
    // I need to check HomeScreen.
    // For now, I'll just stack them.

    return Scaffold(
      resizeToAvoidBottomInset: false, // Standard for nav based apps
      body: Stack(
        children: [
          // Screens
          IndexedStack(
            index: _currentIndex,
            children: _screens,
          ),

          // Floating Bottom Nav Bar
          Positioned(
            left: 0,
            right: 0,
            bottom: 30, // 30px from bottom as per design (approx)
            child: Center(
              child: AnimatedBottomNavBar(
                currentIndex: _currentIndex,
                onTap: _onTabTapped,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
