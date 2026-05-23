import 'dart:ui'; // WAJIB BUAT EFEK BLUR KACA
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
  // --- 🧠 LOGIKA GOOGLE MAPS EKSTERNAL (AMAN TERSIMPAN) ---
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
    return Scaffold(
      // --- DASAR KANVAS PUTIH RESIK PREMIUM ---
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // --- 1. ORNAMEN BACKGROUND PENTOLAN MESH GLOW (SIP!) ---
          _buildBackgroundOrnament(
            top: 250,
            left: -120,
            size: 320,
            color: const Color(0xFF81C784),
          ),
          _buildBackgroundOrnament(
            bottom: 80,
            left: -150,
            size: 350,
            color: const Color(0xFFAED581),
          ),

          // --- 2. SEKTOR ISI KONTEN SCROLLABLE ---
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 25), // Bantalan struktur atas
                // --- 3. SEKTOR HERO IMAGE (FOTO UTAMA) DENGAN PEMBATAS RAUDIUS ---
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: AspectRatio(
                    aspectRatio: 3 / 3, // Rasio vertikal tinggi mirip referensi
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
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
                          // --- 4. KARTU INFORMASI TRANSPARAN DI ATAS GAMBAR (OVERLAY GLASSMORPHISM) ---
                          // Perhatiin tata letak kolom ganda (Kiri & Kanan) sesuai referensi boi!
                          Positioned(
                            bottom: 20,
                            left: 20,
                            right: 20,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: BackdropFilter(
                                filter: ImageFilter.blur(
                                  sigmaX: 16,
                                  sigmaY: 16,
                                ),
                                child: Container(
                                  padding: const EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                    // Warna semi-transparan (Glass effect)
                                    color: Colors.black.withValues(alpha: 0.45),
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                      color: Colors.white.withValues(
                                        alpha: 0.25,
                                      ), // Kilauan tipis edge
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      // KOLOM KIRI: NAMA & LOKASI
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
                                                fontSize: 19,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(height: 6),
                                            Row(
                                              children: [
                                                const Icon(
                                                  Icons.location_on,
                                                  color: Color.fromARGB(
                                                    255,
                                                    230,
                                                    230,
                                                    230,
                                                  ), // Warna ijo lokasi referensi
                                                  size: 14,
                                                ),
                                                const SizedBox(width: 4),
                                                Expanded(
                                                  child: Text(
                                                    widget.wisata.location,
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: interText.copyWith(
                                                      color: Colors.white70,
                                                      fontSize: 13,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      // KOLOM KANAN: LABEL HARGA & NILAI
                                      const SizedBox(width: 12),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            'Harga',
                                            style: interText.copyWith(
                                              color: Colors.white60,
                                              fontSize: 13,
                                            ),
                                          ),
                                          const SizedBox(height: 2),
                                          Text(
                                            'Rp ${widget.wisata.price}',
                                            style: poppinsText.copyWith(
                                              // Hijau Accent sesuai referensi total harga
                                              color: const Color.fromARGB(
                                                255,
                                                231,
                                                231,
                                                231,
                                              ),
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
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                // --- 5. SEKTOR BLOK INFORMASI DESKRIPSI (TETAP AMAN) ---
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 24,
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
                      const SizedBox(height: 16),
                      // Deretan Keripik Info (Chips)
                      Wrap(
                        spacing: 12,
                        runSpacing: 12,
                        children: [
                          // INFO 1: JARAK DARI ALUN-ALUN (BAWAAN MODEL, AMAN!)
                          _buildInfoChip(
                            Icons.directions_walk_rounded,
                            '± ${widget.wisata.distance} dari alun-alun',
                          ),
                          // INFO 2: JARAK DARI LOKASI USER (TAMBAHAN BARU!)
                          _buildInfoChip(
                            Icons.near_me_rounded,
                            '± 5 km dari lokasimu', // Nanti tinggal lu ganti pake variabel GPS
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
                      const SizedBox(height: 24),
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
                              ), // Ijo segar tema utama kita boi
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
                      const SizedBox(height: 24),
                      Text(
                        widget.wisata.description,
                        style: interText.copyWith(
                          // Warna abu gelap biar sinkron dan bersih
                          color: const Color(0xFF4F4F4F),
                          fontSize: 14,
                          height: 1.6,
                        ),
                      ),
                      const SizedBox(
                        height: 120,
                      ), // Jarak bantalan bottom sheet
                    ],
                  ),
                ),
              ],
            ),
          ),

          // --- 6. BLOK NAVIGASI TOMBOL ATAS (KEMBALI & FAVORITE) ---
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // TOMBOL KEMBALI (KLONINGAN REFERENSI!)
                  _buildCircleButton(
                    icon: Icons.arrow_back_ios_new_rounded,
                    onTap: () => Navigator.pop(context),
                  ),
                  // TOMBOL LOVE/FAVORITE (KLONINGAN REFERENSI!)
                  _buildCircleButton(
                    icon: widget.wisata.isFavorite
                        ? Icons.favorite_rounded
                        : Icons.favorite_border_rounded,
                    iconColor: widget.wisata.isFavorite
                        ? Colors.redAccent
                        : Colors.white,
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

      // --- 7. TOMBOL PESAN SEKARANG (BOTTOM SHEET PERMANEN) ---
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
              // Warna Hijau Segar Naventure
              backgroundColor: const Color(0xFF2E7D32),
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
    );
  }

  // --- HELPER ORNAMEN BACKGROUND radial glow (TETAP AMAN) ---
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
              color.withValues(alpha: 0.17), // Dipenipis biar ultra-clean boi
              color.withValues(alpha: 0.03),
              color.withValues(alpha: 0.0),
            ],
            stops: const [0.0, 0.6, 1.0],
          ),
        ),
      ),
    );
  }

  // --- HELPER INFO CHIP PREMIUM (DIPUTIHIN BIAR RESIK) ---
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
              // Warna abu gelap resik
              color: const Color(0xFF333333),
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  // --- HELPER TOMBOL LINGKARAN NAVIGASI ATAS (SINKRON REFERENSI!) ---
  Widget _buildCircleButton({
    required IconData icon,
    required VoidCallback onTap,
    Color iconColor = Colors.white, // Default icon putih sesuai referensi
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          // Hitam-abu transparan sesuai referensi tombol overlay
          color: Colors.black.withValues(alpha: 0.3),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.15),
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
