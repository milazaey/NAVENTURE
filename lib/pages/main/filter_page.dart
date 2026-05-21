import 'package:flutter/material.dart';
import '../../utils/theme.dart';
import '../../models/wisata_model.dart';
import '../main/detail_page.dart';

class FilterPage extends StatefulWidget {
  final String categoryName;

  const FilterPage({super.key, required this.categoryName});

  @override
  State<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  // Kontroler teks buat mantau isi input dan memicu tombol hapus otomatis
  final TextEditingController _searchController = TextEditingController();

  List<Wisata> displayedWisata = [];
  List<Wisata> categoryWisata = [];

  @override
  void initState() {
    super.initState();
    // 1. Amankan penyaringan kategori dengan pembersihan spasi & karakter newline (\n)
    final targetCategory = widget.categoryName
        .toLowerCase()
        .replaceAll('\n', ' ')
        .trim();

    categoryWisata = mockWisata.where((w) {
      return w.category.any(
        (cat) => cat.toLowerCase().trim() == targetCategory,
      );
    }).toList();

    // 2. Tampilan awal disamakan dengan cetakan kategori asal
    displayedWisata = categoryWisata;
  }

  @override
  void dispose() {
    _searchController.dispose(); // Wajib didispose biar gak bocor memorinya boi
    super.dispose();
  }

  // --- LOGIKA EMAS: PENCARIAN DI DALAM KATEGORI TERKUNCI ---
  void _onSearchChanged(String query) {
    setState(() {
      if (query.trim().isEmpty) {
        displayedWisata = categoryWisata;
      } else {
        displayedWisata = categoryWisata
            .where(
              (w) => w.name.toLowerCase().contains(query.toLowerCase().trim()),
            )
            .toList();
      }
    });
  }

  IconData _getCategoryIcon(String category) {
    switch (category.toLowerCase().trim()) {
      case 'dataran tinggi':
      case 'gunung':
        return Icons.terrain_rounded;
      case 'air terjun':
      case 'wisata air':
        return Icons.water_drop_rounded;
      case 'situs sejarah':
      case 'budaya':
        return Icons.account_balance_rounded;
      case 'agrowisata':
      case 'alam':
        return Icons.eco_rounded;
      case 'pantai':
        return Icons.beach_access_rounded;
      default:
        return Icons.explore_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    final cleanCategoryName = widget.categoryName.replaceAll('\n', ' ').trim();

    return Container(
      // --- BACKGROUND GRADASI SEGAR ---
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFFE8F5E9), // Soft Mint Hijau
            Colors.white,
          ],
          stops: [0.0, 0.25],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            // Ornamen estetik background pembentuk vibe premium
            _buildBackgroundOrnament(
              top: -40,
              right: -80,
              size: 240,
              color: const Color(0xFF81C784),
            ),
            _buildBackgroundOrnament(
              bottom: 100,
              left: -100,
              size: 280,
              color: const Color(0xFFAED581),
            ),

            SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // --- 1. KOMPONEN HEADER: ROW ATAS (BACK + SEARCH BAR) ---
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
                    child: Row(
                      children: [
                        // Tombol Back Elegan Lingkaran Putih
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Container(
                            height: 44,
                            width: 44,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.06),
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.arrow_back_ios_new_rounded,
                              size: 16,
                              color: Color(0xFF2C2C2C),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        // Search Bar Proporsional (Mengisi Sisa Row Luas)
                        Expanded(child: _buildSearchBar(cleanCategoryName)),
                      ],
                    ),
                  ),

