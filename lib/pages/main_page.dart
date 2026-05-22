import 'dart:ui'; // <--- WAJIB TAMBAHIN INI BUAT EFEK BLUR KACA
import 'package:flutter/material.dart';
import 'package:naventure_apk/pages/main/emergency_page.dart';
import 'package:naventure_apk/pages/main/favorite_page.dart';
import 'package:naventure_apk/pages/main/profile_page.dart';
import '../utils/theme.dart';
import 'main/home_page.dart';
import 'main/ticket_page.dart';

class MainPage extends StatefulWidget {
  // 🔥 INI YANG DITAMBAHIN 1: Pintu masuk buat nerima request pindah tab
  final int initialIndex;

  // 🔥 INI YANG DITAMBAHIN 2: Default 0 (Home) kalau dibuka biasa
  const MainPage({super.key, this.initialIndex = 0});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  // 🔥 INI YANG DITAMBAHIN 3: Pake late biar bisa diisi pas initState
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    // 🔥 INI YANG DITAMBAHIN 4: Tangkep data index dari halaman sebelumnya
    _currentIndex = widget.initialIndex;
  }

  // List halaman tetep sama persis
  List<Widget> get _pages => [
    const HomePage(),
    const FavoritePage(),
    const TicketPage(), // Kasih const (kalau error hapus aja const-nya)
    const EmergencyPage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 1. Biar background gradasi alam di HomePage tembus sampai ke bawah navbar
      extendBody: true,
      backgroundColor: whiteColor,
      body: _pages[_currentIndex],

      // 2. NAVBAR FLOATING GLASSMORPHISM
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
              selectedItemColor: const Color.fromARGB(
                255,
                0,
                0,
                0,
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
