import 'package:flutter/material.dart';
import '../../utils/theme.dart';
import '../../models/wisata_model.dart';
import 'booking_page.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailPage extends StatefulWidget {
  final Wisata wisata;

  const DetailPage(this.wisata, {super.key});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  // --- LOGIKA EMAS: PEMICU GOOGLE MAPS EKSTERNAL (TETAP AMAN) ---
  Future<void> _openGoogleMaps(String urlString) async {
    final Uri url = Uri.parse(urlString);
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Gagal membuka peta, boi! Cek linknya lagi.'),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // --- BACKGROUND GRADASI ALAM PREMIUM ---
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFFE8F5E9), // Hijau mint super soft
            Color(0xFFF1F8E9), // Hijau kekuningan cerah
            Colors.white,
          ],
          stops: [0.0, 0.4, 1.0],
        ),
      ),
      child: Scaffold(
        backgroundColor:
            Colors.transparent, // Tembus ke gradasi kontainer utama
        body: Stack(
          children: [
            // --- ORNAMEN LAYOUT BACKGROUND REUSABLE ---
            _buildBackgroundOrnament(
              top: 350,
              left: -80,
              size: 260,
              color: const Color(0xFF81C784),
            ),
            _buildBackgroundOrnament(
              bottom: 120,
              right: -100,
              size: 300,
              color: const Color(0xFFAED581),
            ),

            // --- SEKTOR ISI KONTEN UTAMA ---
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 16,
                  ), // Spasi ideal penyeimbang struktur atas
                  // --- 1. SEKTOR FOTO UTAMA BENTUK CARD HERO ---
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 16,
                    ),
                    child: Container(
                      width: double.infinity,
                      height: 380,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(28),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.12),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ],
                        image: DecorationImage(
                          image: AssetImage(widget.wisata.imageUrl),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Stack(
                        children: [
                          // Efek bayangan gelap di bawah gambar biar teks putih terbaca jelas
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              height: 140,
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.vertical(
                                  bottom: Radius.circular(30),
                                ),
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Colors.transparent,
                                    Colors.black.withValues(alpha: 0.9),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          // Info Nama, Lokasi, dan Harga di Dalam Card Gambar
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Padding(
                              padding: const EdgeInsets.all(20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          widget.wisata.name,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: poppinsText.copyWith(
                                            color: whiteColor,
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 6),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.location_on,
                                              color:
                                                  Colors.greenAccent.shade400,
                                              size: 16,
                                            ),
                                            const SizedBox(width: 4),
                                            Expanded(
                                              child: Text(
                                                widget.wisata.location,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: interText.copyWith(
                                                  color: const Color(
                                                    0xFFE0E0E0,
                                                  ),
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        'Harga Tiket',
                                        style: interText.copyWith(
                                          color: Colors.white70,
                                          fontSize: 13,
                                        ),
                                      ),
                                      const SizedBox(height: 2),
                                      Text(
                                        'Rp ${widget.wisata.price}',
                                        style: poppinsText.copyWith(
                                          color: Colors.greenAccent.shade400,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
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
                  ),

                  // --- 2. SEKTOR BLOK INFORMASI & DESKRIPSI ---
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 8,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Tentang Wisata',
                          style: poppinsText.copyWith(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: blackColor,
                          ),
                        ),
                        const SizedBox(height: 14),
                        // Deretan Keripik Info (Chips)
                        Wrap(
                          spacing: 10,
                          runSpacing: 10,
                          children: [
                            _buildInfoChip(
                              Icons.directions_walk_rounded,
                              '± ${widget.wisata.distance} dari alun-alun',
                            ),
                            _buildInfoChip(
                              Icons.access_time_filled_rounded,
                              widget.wisata.openHours,
                            ),
                            _buildInfoChip(
                              Icons.star_rounded,
                              '${widget.wisata.rating} Rating',
                              isRating: true,
                            ),
                          ],
                        ),

                        // --- TOMBOL AKSI PETUNJUK RUTE MAPS ---
                        const SizedBox(height: 22),
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: OutlinedButton.icon(
                            style: OutlinedButton.styleFrom(
                              backgroundColor: Colors.white.withValues(
                                alpha: 0.6,
                              ),
                              side: const BorderSide(
                                color: Color(
                                  0xFF2E7D32,
                                ), // Selaras dengan tema hijau alam boi
                                width: 1.5,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                            ),
                            onPressed: () =>
                                _openGoogleMaps(widget.wisata.mapsUrl),
                            icon: const Icon(
                              Icons.map_rounded,
                              color: Color(0xFF2E7D32),
                              size: 20,
                            ),
                            label: Text(
                              'Lihat Rute Resmi di Google Maps',
                              style: poppinsText.copyWith(
                                color: const Color(0xFF2E7D32),
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),

                        // Teks Deskripsi Wisata
                        const SizedBox(height: 22),
                        Text(
                          widget.wisata.description,
                          style: interText.copyWith(
                            color: const Color(0xFF4F4F4F),
                            fontSize: 14,
                            height: 1.6,
                          ),
                        ),
                        const SizedBox(
                          height: 120,
                        ), // Jarak bantalan aman agar tidak tertutup bottom sheet
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // --- 3. BLOK NAVIGASI TOMBOL BACK & FAVORITE (DILINDUNGI SAFEAREA) ---
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildCircleButton(
                      icon: Icons.arrow_back_ios_new_rounded,
                      onTap: () => Navigator.pop(context),
                    ),
                    _buildCircleButton(
                      icon: widget.wisata.isFavorite
                          ? Icons.favorite_rounded
                          : Icons.favorite_border_rounded,
                      iconColor: widget.wisata.isFavorite
                          ? Colors.redAccent
                          : Colors.black87,
                      onTap: () {
                        setState(() {
                          widget.wisata.isFavorite = !widget.wisata.isFavorite;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),

        // --- TOMBOL PESAN SEKARANG (BOTTOM SHEET PREMIUM) ---
        bottomSheet: Container(
          padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.04),
                blurRadius: 10,
                offset: const Offset(0, -4),
              ),
            ],
          ),
          child: SizedBox(
            width: double.infinity,
            height: 54,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(
                  0xFF2E7D32,
                ), // Warna Hijau Segar Naventure
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 2,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BookingPage(widget.wisata),
                  ),
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Pesan Tiket Sekarang',
                    style: poppinsText.copyWith(
                      color: whiteColor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Icon(
                    Icons.confirmation_number_outlined,
                    color: Colors.white,
                    size: 20,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // --- HELPER ORNAMEN BACKGROUND REUSABLE ---
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
              color.withValues(alpha: 0.25),
              color.withValues(alpha: 0.08),
              color.withValues(alpha: 0.0),
            ],
            stops: const [0.0, 0.5, 1.0],
          ),
        ),
      ),
    );
  }

  // --- HELPER INFO CHIP PREMIUM ---
  Widget _buildInfoChip(IconData icon, String label, {bool isRating = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 18,
            color: isRating ? Colors.amber.shade700 : const Color(0xFF2E7D32),
          ),
          const SizedBox(width: 8),
          Text(
            label,
            style: interText.copyWith(
              fontSize: 13,
              color: const Color(0xFF333333),
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  // --- HELPER TOMBOL LINGKARAN NAVIGASI ATAS ---
  Widget _buildCircleButton({
    required IconData icon,
    required VoidCallback onTap,
    Color iconColor = Colors.black87,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 42,
        height: 42,
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.9),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.2),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Icon(icon, color: iconColor, size: 18),
      ),
    );
  }
}