                  // --- 2. INFORMASI BADGE KATEGORI & JUDUL HALAMAN ---
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 8,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Badge Penunjuk Kategori Aktif
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFF2E7D32), // Hijau Alam Utama
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                _getCategoryIcon(cleanCategoryName),
                                size: 14,
                                color: Colors.white,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                cleanCategoryName,
                                style: interText.copyWith(
                                  color: Colors.white,
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        // Judul Utama Pemikat Eksplorasi
                        Text(
                          'Hidden Gems Pilihan',
                          style: poppinsText.copyWith(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: blackColor,
                            height: 1.2,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // --- 3. SEKTOR UTAMA: GRID VIEW HASIL FILTER ---
                  Expanded(
                    child: displayedWisata.isEmpty
                        ? _buildEmptyState()
                        : GridView.builder(
                            padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 16,
                                  crossAxisSpacing: 14,
                                  childAspectRatio:
                                      0.74, // Aspek rasio pas buat baca teks info card
                                ),
                            itemCount: displayedWisata.length,
                            itemBuilder: (context, index) =>
                                _buildGridCard(context, displayedWisata[index]),
                          ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Bar Pencarian Reusable Premium Berfitur Tombol Hapus "X" Otomatis
  Widget _buildSearchBar(String categoryPlaceholder) {
    return Container(
      height: 46,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(Icons.search_rounded, color: greyColor, size: 20),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              controller: _searchController,
              onChanged: _onSearchChanged,
              style: interText.copyWith(color: blackColor, fontSize: 13),
              decoration: InputDecoration(
                hintText: 'Cari destinasi...',
                hintStyle: interText.copyWith(
                  color: greyColor.withValues(alpha: 0.7),
                  fontSize: 13,
                ),
                border: InputBorder.none,
                isDense: true,
              ),
            ),
          ),
          // Tombol X penghapus teks instan, muncul cuma kalau ada ketikan boi
          if (_searchController.text.isNotEmpty)
            GestureDetector(
              onTap: () {
                _searchController.clear();
                _onSearchChanged('');
              },
              child: Icon(Icons.close_rounded, color: greyColor, size: 18),
            ),
        ],
      ),
    );
  }

  // --- KARTU GRID PREMIUM DENGAN FITUR FAVORIT MANDIRI ---
  Widget _buildGridCard(BuildContext context, Wisata wisata) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => DetailPage(wisata)),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
          image: DecorationImage(
            image: AssetImage(wisata.imageUrl),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            // Layer Penutup Gradasi Gelap di Bawah Gambar Biar Teks Terbaca Jelas
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.vertical(
                    bottom: Radius.circular(24),
                  ),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withValues(alpha: 0.75),
                    ],
                  ),
                ),
              ),
            ),
            // TOMBOL FAVORIT INDEPENDEN (Sudah Diperbaiki Logikanya 🔥)
            Positioned(
              top: 12,
              right: 12,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    wisata.isFavorite = !wisata.isFavorite;
                  });
                },
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.85),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    wisata.isFavorite
                        ? Icons.favorite_rounded
                        : Icons.favorite_border_rounded,
                    color: wisata.isFavorite
                        ? Colors.redAccent
                        : const Color(0xFF2C2C2C),
                    size: 16,
                  ),
                ),
              ),
            ),
            // Blok Konten Info Wisata (Nama, Rating, Lokasi)
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      wisata.name,
                      style: poppinsText.copyWith(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Info Detail Sektor Kab/Kota Akhir
                        Expanded(
                          child: Row(
                            children: [
                              const Icon(
                                Icons.location_on_rounded,
                                color: Colors.greenAccent,
                                size: 12,
                              ),
                              const SizedBox(width: 2),
                              Expanded(
                                child: Text(
                                  wisata.location.split(',').last.trim(),
                                  style: interText.copyWith(
                                    color: const Color(0xFFE0E0E0),
                                    fontSize: 10,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 4),
                        // Nilai Rating Bintang
                        Row(
                          children: [
                            const Icon(
                              Icons.star_rounded,
                              color: Colors.amber,
                              size: 12,
                            ),
                            const SizedBox(width: 2),
                            Text(
                              wisata.rating.toString(),
                              style: interText.copyWith(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.search_off_rounded,
              size: 50,
              color: greyColor.withValues(alpha: 0.6),
            ),
          ),
          const SizedBox(height: 14),
          Text(
            'Gak ada yang namanya gitu di sini boi.. 😢',
            style: poppinsText.copyWith(
              color: const Color(0xFF4F4F4F),
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Coba ketik kata kunci destinasi lainnya',
            style: interText.copyWith(color: greyColor, fontSize: 12),
          ),
        ],
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
              color.withValues(alpha: 0.18),
              color.withValues(alpha: 0.05),
              color.withValues(alpha: 0.0),
            ],
            stops: const [0.0, 0.6, 1.0],
          ),
        ),
      ),
    );
  }
}
