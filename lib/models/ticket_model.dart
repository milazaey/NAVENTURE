class Ticket {
  final String id;
  final String title;
  final String location;
  final int adultCount;
  final int childCount;
  final int motorCount;
  final int carCount;
  final int guideCount;
  final bool isActive; // Ini penentu dia masuk tab "Aktif" atau "Tidak Aktif"

  Ticket({
    required this.id,
    required this.title,
    required this.location,
    required this.adultCount,
    required this.childCount,
    required this.motorCount,
    required this.carCount,
    required this.guideCount,
    required this.isActive,
  });
}

// Ini List penyimpanan sementara kita (Dummy Data)
List<Ticket> mockTickets = []; // Dikosongin
