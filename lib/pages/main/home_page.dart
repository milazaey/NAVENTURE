import 'dart:async';
import 'package:flutter/material.dart';
import '../../utils/theme.dart';
import '../../models/wisata_model.dart';
import '../../widgets/wisata_card.dart';
import 'filter_page.dart';
import 'package:geolocator/geolocator.dart';
import 'detail_page.dart';
import 'dart:ui'; // WAJIB BUAT BLUR GLASSMORPHISM

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Wisata> sliderWisata = []; // Buat slider atas (hidden gems)
  List<Wisata> nearestWisata = []; // Buat list bawah (wisata terdekat)
  bool isLocationFetched = false; // Penanda kalau GPS sukses

  late PageController _pageController;
  Timer? _timer;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    sliderWisata = List.from(mockWisata);

    _pageController = PageController(initialPage: 0, viewportFraction: 0.85);
    _startAutoSlider();
    _getSortWisataTerdekat();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _getSortWisataTerdekat() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return;

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) return;
    }

    if (permission == LocationPermission.deniedForever) return;

    Position userPosition = await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(accuracy: LocationAccuracy.high),
    );

    List<Wisata> tempList = List.from(mockWisata);
    tempList.sort((a, b) {
      double distanceToA = Geolocator.distanceBetween(
        userPosition.latitude,
        userPosition.longitude,
        a.latitude,
        a.longitude,
      );
      double distanceToB = Geolocator.distanceBetween(
        userPosition.latitude,
        userPosition.longitude,
        b.latitude,
        b.longitude,
      );
      return distanceToA.compareTo(distanceToB);
    });

    if (mounted) {
      setState(() {
        nearestWisata = tempList;
        isLocationFetched = true;
      });
    }
  }

  void _startAutoSlider() {
    _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (sliderWisata.isEmpty) return;

      if (_currentPage < sliderWisata.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }

      if (_pageController.hasClients) {
        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 1200),
          curve: Curves.easeInOutQuart,
        );
      }
    });
  }

  void _searchWisata(String query) {
    setState(() {
      if (query.isEmpty) {
        sliderWisata = List.from(mockWisata);
      } else {
        sliderWisata = mockWisata
            .where(
              (wisata) =>
                  wisata.name.toLowerCase().contains(query.toLowerCase()),
            )
            .toList();
      }
      _currentPage = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // --- 1. BACKGROUND GRADASI ALAM ---
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFE8F5E9), // Hijau mint (Vibe Daun)
              Color(0xFFF1F8E9), // Hijau kekuningan (Sinar Matahari Pagi)
              Color(0xFFE0F2F1), // Soft cyan (Vibe Air/Langit)
              Colors.white,
            ],
            stops: [0.0, 0.4, 0.7, 1.0],
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              // --- 2. ORNAMEN BULAT ALAM (Background Mesh) ---
              _buildBackgroundOrnament(
                top: -50,
                left: -50,
                size: 280,
                color: const Color(0xFF81C784),
              ),
              _buildBackgroundOrnament(
                top: 250,
                right: -120,
                size: 320,
                color: const Color(0xFF4DB6AC),
              ),
              _buildBackgroundOrnament(
                bottom: 80,
                left: -150,
                size: 350,
                color: const Color(0xFFAED581),
              ),

              // --- 3. KONTEN UTAMA ---
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
                            backgroundImage: AssetImage(
                              'assets/img/profile.jpg',
                            ),
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
                          color: Colors.white.withValues(alpha: 0.7),
                          borderRadius: BorderRadius.circular(25),
                          border: Border.all(color: Colors.white, width: 2),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.03),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                onChanged: (value) => _searchWisata(value),
                                decoration: InputDecoration.collapsed(
                                  hintText: 'Cari hidden gems..',
                                  hintStyle: interText.copyWith(
                                    color: greyColor,
                                  ),
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
                          _buildCategoryItem(
                            context,
                            Icons.eco,
                            'Agro\nwisata',
                          ),
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

                    // --- LIST WISATA (AUTO-SLIDER) ---
                    SizedBox(
                      height: 350,
                      child: sliderWisata.isEmpty
                          ? _buildEmptyState()
                          : PageView.builder(
                              controller: _pageController,
                              itemCount: sliderWisata.length,
                              onPageChanged: (index) {
                                _currentPage = index;
                              },
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(right: 16),
                                  child: WisataCard(sliderWisata[index]),
                                );
                              },
                            ),
                    ),
                    const SizedBox(height: 30),

                    // --- WISATA TERDEKAT ---
                    if (isLocationFetched) ...[
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Text(
                          'Wisata terdekat dari kamu 📍',
                          style: poppinsText.copyWith(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: blackColor,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: nearestWisata.length > 5
                              ? 5
                              : nearestWisata.length,
                          itemBuilder: (context, index) {
                            return _buildCompactWisataCard(
                              context,
                              nearestWisata[index],
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 30),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ===========================================================================
  // FUNGSI HELPER (ALAT MASAK) - GW COMPACT KAN SEMUA DI SINI BIAR GAK ERROR
  // ===========================================================================

  Widget _buildBackgroundOrnament({
    double? top,
    double? right,
    double? left,
    double? bottom,
    required double size,
    required Color color,
  }) {
    return Positioned(
      top: top,
      right: right,
      left: left,
      bottom: bottom,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(
            colors: [
              color.withValues(alpha: 0.35),
              color.withValues(alpha: 0.15),
              color.withValues(alpha: 0.0),
            ],
            stops: const [0.0, 0.5, 1.0],
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

  Widget _buildCompactWisataCard(BuildContext context, Wisata wisata) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                DetailPage(wisata), // <--- FIX: Parameter posisi, bukan named!
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.50), // card terdekat
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.4),
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
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.asset(
                      wisata.imageUrl,
                      width: 90,
                      height: 90,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          wisata.name,
                          style: poppinsText.copyWith(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: blackColor,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            Icon(
                              Icons.location_on_rounded,
                              color: Colors.redAccent.withValues(alpha: 0.8),
                              size: 16,
                            ),
                            const SizedBox(width: 4),
                            Expanded(
                              child: Text(
                                wisata.location,
                                style: interText.copyWith(
                                  fontSize: 13,
                                  color: blackColor.withValues(alpha: 0.7),
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.5),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.star_rounded,
                                    color: Colors.orange,
                                    size: 14,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    wisata.rating.toString(),
                                    style: interText.copyWith(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.orange[800],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              'Rp ${wisata.price}',
                              style: poppinsText.copyWith(
                                fontSize: 14,
                                fontWeight: FontWeight.w800,
                                color: const Color(0xFF2E7D32),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
