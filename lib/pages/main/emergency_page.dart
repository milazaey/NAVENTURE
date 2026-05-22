import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart'; // <-- Tambahan import ini boi
import '../../utils/theme.dart';

class EmergencyPage extends StatelessWidget {
  const EmergencyPage({super.key});

  // --- FUNGSI SAKTI BUAT NGE-LINK KE TELPON ---
  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri);
    } else {
      debugPrint('Gagal nelpon ke: $phoneNumber');
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          title: Text(
            'Emergency',
            style: poppinsText.copyWith(
              color: blackColor,
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
          bottom: TabBar(
            indicatorColor: const Color(0xFF2E7D32),
            indicatorWeight: 3,
            labelColor: const Color(0xFF2E7D32),
            unselectedLabelColor: greyColor,
            labelStyle: poppinsText.copyWith(
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
            tabs: const [
              Tab(text: 'Layanan Darurat'),
              Tab(text: 'Kontak Lokal'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // Tab 1
            Stack(
              children: [
                _buildBackgroundOrnament(
                  top: -50,
                  right: -50,
                  size: 280,
                  color: const Color(0xFF81C784),
                ),
                _buildLayananDaruratTab(),
              ],
            ),
            // Tab 2
            Stack(
              children: [
                _buildBackgroundOrnament(
                  bottom: 100,
                  left: -150,
                  size: 350,
                  color: const Color(0xFFAED581),
                ),
                _buildKontakLokalTab(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // --- WIDGET TAB 1 ---
  Widget _buildLayananDaruratTab() {
    return ListView(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 100),
      children: [
        // <-- Dibungkus GestureDetector biar bisa dipencet
        GestureDetector(
          onTap: () => _makePhoneCall('112'),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.06),
                  blurRadius: 15,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '112',
                      style: poppinsText.copyWith(
                        fontSize: 44,
                        fontWeight: FontWeight.bold,
                        color: blackColor,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: Colors.red.withValues(alpha: 0.1),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.phone_forwarded,
                        color: Colors.red,
                        size: 28,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Divider(color: Colors.grey.shade100, thickness: 1.5),
                const SizedBox(height: 16),
                Text(
                  'Layanan Darurat terintegrasi Kepolisian, Pemadam Kebakaran, Ambulans/Medis, serta Badan Penanggulangan Bencana Daerah (BPBD).',
                  style: interText.copyWith(
                    color: blackColor.withValues(alpha: 0.7),
                    fontSize: 13,
                    height: 1.6,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // --- WIDGET TAB 2 ---
  Widget _buildKontakLokalTab() {
    return ListView(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 100),
      children: [
        _buildContactCard('Aris Budiman', '+6285900156734'),
        const SizedBox(height: 16),
        _buildContactCard('Bapak Surya', '+6281583727910'),
        const SizedBox(height: 16),
        _buildContactCard('Gilang Aditama', '+6285381777293'),
      ],
    );
  }

  // --- KARTU KONTAK ---
  Widget _buildContactCard(String name, String phone) {
    // <-- Dibungkus GestureDetector biar bisa dipencet
    return GestureDetector(
      onTap: () => _makePhoneCall(phone),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: poppinsText.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: blackColor,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  phone,
                  style: interText.copyWith(color: greyColor, fontSize: 13),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFF2E7D32).withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.call, color: Color(0xFF2E7D32), size: 22),
            ),
          ],
        ),
      ),
    );
  }

  // --- ORNAMEN HELPER ---
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
