import 'package:flutter/material.dart';
import '../../utils/theme.dart';
import '../../models/ticket_model.dart';

class TicketPage extends StatelessWidget {
  const TicketPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: const Color(0xFFF8F9FA), // Latar abu-abu terang
        appBar: AppBar(
          backgroundColor: whiteColor,
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
            indicatorColor: blackColor,
            indicatorWeight: 3,
            labelColor: blackColor,
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
            // Konten Tab 1: Tiket Aktif
            _buildTicketContent(isActive: true),

            // Konten Tab 2: Tiket Tidak Aktif
            _buildTicketContent(isActive: false),
          ],
        ),
      ),
    );
  }

  // --- WRAPPER UNTUK KONTEN LIST + ORNAMEN ---
  Widget _buildTicketContent({required bool isActive}) {
    return Stack(
      children: [
        // Ornamen Background
        _buildBackgroundOrnament(top: 50, right: -100),
        _buildBackgroundOrnament(bottom: 100, left: -100),

        // List Tiketnya
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
          'Tidak ada tiket di sini',
          style: interText.copyWith(color: greyColor),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(24),
      itemCount: filteredTickets.length,
      itemBuilder: (context, index) {
        final ticket = filteredTickets[index];
        return _buildTicketCard(ticket);
      },
    );
  }

  Widget _buildTicketCard(Ticket ticket) {
    Color bgColor = ticket.isActive
        ? const Color(0xFF388E3C)
        : const Color(0xFFE0E0E0);
    Color textColor = ticket.isActive ? Colors.white : Colors.black87;
    Color subTextColor = ticket.isActive ? Colors.white70 : Colors.black54;

    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      height: 220,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      color: ticket.isActive
                          ? Colors.white
                          : Colors.grey.shade400,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      Icons.qr_code_2,
                      size: 50,
                      color: ticket.isActive
                          ? blackColor
                          : Colors.grey.shade600,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          ticket.title,
                          style: poppinsText.copyWith(
                            color: textColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.location_on,
                              color: subTextColor,
                              size: 12,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              ticket.location,
                              style: interText.copyWith(
                                color: subTextColor,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        _buildTicketInfo(
                          'Tiket Dewasa: x${ticket.adultCount}',
                          subTextColor,
                        ),
                        _buildTicketInfo(
                          'Parkir (Motor): x${ticket.motorCount}',
                          subTextColor,
                        ),
                        _buildTicketInfo(
                          'Parkir (Mobil): x${ticket.carCount}',
                          subTextColor,
                        ),
                        _buildTicketInfo(
                          'Tour Guide Lokal x${ticket.guideCount}',
                          subTextColor,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            width: 20,
            child: Stack(
              children: [
                LayoutBuilder(
                  builder: (context, constraints) {
                    return Flex(
                      direction: Axis.vertical,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(
                        (constraints.constrainHeight() / 10).floor(),
                        (index) => SizedBox(
                          width: 2,
                          height: 5,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              color: ticket.isActive
                                  ? Colors.white54
                                  : Colors.grey.shade400,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
                Positioned(
                  top: -10,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 20,
                    decoration: const BoxDecoration(
                      color: Color(0xFFF8F9FA),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                Positioned(
                  bottom: -10,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 20,
                    decoration: const BoxDecoration(
                      color: Color(0xFFF8F9FA),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 60,
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
    );
  }

  // --- FUNGSI HELPER ---
  Widget _buildTicketInfo(String text, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Text(text, style: interText.copyWith(color: color, fontSize: 11)),
    );
  }

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
        width: 280,
        height: 280,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(
            colors: [
              const Color(
                0xFF4CAF50,
              ).withValues(alpha: 0.14), // Lebih tipis biar nggak nabrak kartu
              const Color(0xFF4CAF50).withValues(alpha: 0),
            ],
          ),
        ),
      ),
    );
  }
}
