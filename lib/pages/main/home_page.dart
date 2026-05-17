import 'dart:async'; // <--- WAJIB: Buat fungsi Timer
import 'package:flutter/material.dart';
import '../../utils/theme.dart';
import '../../models/wisata_model.dart';
import '../../widgets/wisata_card.dart';
import 'filter_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Wisata> filteredWisata = [];

  // --- KUNCI UTAMA AUTO-SLIDE ---
  late PageController _pageController;
  Timer? _timer;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    filteredWisata = mockWisata;

    // 1. Inisialisasi controller
    // viewportFraction 0.85 biar card sebelah kelihatan dikit, makin cakep!
    _pageController = PageController(initialPage: 0, viewportFraction: 0.85);

    // 2. Pasang Timer buat geser otomatis
    _startAutoSlider();
  }

  @override
  void dispose() {
    // 3. JANGAN LUPA: Hapus timer & controller biar gak memory leak boi!
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void _startAutoSlider() {
    _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (_currentPage < filteredWisata.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0; // Balik lagi ke awal kalau udah mentok
      }

      if (_pageController.hasClients) {
        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 1200), // Kecepatan geser
          curve: Curves.easeInOutQuart, // Efek gerakan halus
        );
      }
    });
  }

  void _searchWisata(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredWisata = mockWisata;
      } else {
        filteredWisata = mockWisata
            .where(
              (wisata) =>
                  wisata.name.toLowerCase().contains(query.toLowerCase()),
            )
            .toList();
      }
      // Reset index kalau lagi nyari biar gak error
      _currentPage = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: SafeArea(
        child: Stack(
          children: [
            _buildBackgroundOrnament(top: -100, right: -100),
            _buildBackgroundOrnament(top: 300, left: -120),
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // --- HEADER ---
                  Padding(
                    padding: const EdgeInsets.all(24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Hai, Zenin',
                                  style: poppinsText.copyWith(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: blackColor,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                const Text(
                                  '👋',
                                  style: TextStyle(fontSize: 24),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Jelajahi Bondowoso',
                              style: interText.copyWith(
                                color: greyColor,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                        const CircleAvatar(
                          radius: 25,
                          backgroundImage: AssetImage('assets/img/profile.jpg'),
                        ),
                      ],
                    ),
                  ),

                  // --- SEARCH BAR ---
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Container(
                      height: 50,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: whiteColor,
                        borderRadius: BorderRadius.circular(25),
                        border: Border.all(
                          color: greyColor.withValues(alpha: 0.5),
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              onChanged: (value) => _searchWisata(value),
                              decoration: InputDecoration.collapsed(
                                hintText: 'Cari hidden gems..',
                                hintStyle: interText.copyWith(color: greyColor),
                              ),
                            ),
                          ),
                          Icon(Icons.search, color: greyColor),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),

                  // --- KATEGORI ---
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildCategoryItem(
                          context,
                          Icons.terrain,
                          'Dataran\nTinggi',
                        ),
                        _buildCategoryItem(
                          context,
                          Icons.water_drop,
                          'Air\nTerjun',
                        ),
                        _buildCategoryItem(
                          context,
                          Icons.history_edu,
                          'Situs\nSejarah',
                        ),
                        _buildCategoryItem(context, Icons.eco, 'Agro\nwisata'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),

                  // --- JUDUL REKOMENDASI ---
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Text(
                      'Rekomendasi hidden gems',
                      style: poppinsText.copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: blackColor,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // --- 5. LIST WISATA (AUTO-SLIDER) ---
                  SizedBox(
                    height: 350,
                    child: filteredWisata.isEmpty
                        ? _buildEmptyState()
                        : PageView.builder(
                            // <--- Ganti ListView jadi PageView.builder
                            controller: _pageController,
                            itemCount: filteredWisata.length,
                            onPageChanged: (index) {
                              _currentPage =
                                  index; // Update index pas user geser manual
                            },
                            itemBuilder: (context, index) {
                              // Kita bungkus pake padding biar antar card ada jarak
                              return Padding(
                                padding: const EdgeInsets.only(right: 16),
                                child: WisataCard(filteredWisata[index]),
                              );
                            },
                          ),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- (Helper-helper lo yang lain tetep sama di bawah sini) ---
  // ... _buildBackgroundOrnament, _buildEmptyState, _buildCategoryItem ...

  // ===========================================================================
  // FUNGSI HELPER (ALAT MASAK) - Ditaruh di bawah biar nggak bikin pusing
  // ===========================================================================

  // Fungsi buat bikin buletan ijo soft
  Widget _buildBackgroundOrnament({
    double? top,
    double? right,
    double? left,
    double? bottom,
  }) {
    return Positioned(
      top: top,
      right: right,
      left: left,
      bottom: bottom,
      child: Container(
        width: 300, // Ukuran buletan agak gede biar gradasinya keliatan
        height: 300,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(
            colors: [
              const Color(
                0xFF4CAF50,
              ).withValues(alpha: 0.20), // Ijo transparan banget
              const Color(
                0xFF4CAF50,
              ).withValues(alpha: 0), // Menghilang di pinggir
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Text(
        'Yah, wisatanya gak ketemu boi.. 😢',
        style: interText.copyWith(color: greyColor),
      ),
    );
  }

  Widget _buildCategoryItem(BuildContext context, IconData icon, String title) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            // Kita hapus enter (\n) nya jadi spasi biasa pas dikirim
            builder: (context) =>
                FilterPage(categoryName: title.replaceAll('\n', ' ')),
          ),
        );
      },
      child: Column(
        children: [
          Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: whiteColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: Icon(icon, color: blackColor, size: 28),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            textAlign: TextAlign.center,
            style: interText.copyWith(
              fontSize: 12,
              color: blackColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
