import 'dart:ui'; // <--- WAJIB BUAT EFEK BLUR GLASSMORPHISM
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
      // 1. BIAR GRADASI TEMBUS SAMPAI BELAKANG APPBAR
      extendBodyBehindAppBar: true,
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
        backgroundColor: Colors.transparent, // Transparan premium
        elevation: 0,
      ),
      body: Container(
        // --- 2. RACIKAN GRADASI ALAM YANG SEGER ---
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFE8F5E9), // Hijau mint
              Color(0xFFF1F8E9), // Hijau kekuningan
              Color(0xFFE0F2F1), // Soft cyan
              Colors.white,
            ],
            stops: [0.0, 0.4, 0.7, 1.0],
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              // --- 3. ORNAMEN BACKGROUND MESH ---
              _buildBackgroundOrnament(
                top: -50,
                right: -50,
                size: 280,
                color: const Color(0xFF81C784),
              ),
              _buildBackgroundOrnament(
                bottom: 80,
                left: -150,
                size: 350,
                color: const Color(0xFFAED581),
              ),

              // --- ISI KONTEN ---
              favoriteWisata.isEmpty
                  ? _buildEmptyState()
                  : ListView.builder(
                      padding: const EdgeInsets.fromLTRB(
                        24,
                        20,
                        24,
                        100,
                      ), // padding bawah dilebihin biar gak ketutup floating navbar
                      itemCount: favoriteWisata.length,
                      itemBuilder: (context, index) {
                        return _buildFavoriteCard(favoriteWisata[index]);
                      },
                    ),
            ],
          ),
        ),
      ),
    );
  }

  // --- STATE KALO KOSONG (Ikut Disesuaikan Vibe Kaca) ---
  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.5),
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white.withValues(alpha: 0.6)),
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
              color: greyColor.withValues(alpha: 0.5),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'Belum ada destinasi favorit nih boi',
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

  // --- KARTU FAVORIT (UPGRADE JADI GLASSMORPHISM) ---
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
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 12,
              sigmaY: 12,
            ), // Efek blurnya boi
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.50), // Semi transparan
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Colors.white.withValues(
                    alpha: 0.4,
                  ), // Border tipis berkilau
                  width: 1.5,
                ),
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
                    borderRadius: BorderRadius.circular(14),
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
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            const Icon(
                              Icons.location_on,
                              size: 14,
                              color: Color(0xFF2E7D32), // Hijau serasi
                            ),
                            const SizedBox(width: 4),
                            Expanded(
                              child: Text(
                                wisata.location,
                                style: interText.copyWith(
                                  color: blackColor.withValues(alpha: 0.7),
                                  fontSize: 12,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.favorite, color: Colors.redAccent),
                    onPressed: () {
                      setState(() {
                        wisata.isFavorite = false;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // --- HELPER ORNAMEN GRADIENT MESH ---
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
}
