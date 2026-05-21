import 'package:flutter/material.dart';
import '../../utils/theme.dart';
import '../main_page.dart';
import 'ticket_page.dart';

class SuccessPage extends StatelessWidget {
  final int totalBayar;
  final String paymentMethod;

  const SuccessPage({
    super.key,
    required this.totalBayar,
    required this.paymentMethod,
  });

  // Helper kilat buat bikin format ribuan separator (Rp 150.000) tanpa plugin eksternal
  String _formatRupiah(int number) {
    RegExp reg = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
    String Function(Match) matchFunc = (Match match) => '${match[1]}.';
    return number.toString().replaceAllMapped(reg, matchFunc);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // --- GRADASI BACKGROUND MENYEGARKAN SAMA SEPERTI HOME/FILTER ---
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFFE8F5E9), // Soft Mint Green
            Colors.white,
          ],
          stops: [0.0, 0.3],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),

                // --- 1. IKON SUKSES BERLAPIS (PREMIUM GLOW) ---
                Container(
                  width: 110,
                  height: 110,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF4CAF50).withValues(alpha: 0.2),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Container(
                      width: 85,
                      height: 85,
                      decoration: const BoxDecoration(
                        color: Color(0xFFE8F5E9),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.check_circle_rounded,
                        color: Color(0xFF2E7D32), // Hijau Alam Utama
                        size: 55,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 28),

                // --- 2. TEKS EMOSIONAL BERHASIL ---
                Text(
                  'Pembayaran Berhasil!',
                  style: poppinsText.copyWith(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: blackColor,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'E-Ticket Anda telah aktif dan diterbitkan.\nSiapkan diri Anda untuk petualangan baru!',
                  textAlign: TextAlign.center,
                  style: interText.copyWith(
                    color: greyColor.withValues(alpha: 0.8),
                    fontSize: 14,
                    height: 1.4,
                  ),
                ),

                const SizedBox(height: 36),

                // --- 3. KARTU STRUK TIKET DIGITAL PREMIUM ---
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: Colors.grey.shade100),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.04),
                        blurRadius: 16,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      _buildDetailRow('ID Booking', 'NAV-882910'),
                      _buildDetailRow('Status', 'Lunas', isStatus: true),
                      _buildDetailRow('Metode Bayar', paymentMethod),

                      // Custom Dashed Divider Biar Kaya Tiket Fisik Asli
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Row(
                          children: List.generate(
                            20,
                            (index) => Expanded(
                              child: Container(
                                color: index % 2 == 0
                                    ? Colors.transparent
                                    : Colors.grey.shade300,
                                height: 1.5,
                              ),
                            ),
                          ),
                        ),
                      ),

                      // SEKTOR TOTAL PRICE DENGAN FORMAT RP YANG BENER
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total Bayar',
                            style: interText.copyWith(
                              color: greyColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            'Rp ${_formatRupiah(totalBayar)}',
                            style: poppinsText.copyWith(
                              color: const Color(0xFF2E7D32),
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const Spacer(),

                // --- 4. TOMBOL AKSI UTAMA (ANTI UX-LOOP) ---
                SizedBox(
                  width: double.infinity,
                  height: 54,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(
                        0xFF2C2C2C,
                      ), // Dark Premium Theme
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                    onPressed: () {
                      // LOGIKA EMAS: Bersihkan seluruh tumpukan halaman checkout lama,
                      // langsung buka TicketPage sebagai halaman utama baru boi!
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const TicketPage(),
                        ),
                        (route) => false,
                      );
                    },
                    child: Text(
                      'Lihat E-Ticket',
                      style: poppinsText.copyWith(
                        color: whiteColor,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 14),

                // TOMBOL KEMBALI KEBERANDA SECARA BERSIH
                TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: greyColor,
                    padding: const EdgeInsets.symmetric(vertical: 8),
                  ),
                  onPressed: () {
                    // Bersihkan stack dan balik ke root dashboard utama
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => const MainPage()),
                      (route) => false,
                    );
                  },
                  child: Text(
                    'Kembali ke Beranda',
                    style: interText.copyWith(
                      color: const Color(0xFF2E7D32), // Hijau senada tema alam
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Fungsi Komponen Baris Detail yang Dikustomisasi Lebih Rapi
  Widget _buildDetailRow(String label, String value, {bool isStatus = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: interText.copyWith(
              color: greyColor.withValues(alpha: 0.8),
              fontSize: 13,
            ),
          ),
          Container(
            padding: isStatus
                ? const EdgeInsets.symmetric(horizontal: 10, vertical: 4)
                : EdgeInsets.zero,
            decoration: isStatus
                ? BoxDecoration(
                    color: const Color(0xFFE8F5E9),
                    borderRadius: BorderRadius.circular(8),
                  )
                : null,
            child: Text(
              value,
              style: interText.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 13,
                color: isStatus ? const Color(0xFF2E7D32) : blackColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
