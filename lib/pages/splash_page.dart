import 'package:flutter/material.dart';
import 'dart:async';
import '../utils/theme.dart';
import 'auth/login_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  Color _backgroundColor = whiteColor;
  double _textOpacity = 0.0;

  @override
  void initState() {
    super.initState();
    _startSplashAnimation();
  }

  void _startSplashAnimation() async {
    // Fase 1 ke Fase 2
    await Future.delayed(const Duration(milliseconds: 500));
    setState(() {
      _backgroundColor = primaryColor;
    });

    // Fase 2 ke Fase 3
    await Future.delayed(const Duration(milliseconds: 800));
    setState(() {
      _textOpacity = 1.0;
    });

    // Tunggu 2 detik buat user baca
    await Future.delayed(const Duration(seconds: 2));

    // Pindah ke halaman Login
    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedContainer(
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOut,
        color: _backgroundColor,
        child: Center(
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 800),
            opacity: _textOpacity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'N A V E N T U R E',
                  style: TextStyle(
                    fontFamily: 'Philosopher',
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: whiteColor,
                    letterSpacing: 2.0,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Temukan Surga Tersembunyi',
                  style: poppinsText.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: whiteColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
