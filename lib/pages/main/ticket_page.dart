import 'package:flutter/material.dart';
import '../../utils/theme.dart';
import '../../models/ticket_model.dart';

class TicketPage extends StatelessWidget {
  const TicketPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Container(
        // --- BACKGROUND ALAM TETEP KONSISTEN OKE ---
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
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Text(
              'Tiket',
              style: poppinsText.copyWith(
                color: blackColor,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: true,
            bottom: TabBar(
              indicatorColor: const Color(0xFF2E7D32),
              indicatorWeight: 3,
              labelColor: const Color(0xFF2E7D32),
              unselectedLabelColor: greyColor,
              labelStyle: poppinsText.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
              tabs: const [
                Tab(text: 'Aktif'),
                Tab(text: 'Tidak Aktif'),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              _buildTicketContent(isActive: true),
              _buildTicketContent(isActive: false),
            ],
          ),
        ),
      ),
    );
  }

  // --- WRAPPER UNTUK KONTEN LIST + ORNAMEN MESH ---
  Widget _buildTicketContent({required bool isActive}) {
    return Stack(
      children: [
        _buildBackgroundOrnament(
          top: -50,
          right: -50,
          size: 280,
          color: const Color(0xFF81C784),
        ),
        _buildBackgroundOrnament(
          bottom: 100,
          left: -150,
          size: 350,
          color: const Color(0xFFAED581),
        ),
        _buildTicketList(isActive: isActive),
      ],
    );
  }

  Widget _buildTicketList({required bool isActive}) {
    List<Ticket> filteredTickets = mockTickets
        .where((ticket) => ticket.isActive == isActive)
        .toList();

    if (filteredTickets.isEmpty) {
      return Center(
        child: Text(
          'Tidak ada tiket',
          style: interText.copyWith(color: greyColor),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 100),
      itemCount: filteredTickets.length,
      itemBuilder: (context, index) {
        final ticket = filteredTickets[index];
        return _buildTicketCard(ticket);
      },
    );
  }

  // --- KARTU TIKET BARU (KLONINGAN image_72306c.png) ---
  Widget _buildTicketCard(Ticket ticket) {
    // Sesuai gambar: Aktif ijo subur, tidak aktif abu-abu mati
    Color cardColor = ticket.isActive
        ? const Color(0xFF388E3C)
        : Colors.grey.shade600;

    Color textColor = Colors.white;
    Color subTextColor = Colors.white.withValues(alpha: 0.85);

    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      height:
          195, // Tinggi ideal biar list text muat rapi gausah mencet-mencet boi
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.12),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Row(
          children: [
            // 1. KIRI: QR CODE MINIMALIS LANGSUNG MENEMPEL
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: Icon(
                Icons.qr_code_2,
                size: 85,
                color: Colors.black.withValues(
                  alpha: 0.85,
                ), // Hitam pekat kontras tinggi
              ),
            ),

            // 2. TENGAH: DETAIL INFORMASI (TEXT FULL PUTIH)
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      ticket.title,
                      style: poppinsText.copyWith(
                        color: textColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Row(
                      children: [
                        Icon(Icons.location_on, color: subTextColor, size: 12),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            ticket.location,
                            style: interText.copyWith(
                              color: subTextColor,
                              fontSize: 12,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    _buildTicketInfo(
                      'Tiket Dewasa: x${ticket.adultCount}',
                      textColor,
                    ),
                    _buildTicketInfo(
                      'Biaya Parkir (Motor): x${ticket.motorCount}',
                      textColor,
                    ),
                    _buildTicketInfo(
                      'Biaya Parkir (Mobil): x${ticket.carCount}',
                      textColor,
                    ),
                    _buildTicketInfo(
                      'Sewa tour Guide Lokal x${ticket.guideCount}',
                      textColor,
                    ),
                  ],
                ),
              ),
            ),

            // 3. JALUR TEMPAT STRUKTUR GARIS PUTUS & LUBANG POTONGAN (PUNCH HOLES)
            SizedBox(
              width: 24,
              child: Stack(
                clipBehavior:
                    Clip.none, // Biar bulatan punch hole bebas keluar batas box
                children: [
                  // Garis Putus-Putus Tengah
                  LayoutBuilder(
                    builder: (context, constraints) {
                      return Flex(
                        direction: Axis.vertical,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: List.generate(
                          (constraints.constrainHeight() / 8).floor(),
                          (index) => SizedBox(
                            width: 1.5,
                            height: 4,
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.4),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  // Lubang Guntingan Atas
                  Positioned(
                    top: -14,
                    left: -2,
                    child: Container(
                      width: 28,
                      height: 28,
                      decoration: const BoxDecoration(
                        color: Colors.white, // Lingkaran putih pemotong ijo
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  // Lubang Guntingan Bawah
                  Positioned(
                    bottom: -14,
                    left: -2,
                    child: Container(
                      width: 28,
                      height: 28,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // 4. KANAN: PDF ICON
            SizedBox(
              width: 65,
              child: Center(
                child: Icon(
                  Icons.picture_as_pdf_outlined,
                  color: textColor,
                  size: 28,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTicketInfo(String text, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 2),
      child: Text(
        text,
        style: interText.copyWith(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

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
