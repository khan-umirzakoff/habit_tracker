import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../api/api_client.dart';
import '../theme/app_colors.dart';
import 'main_screen.dart';

/// Figma "3-page" — node 178:2433
/// Frame 2087327733: column, gap:20, w:320
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  bool _isLoading = false;

  Future<void> _openLoginDialog() async {
    final emailController = TextEditingController(text: 'admin@gmail.com');
    final passwordController = TextEditingController(text: 'qwerty@123');

    final result = await showDialog<Map<String, String>>(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF2E2E2E),
          title: const Text('Login'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: emailController,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(labelText: 'Email'),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: passwordController,
                obscureText: true,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(labelText: 'Password'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Bekor'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(context, {
                'email': emailController.text.trim(),
                'password': passwordController.text,
              }),
              child: const Text('Kirish'),
            ),
          ],
        );
      },
    );

    emailController.dispose();
    passwordController.dispose();

    if (result == null) return;
    await _login(result['email'] ?? '', result['password'] ?? '');
  }

  Future<void> _login(String email, String password) async {
    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Email va parol kiriting')));
      return;
    }

    setState(() => _isLoading = true);
    try {
      await ApiClient.instance.login(email: email, password: password);
      if (!mounted) return;
      Navigator.of(
        context,
      ).pushReplacement(MaterialPageRoute(builder: (_) => const MainScreen()));
    } on ApiException catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Login xatosi: ${e.message}')));
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Serverga ulanishda xatolik')),
      );
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final scale = screenWidth / 390;
    final horizontalPadding = 34 * scale;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 84 * scale),
              Text(
                "Take Control of Your Life",
                style: GoogleFonts.inter(
                  fontSize: 62 * scale,
                  fontWeight: FontWeight.w800,
                  height: 0.871,
                  color: AppColors.textPrimary,
                ),
              ),
              SizedBox(height: 20 * scale),
              Opacity(
                opacity: 0.8,
                child: Text(
                  "Build better routines, track progress, and stay consistent every day with simple tools that turn small actions into lasting habits.",
                  style: GoogleFonts.inter(
                    fontSize: 15 * scale,
                    fontWeight: FontWeight.w500,
                    height: 1.193,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
              SizedBox(height: 20 * scale),
              _buildGoogleButton(scale),
              SizedBox(height: 20 * scale),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGoogleButton(double scale) {
    return GestureDetector(
      onTap: _isLoading ? null : _openLoginDialog,
      child: Container(
        width: 320 * scale,
        height: 56 * scale,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16 * scale),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_isLoading)
              SizedBox(
                width: 20 * scale,
                height: 20 * scale,
                child: const CircularProgressIndicator(strokeWidth: 2),
              )
            else
              SvgPicture.asset(
                'assets/icons/google_icon.svg',
                width: 20 * scale,
                height: 20 * scale,
              ),
            SizedBox(width: 8 * scale),
            Text(
              _isLoading ? "Kirilmoqda..." : "Login qilish",
              style: GoogleFonts.inter(
                fontSize: 17 * scale,
                fontWeight: FontWeight.w500,
                height: 1.193,
                color: AppColors.surface,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
