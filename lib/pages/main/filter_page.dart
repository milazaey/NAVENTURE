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
  // Kita siapin list buat nampung hasil filter
  List<Wisata> displayedWisata = [];

  // List asli berdasarkan kategori (buat patokan search)
  List<Wisata> categoryWisata = [];

  @override
  void initState() {
    super.initState();
    // 1. Filter dulu berdasarkan kategori pas halaman dibuka
    categoryWisata = mockWisata.where((w) {
      // Kita cek apakah ada SALAH SATU isi di dalam list category
      // yang cocok dengan categoryName dari halaman sebelumnya
      return w.category.any(
        (cat) =>
            cat.toLowerCase() ==
            widget.categoryName.toLowerCase().replaceAll('\n', ' '),
      );
    }).toList();

    // 2. Set tampilan awal sama dengan hasil filter kategori
    displayedWisata = categoryWisata;
  }

  // --- LOGIKA SEARCH ---
  void _onSearchChanged(String query) {
    setState(() {
      if (query.isEmpty) {
        displayedWisata = categoryWisata;
      } else {
        displayedWisata = categoryWisata
            .where((w) => w.name.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  IconData _getCategoryIcon(String category) {
    switch (category.toLowerCase().trim()) {
      case 'dataran tinggi':
        return Icons.terrain;
      case 'air terjun':
        return Icons.water_drop;
      case 'situs sejarah':
        return Icons.history_edu;
      case 'agrowisata':
        return Icons.eco;
      default:
        return Icons.eco;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          _buildBackgroundOrnament(top: -50, right: -100),
          _buildBackgroundOrnament(bottom: 150, left: -130),
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // --- ONE ROW TOP BAR (Back + Logo + Search Bar) ---
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                    24,
                    20,
                    24,
                    10,
                  ), // Kasih space atas dikit biar lega boi
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // 1. Tombol Back di paling kiri boi
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 4,
                            ), // Biar center vertikal sama logo bulat
                            child: GestureDetector(
                              onTap: () => Navigator.pop(context),
                              child: CircleAvatar(
                                backgroundColor: Colors.grey.shade100,
                                child: const Icon(
                                  Icons.arrow_back_ios_new,
                                  size: 18,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),

                          // 2. Logo Kategori & Teks di bawahnya (di tengah-tengah)
                          Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 10,
                                    ),
                                  ],
                                ),
                                child: Icon(
                                  _getCategoryIcon(widget.categoryName),
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                widget.categoryName.replaceAll('\n', ' '),
                                style: interText.copyWith(
                                  color: greyColor,
                                  fontSize:
                                      12, // Dikecilin dikit biar makin proporsional
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(width: 12),

                          // 3. Search bar di paling kanan
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                top: 2,
                              ), // Biar center vertikal juga
                              child: _buildSearchBar(_onSearchChanged),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),

                      // Judul ala Prototype
                      Text(
                        'Hidden gems ${widget.categoryName.toLowerCase().replaceAll('\n', ' ')}',
                        style: poppinsText.copyWith(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: blackColor,
                        ),
                      ),
                    ],
                  ),
                ),

                // --- GRID WISATA ---
                Expanded(
                  child: displayedWisata.isEmpty
                      ? _buildEmptyState()
                      : GridView.builder(
                          padding: const EdgeInsets.fromLTRB(24, 10, 24, 24),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 16,
                                crossAxisSpacing: 16,
                                childAspectRatio: 0.75,
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
    );
  }

  // Widget Search Bar tetap utuh
  Widget _buildSearchBar(Function(String) onChanged) {
    return Container(
      height: 45,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              onChanged: onChanged,
              decoration: InputDecoration(
                hintText:
                    'Cari di ${widget.categoryName.replaceAll('\n', ' ')}...',
                hintStyle: interText.copyWith(color: greyColor, fontSize: 13),
                border: InputBorder.none,
              ),
            ),
          ),
          Icon(Icons.search, color: greyColor, size: 20),
        ],
      ),
    );
  }

  // --- REUSABLE UI COMPONENTS ---
  Widget _buildGridCard(BuildContext context, Wisata wisata) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => DetailPage(wisata)),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          image: DecorationImage(
            image: AssetImage(wisata.imageUrl),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              top: 10,
              right: 10,
              child: CircleAvatar(
                radius: 16,
                backgroundColor: Colors.black.withValues(alpha: 0.3),
                child: Icon(
                  wisata.isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: wisata.isFavorite ? Colors.red : Colors.white,
                  size: 16,
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: double.infinity,
                margin: const EdgeInsets.all(8),
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      wisata.name,
                      style: poppinsText.copyWith(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.location_on,
                              color: Colors.white,
                              size: 10,
                            ),
                            const SizedBox(width: 2),
                            Text(
                              wisata.location.split(',').last.trim(),
                              style: interText.copyWith(
                                color: Colors.white,
                                fontSize: 10,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: 10,
                            ),
                            const SizedBox(width: 2),
                            Text(
                              wisata.rating.toString(),
                              style: interText.copyWith(
                                color: Colors.white,
                                fontSize: 10,
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
          Icon(
            Icons.search_off,
            size: 60,
            color: greyColor.withValues(alpha: 0.5),
          ),
          const SizedBox(height: 10),
          Text(
            'Gak ada yang namanya gitu di sini boi.. 😢',
            style: interText.copyWith(color: greyColor),
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
  }) {
    return Positioned(
      top: top,
      right: right,
      left: left,
      bottom: bottom,
      child: Container(
        width: 300,
        height: 300,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(
            colors: [
              const Color(0xFF4CAF50).withValues(alpha: 0.2),
              const Color(0xFF4CAF50).withValues(alpha: 0),
            ],
          ),
        ),
      ),
    );
  }
}
