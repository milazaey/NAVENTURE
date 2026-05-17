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

  // 1. Ganti 'final List<Widget> _pages =' jadi 'List<Widget> get _pages =>'
  // Ini bikin navbar lo selalu nge-refresh data terbaru tiap dipencet!
  List<Widget> get _pages => [
    const HomePage(),
    const FavoritePage(),
    TicketPage(), // 2. NAH INI! Hapus tulisan const dan Center()-nya! Cukup begini aja
    const EmergencyPage(),
    const ProfilePage(),
  ];

  // ... (kodingan bawahnya biarin aja)

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      // Body-nya bakal berubah-ubah sesuai index yang dipilih
      body: _pages[_currentIndex],

      // Ini Navbar Bawahnya
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: whiteColor,
        type:
            BottomNavigationBarType.fixed, // Biar icon-nya gak gerak-gerak aneh
        currentIndex: _currentIndex,
        selectedItemColor:
            blackColor, // Warna pas aktif (Sesuai desain lo: item aktif hitam tegas)
        unselectedItemColor: greyColor, // Warna pas gak aktif
        showSelectedLabels:
            false, // Sesuai desain lo, gak ada teks di bawah icon
        showUnselectedLabels: false,
        onTap: (index) {
          setState(() {
            _currentIndex = index; // Ganti halaman pas icon dipencet
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
            icon: Icon(Icons.confirmation_num_outlined), // Icon tiket sementara
            label: 'Tiket',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.sos_outlined, size: 30), // Icon SOS sementara
            label: 'SOS',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profil',
          ),
        ],
      ),
    );
  }
}
