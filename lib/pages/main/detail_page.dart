import 'package:flutter/material.dart';
import '../../utils/theme.dart';
import '../../models/wisata_model.dart';
import 'booking_page.dart';

class DetailPage extends StatefulWidget {
  final Wisata wisata;

  const DetailPage(this.wisata, {super.key});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: Stack(
        children: [
          // --- ORNAMEN BACKGROUND (Layer Paling Bawah) ---
          // Kita taruh di area bawah gambar biar deskripsinya makin cakep
          _buildBackgroundOrnament(top: 400, left: -100),
          _buildBackgroundOrnament(bottom: 100, right: -80),

          // --- KONTEN UTAMA (Layer Atas) ---
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 30), // Spasi aman dari atas layar
                // --- 1. GAMBAR WISATA BENTUK CARD ---
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 16,
                  ),
                  child: Container(
                    width: double.infinity,
                    height: 350,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.5),
                          blurRadius: 15,
                          offset: const Offset(0, 8),
                        ),
                      ],
                      image: DecorationImage(
                        image: AssetImage(widget.wisata.imageUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Stack(
                      children: [
                        // --- Info Harga & Nama di Dalem Card ---
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            height: 80,
                            width: double.infinity,
                            margin: const EdgeInsets.all(16),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.black.withValues(alpha: 0.5),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // 1. Bungkus kolom kiri pake Expanded biar gak maruk makan tempat
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        widget.wisata.name,
                                        // 2. Kasih limit baris & ellipsis biar kalo kepanjangan jadi "..."
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: poppinsText.copyWith(
                                          color: whiteColor,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.location_on_outlined,
                                            color: whiteColor,
                                            size: 14,
                                          ),
                                          const SizedBox(width: 4),
                                          // 3. Lokasi juga bungkus pake Expanded/Flexible kalo takut overflow lagi
                                          Expanded(
                                            child: Text(
                                              widget.wisata.location,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: interText.copyWith(
                                                color: whiteColor,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Harga',
                                      style: interText.copyWith(
                                        color: whiteColor.withValues(
                                          alpha: 0.8,
                                        ),
                                        fontSize: 12,
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      'Rp ${widget.wisata.price}',
                                      style: poppinsText.copyWith(
                                        color: whiteColor,
                                        fontSize: 16,
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

                // --- 2. DESKRIPSI WISATA ---
                Padding(
                  padding: const EdgeInsets.all(24),
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
                      Row(
                        children: [
                          _buildInfoChip(
                            Icons.access_time_filled,
                            '± 1,5 jam dari alun-alun',
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          _buildInfoChip(
                            Icons.schedule,
                            widget.wisata.openHours,
                          ),
                          const SizedBox(width: 12),
                          _buildInfoChip(
                            Icons.star,
                            widget.wisata.rating.toString(),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Text(
                        widget.wisata.description, // <--- INI KUNCINYA BOI!
                        style: interText.copyWith(
                          color: greyColor,
                          fontSize: 14,
                          height: 1.6,
                        ),
                      ),
                      const SizedBox(height: 100), // Spasi buat tombol pesen
                    ],
                  ),
                ),
              ],
            ),
          ),

          // --- 3. TOMBOL BACK & FAVORITE ---
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildCircleButton(
                    icon: Icons.arrow_back_ios_new,
                    onTap: () => Navigator.pop(context),
                  ),
                  _buildCircleButton(
                    icon: widget.wisata.isFavorite
                        ? Icons.favorite
                        : Icons.favorite_border,
                    iconColor: widget.wisata.isFavorite
                        ? Colors.red
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

      // --- TOMBOL PESAN SEKARANG ---
      bottomSheet: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        color: whiteColor,
        child: SizedBox(
          width: double.infinity,
          height: 55,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF2C2C2C),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
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
                  'Pesan Sekarang',
                  style: poppinsText.copyWith(
                    color: whiteColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 8),
                const Icon(Icons.send, color: Colors.white, size: 18),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // --- FUNGSI HELPER ORNAMEN (Sama kaya di Home) ---
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
        width: 250,
        height: 250,
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

  // --- FUNGSI BANTUAN BUAT INFO CHIP ---
  Widget _buildInfoChip(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFF0F0F0),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: const Color(0xFF2C2C2C)),
          const SizedBox(width: 8),
          Text(
            label,
            style: interText.copyWith(
              fontSize: 12,
              color: const Color(0xFF2C2C2C),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  // --- FUNGSI BANTUAN BUAT TOMBOL BULET ---
  Widget _buildCircleButton({
    required IconData icon,
    required VoidCallback onTap,
    Color iconColor = Colors.white,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: CircleAvatar(
        backgroundColor: Colors.black.withValues(alpha: 0.3),
        child: Icon(icon, color: iconColor, size: 20),
      ),
    );
  }
}
