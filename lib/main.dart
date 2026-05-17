import 'package:flutter/material.dart';
import 'pages/splash_page.dart'; // Import halaman splash lo
import 'utils/theme.dart'; // Import warna & font biar sinkron
import 'dart:ui';

// 2. Bikin class custom ScrollBehavior ini
class AppScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
    PointerDeviceKind.touch,
    PointerDeviceKind.mouse,
    PointerDeviceKind.trackpad,
    PointerDeviceKind.stylus, // Tambahin ini
    PointerDeviceKind.unknown, // Tambahin ini buat jaga-jaga
  };
}

void main() {
  runApp(const NaventureApp());
}


class NaventureApp extends StatelessWidget {
  const NaventureApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Naventure',

      debugShowCheckedModeBanner:
          false, // Ngilangin label 'debug' di pojok kanan atas
      // Kita set tema dasarnya di sini
      theme: ThemeData(
        scaffoldBackgroundColor: whiteColor, // Warna dasar tiap halaman
        primaryColor: primaryColor,
        fontFamily: 'Poppins', // Font default aplikasi lo
      ),

      scrollBehavior: AppScrollBehavior(),

      // Halaman yang pertama kali dijalankan
      home: const SplashPage(),
    );
  }
}

// Ini kelas buat "maksa" Flutter biar mouse bisa dipake scroll kayak touch
class MyCustomScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
    PointerDeviceKind.touch,
    PointerDeviceKind.mouse, // <-- Ini kuncinya boi!
    PointerDeviceKind.trackpad, // Biar trackpad laptop makin licin
  };
}
