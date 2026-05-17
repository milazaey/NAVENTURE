import 'package:flutter/material.dart';
import '../../utils/theme.dart';

class EmergencyPage extends StatelessWidget {
  const EmergencyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: const Color(0xFFFAFAFA),
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
            indicatorColor: blackColor,
            indicatorWeight: 3,
            labelColor: blackColor,
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
            // Tab 1 dengan Ornamen
            Stack(
              children: [
                _buildBackgroundOrnament(top: -50, right: -100),
                _buildLayananDaruratTab(),
              ],
            ),
            // Tab 2 dengan Ornamen
            Stack(
              children: [
                _buildBackgroundOrnament(bottom: 50, left: -100),
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
      padding: const EdgeInsets.all(24),
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
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
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: blackColor,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.red.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.phone_forwarded, color: Colors.red),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Divider(color: Colors.grey.shade200, thickness: 1.5),
              const SizedBox(height: 16),
              Text(
                'Layanan Darurat integrasi Kepolisian, Pemadam Kebakaran, Ambulans/Medis, serta Badan Penanggulangan Bencana Daerah (BPBD)',
                style: interText.copyWith(
                  color: blackColor.withValues(alpha: 0.7),
                  fontSize: 13,
                  height: 1.6,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // --- WIDGET TAB 2 ---
  Widget _buildKontakLokalTab() {
    return ListView(
      padding: const EdgeInsets.all(24),
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
    return Container(
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
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFF2C2C2C).withValues(alpha: 0.05),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.call, color: Color(0xFF2C2C2C), size: 22),
          ),
        ],
      ),
    );
  }

  // --- ORNAMEN HELPER ---
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
              const Color(0xFF4CAF50).withValues(alpha: 0.17),
              const Color(0xFF4CAF50).withValues(alpha: 0),
            ],
          ),
        ),
      ),
    );
  }
}
