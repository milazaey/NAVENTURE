import 'package:flutter/material.dart';
import '../../utils/theme.dart';
import '../../models/wisata_model.dart';
import '../main/detail_page.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  Widget build(BuildContext context) {
    // Filter data yang cuma favorit aja
    List<Wisata> favoriteWisata = mockWisata
        .where((w) => w.isFavorite)
        .toList();

    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA), // Background cerah konsisten
      appBar: AppBar(
        title: Text(
          'Destinasi Favorit',
          style: poppinsText.copyWith(
            color: blackColor,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Stack(
        children: [
          // --- ORNAMEN BACKGROUND ---
          _buildBackgroundOrnament(top: -100, right: -100),
          _buildBackgroundOrnament(bottom: 100, left: -150),

          // --- ISI KONTEN ---
          favoriteWisata.isEmpty
              ? _buildEmptyState()
              : ListView.builder(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 20,
                  ),
                  itemCount: favoriteWisata.length,
                  itemBuilder: (context, index) {
                    return _buildFavoriteCard(favoriteWisata[index]);
                  },
                ),
        ],
      ),
    );
  }

  // --- STATE KALO KOSONG ---
  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 20,
                ),
              ],
            ),
            child: Icon(
              Icons.favorite_border,
              size: 64,
              color: greyColor.withValues(alpha: 0.3),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'Belum ada destinasi favorit nih',
            style: interText.copyWith(
              color: greyColor,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  // --- KARTU FAVORIT ---
  Widget _buildFavoriteCard(Wisata wisata) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DetailPage(wisata)),
        ).then((value) {
          setState(() {}); // Refresh list pas balik dari detail
        });
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.shade100),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                wisata.imageUrl,
                width: 85,
                height: 85,
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
                      color: blackColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on,
                        size: 14,
                        color: Colors.green,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        wisata.location,
                        style: interText.copyWith(
                          color: greyColor,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.favorite, color: Colors.red),
              onPressed: () {
                setState(() {
                  wisata.isFavorite = false;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  // --- HELPER ORNAMEN GRADIENT ---
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
              const Color(0xFF4CAF50).withValues(alpha: 0.1),
              const Color(0xFF4CAF50).withValues(alpha: 0),
            ],
          ),
        ),
      ),
    );
  }
}
