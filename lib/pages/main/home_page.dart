import 'dart:async';
import 'package:flutter/material.dart';
import '../../utils/theme.dart';
import '../../models/wisata_model.dart';
import '../../widgets/wisata_card.dart';
import 'filter_page.dart';
import 'package:geolocator/geolocator.dart';
import 'detail_page.dart';
import 'dart:ui';

// ==========================================
// DUMMY MODEL BUAT BANNER UMKM SEMENTARA
// (Biar gak error kalau lu belum punya gambarnya)
// ==========================================
class UmkmBanner {
  final String title;
  final String subtitle;
  final String imageAsset;

  UmkmBanner(this.title, this.subtitle, this.imageAsset);
}

final List<UmkmBanner> umkmBanners = [
  UmkmBanner(
    'Kopi Khas Jampit',
    'Diskon 20% khusus pengguna Naventure!',
    'assets/img/kopijampit.jpg', // <-- Masukin path gambar 1 lu di sini
  ),
  UmkmBanner(
    'Oleh-oleh Tape Manis',
    'Beli 3 Kotak Gratis 1, Mampir Yuk!',
    'assets/img/tape.jpg', // <-- Gambar 2
  ),
  UmkmBanner(
    'Sewa Jeep Ijen Termurah',
    'Aman, Nyaman, dan Terpercaya.',
    'assets/img/jeep.jpg', // <-- Gambar 3
  ),
];

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Wisata> sliderWisata = [];
  List<Wisata> nearestWisata = [];
  Map<String, double> wisataDistances = {};
  bool isLocationFetched = false;

  // Controller buat Slider Wisata
  late PageController _pageController;
  Timer? _timer;
  int _currentPage = 0;

  // Controller buat Slider UMKM
  late PageController _umkmPageController;
  Timer? _umkmTimer;
  int _currentUmkmPage = 0;

  @override
  void initState() {
    super.initState();
    sliderWisata = List.from(mockWisata);

    // Wisata Card dikecilin dikit viewport-nya biar gak kegedean
    _pageController = PageController(initialPage: 0, viewportFraction: 0.82);
    _startAutoSlider();

    // UMKM Controller
    _umkmPageController = PageController(initialPage: 0, viewportFraction: 0.9);
    _startUmkmSlider();

    _getSortWisataTerdekat();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();

    _umkmTimer?.cancel();
    _umkmPageController.dispose();
    super.dispose();
  }

  // --- LOGIKA LOKASI AMAN GAK DISENTUH BOI ---
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
    Map<String, double> tempDistances = {};

    for (var wisata in tempList) {
      tempDistances[wisata.name] = Geolocator.distanceBetween(
        userPosition.latitude,
        userPosition.longitude,
        wisata.latitude,
        wisata.longitude,
      );
    }

    tempList.sort(
      (a, b) => tempDistances[a.name]!.compareTo(tempDistances[b.name]!),
    );

    if (mounted) {
      setState(() {
        nearestWisata = tempList;
        wisataDistances = tempDistances;
        isLocationFetched = true;
      });
    }
  }

  void _startAutoSlider() {
    _timer = Timer.periodic(const Duration(seconds: 4), (Timer timer) {
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

  // Auto Slider buat UMKM
  void _startUmkmSlider() {
    _umkmTimer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (umkmBanners.isEmpty) return;

      if (_currentUmkmPage < umkmBanners.length - 1) {
        _currentUmkmPage++;
      } else {
        _currentUmkmPage = 0;
      }

      if (_umkmPageController.hasClients) {
        _umkmPageController.animateToPage(
          _currentUmkmPage,
          duration: const Duration(milliseconds: 1000),
          curve: Curves.fastOutSlowIn,
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
      backgroundColor: Colors.white,
      body: Container(
        color: Colors.white,
        child: SafeArea(
          child: Stack(
            children: [
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
                      height: 310, // <-- Ukuran Card udah dikecilin di sini boi
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

                    // ==========================================
                    // --- IKLAN UMKM (SLIDER BARU DI SINI BOI) ---
                    // ==========================================
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Row(
                        children: [
                          Icon(
                            Icons.storefront,
                            color: Colors.orange[800],
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Support UMKM Lokal',
                            style: poppinsText.copyWith(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: blackColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      height: 100, // Tinggi banner
                      child: PageView.builder(
                        controller: _umkmPageController,
                        itemCount: umkmBanners.length,
                        onPageChanged: (index) {
                          _currentUmkmPage = index;
                        },
                        itemBuilder: (context, index) {
                          final banner = umkmBanners[index];
                          return Padding(
                            padding: const EdgeInsets.only(right: 16),
                            child: _buildUmkmBanner(banner),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 30),
                    // ==========================================

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
                            final wisata = nearestWisata[index];
                            final distance =
                                wisataDistances[wisata.name] ?? 0.0;

                            return _buildCompactWisataCard(
                              context,
                              wisata,
                              distance,
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
  // FUNGSI HELPER (ALAT MASAK)
  // ===========================================================================

  // Widget Banner UMKM
  Widget _buildUmkmBanner(UmkmBanner banner) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        // --- MASUKIN GAMBARNYA DI SINI BOI ---
        image: DecorationImage(
          image: AssetImage(banner.imageAsset),
          fit: BoxFit
              .cover, // Biar gambarnya otomatis menuhin container tanpa gepeng
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      // --- BUNGKUS PAKAI GRADASI HITAM TRANSPARAN BIAR TEKS TETEP KEBACA ---
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: [
              Colors.black.withValues(
                alpha: 0.85,
              ), // Kiri gelap banget buat teks
              Colors.black.withValues(alpha: 0.20), // Kanan agak transparan
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    banner.title,
                    style: poppinsText.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    banner.subtitle,
                    style: interText.copyWith(
                      color: Colors.white.withValues(alpha: 0.9),
                      fontSize: 12,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.arrow_forward_ios,
                color: Colors.white,
                size: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

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
              color.withValues(alpha: 0.17),
              color.withValues(alpha: 0.03),
              color.withValues(alpha: 0.0),
            ],
            stops: const [0.0, 0.6, 1.0],
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

  Widget _buildCompactWisataCard(
    BuildContext context,
    Wisata wisata,
    double distance,
  ) {
    String distanceStr = distance > 1000
        ? '${(distance / 1000).toStringAsFixed(1)} km'
        : '${distance.toStringAsFixed(0)} m';

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DetailPage(wisata)),
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
                color: Colors.white.withValues(alpha: 0.50),
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
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Expanded(
                              child: Wrap(
                                spacing: 8,
                                runSpacing: 6,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withValues(
                                        alpha: 0.5,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
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
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.blue.withValues(alpha: 0.1),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          Icons.directions_walk_rounded,
                                          color: Colors.blue[600],
                                          size: 14,
                                        ),
                                        const SizedBox(width: 4),
                                        Text(
                                          distanceStr,
                                          style: interText.copyWith(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.blue[700],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 8),
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
