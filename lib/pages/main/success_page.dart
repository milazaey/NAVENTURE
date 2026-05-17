import 'package:flutter/material.dart';
import '../../utils/theme.dart';
import '../main_page.dart';
import 'ticket_page.dart';

class SuccessPage extends StatelessWidget {
  // 1. Variabel penangkap data (udah bener nih boi)
  final int totalBayar;
  final String paymentMethod;

  const SuccessPage({
    super.key,
    required this.totalBayar,
    required this.paymentMethod,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 1. Ikon Sukses
              Container(
                width: 100,
                height: 100,
                decoration: const BoxDecoration(
                  color: Color(0xFFE8F5E9),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check_circle,
                  color: Color(0xFF4CAF50),
                  size: 80,
                ),
              ),
              const SizedBox(height: 32),

              // 2. Teks Berhasil
              Text(
                'Pembayaran Berhasil!',
                style: poppinsText.copyWith(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: blackColor,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Tiket Anda telah berhasil dipesan.\nSilakan cek detail tiket Anda di bawah ini.',
                textAlign: TextAlign.center,
                style: interText.copyWith(color: greyColor, fontSize: 14),
              ),

              const SizedBox(height: 40),

              // 3. Kartu Detail Transaksi
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8F9FA),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: Column(
                  children: [
                    _buildDetailRow('ID Booking', 'NAV-882910'),
                    _buildDetailRow('Status', 'Lunas'),
                    // NAH INI DIA METODE PEMBAYARANNYA BOI
                    _buildDetailRow('Metode', paymentMethod),

                    const Divider(height: 30),

                    // INI BAGIAN TOTAL YANG GUE PERBAIKI
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total Bayar',
                          style: interText.copyWith(
                            color: greyColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          // Manggil variabel totalBayar di sini
                          'Rp $totalBayar',
                          style: poppinsText.copyWith(
                            color: Colors.green,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 60),

              // 4. Tombol Aksi
              SizedBox(
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
                        builder: (context) => const TicketPage(),
                      ),
                    );
                  },
                  child: Text(
                    'Lihat E-Ticket',
                    style: poppinsText.copyWith(
                      color: whiteColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const MainPage()),
                    (route) => false,
                  );
                },
                child: Text(
                  'Kembali ke Beranda',
                  style: interText.copyWith(
                    color: greyColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Fungsi bantuan buat bikin baris detail
  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: interText.copyWith(color: greyColor, fontSize: 14),
          ),
          Text(
            value,
            style: interText.copyWith(
              fontWeight: FontWeight.bold,
              color: blackColor,
            ),
          ),
        ],
      ),
    );
  }
}
