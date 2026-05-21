import 'dart:ui'; // <--- WAJIB TAMBAHIN INI BUAT EFEK BLUR KACA
import 'package:flutter/material.dart';
import 'package:naventure_apk/pages/main/emergency_page.dart';
import 'package:naventure_apk/pages/main/favorite_page.dart';
import 'package:naventure_apk/pages/main/profile_page.dart';
import '../utils/theme.dart';
import 'main/home_page.dart';
import 'main/ticket_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;

  // List halaman tetep sama persis kayak punya lu
  List<Widget> get _pages => [
    const HomePage(),
    const FavoritePage(),
    TicketPage(),
    const EmergencyPage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 1. TAMBAHIN INI: Biar background gradasi alam di HomePage tembus sampai ke bawah navbar
      extendBody: true,
      backgroundColor: whiteColor,
      body: _pages[_currentIndex],

      // 2. NAVBAR DI-UPGRADE JADI FLOATING GLASSMORPHISM
      bottomNavigationBar: Container(
        margin: const EdgeInsets.only(
          left: 24,
          right: 24,
          bottom: 24,
        ), // Bikin efek ngambang
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.6), // Transparan putih
          borderRadius: BorderRadius.circular(30), // Bikin ujungnya bulat mulus
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.5), // Border ala kaca
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 20,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 12,
              sigmaY: 12,
            ), // Bumbu blur kacanya
            child: BottomNavigationBar(
              backgroundColor:
                  Colors.transparent, // Wajib transparan biar blurnya keliatan
              elevation: 0, // Ilangin bayangan bawaan navbar
              type: BottomNavigationBarType.fixed,
              currentIndex: _currentIndex,

              // 3. WARNA ICON DI-UPGRADE
              selectedItemColor: const Color(
                0xFF2E7D32,
              ), // Hijau tua seger buat icon aktif
              unselectedItemColor: greyColor.withValues(
                alpha: 0.7,
              ), // Icon gak aktif agak redup

              showSelectedLabels: false,
              showUnselectedLabels: false,
              onTap: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home_filled),
                  label: 'Beranda',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.favorite_border),
                  label: 'Favorit',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.confirmation_num_outlined),
                  label: 'Tiket',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.sos_outlined, size: 30),
                  label: 'SOS',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person_outline),
                  label: 'Profil',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
