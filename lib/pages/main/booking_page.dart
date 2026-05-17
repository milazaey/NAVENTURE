import 'package:flutter/material.dart';
import '../../utils/theme.dart';
import '../../models/wisata_model.dart';
import 'success_page.dart';
import '../../models/ticket_model.dart';

class BookingPage extends StatefulWidget {
  final Wisata wisata;
  const BookingPage(this.wisata, {super.key});

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  // Logic perhitungan
  int adultCount = 0;
  int childCount = 0;
  int motorCount = 0;
  int carCount = 0;
  int guideCount = 0;

  // 2. Deklarasi variabel harga (nanti diisi di initState)
  late int adultPrice;
  late int childPrice;

  // Harga tambahan biasanya tetap, tapi bisa lo sesuaikan
  int motorPrice = 5000;
  int carPrice = 10000;
  int guidePrice = 100000;

  @override
  void initState() {
    super.initState();
    // Kita hapus titiknya dulu (kalo ada) baru diubah ke angka.
    // Kalo tulisannya "Gratis", tryParse bakal gagal dan otomatis kasih angka 0.
    adultPrice = int.tryParse(widget.wisata.price.replaceAll('.', '')) ?? 0;
    childPrice = adultPrice; // Samain harganya atau kasih logika diskon di sini
  }

  // State buat milih metode pembayaran
  String selectedPayment = 'DANA';

  int get totalHarga {
    return (adultCount * adultPrice) +
        (childCount * childPrice) +
        (motorCount * motorPrice) +
        (carCount * carPrice) +
        (guideCount * guidePrice);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(
        0xFFF8F9FA,
      ), // Biar background agak abu kayak di desain
      body: Stack(
        children: [
          // --- KONTEN UTAMA ---
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. Header Gambar & Nama Wisata
                Stack(
                  children: [
                    Container(
                      height: 300,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(widget.wisata.imageUrl),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Container(
                      height: 300,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            Colors.black.withValues(alpha: 0.6),
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 20,
                      left: 24,
                      right: 24,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.wisata.name,
                                style: poppinsText.copyWith(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: whiteColor,
                                ),
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.location_on,
                                    color: whiteColor,
                                    size: 16,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    widget.wisata.location,
                                    style: interText.copyWith(
                                      color: whiteColor,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          // Pakai adultPrice (int) buat pengecekan, bukan widget.wisata.price (String)
                          Text(
                            adultPrice == 0
                                ? 'Gratis'
                                : 'Rp ${widget.wisata.price}',
                            style: poppinsText.copyWith(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: whiteColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 2. Form Pemesanan
                      Text(
                        'Form Pemesanan',
                        style: poppinsText.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 12),
                      _buildTextField('Nama Asli'),
                      const SizedBox(height: 12),
                      _buildTextField('Nomor Telp. Aktif'),

                      const SizedBox(height: 30),

                      // 3. Pilih Tiket
                      Text(
                        'Pilih Tiket',
                        style: poppinsText.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 16),
                      _buildCounterItem(
                        'Tiket Dewasa',
                        adultPrice == 0
                            ? 'Gratis'
                            : 'Rp $adultPrice', // GANTI DI SINI
                        adultCount,
                        (val) => setState(() => adultCount = val),
                      ),
                      _buildCounterItem(
                        'Tiket Anak-anak',
                        childPrice == 0
                            ? 'Gratis'
                            : 'Rp $childPrice', // GANTI DI SINI
                        childCount,
                        (val) => setState(() => childCount = val),
                      ),
                      const SizedBox(height: 30),

                      // 4. Tambahan (Opsional)
                      Text(
                        'Tambahan (Opsional)',
                        style: poppinsText.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 16),
                      _buildCounterItem(
                        'Biaya Parkir (Motor)',
                        'Rp 5.000',
                        motorCount,
                        (val) => setState(() => motorCount = val),
                      ),
                      _buildCounterItem(
                        'Biaya Parkir (Mobil)',
                        'Rp 10.000',
                        carCount,
                        (val) => setState(() => carCount = val),
                      ),
                      _buildCounterItem(
                        'Sewa Tour Guide Lokal',
                        'Rp 100.000',
                        guideCount,
                        (val) => setState(() => guideCount = val),
                      ),

                      const SizedBox(height: 30),

                      // 5. Metode Pembayaran (BARU)
                      Text(
                        'Metode Pembayaran',
                        style: poppinsText.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 16),
                      _buildPaymentMethod(
                        'DANA',
                        Icons.account_balance_wallet,
                        Colors.blue,
                      ),
                      _buildPaymentMethod(
                        'GoPay',
                        Icons.account_balance_wallet,
                        Colors.lightBlue,
                      ),
                      _buildPaymentMethod(
                        'OVO',
                        Icons.account_balance_wallet,
                        Colors.purple,
                      ),
                      _buildPaymentMethod(
                        'BRI',
                        Icons.account_balance,
                        Colors.blue[800]!,
                      ),
                      _buildPaymentMethod(
                        'BCA',
                        Icons.account_balance,
                        Colors.blue[900]!,
                      ),
                      _buildPaymentMethod(
                        'Mandiri',
                        Icons.account_balance,
                        Colors.orange,
                      ),

                      const SizedBox(height: 30),

                      // 6. Rincian Pembayaran (BARU)
                      Text(
                        'Rincian Pembayaran',
                        style: poppinsText.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: whiteColor,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.grey.shade200),
                        ),
                        child: Column(
                          children: [
                            _buildSummaryRow(
                              'Tiket Dewasa',
                              adultCount,
                              adultPrice,
                            ),
                            _buildSummaryRow(
                              'Tiket Anak-anak',
                              childCount,
                              childPrice,
                            ),
                            _buildSummaryRow(
                              'Biaya Parkir (Motor)',
                              motorCount,
                              motorPrice,
                            ),
                            _buildSummaryRow(
                              'Biaya Parkir (Mobil)',
                              carCount,
                              carPrice,
                            ),
                            _buildSummaryRow(
                              'Sewa Tour Guide Lokal',
                              guideCount,
                              guidePrice,
                            ),
                            const Divider(height: 30, thickness: 1),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Total',
                                  style: poppinsText.copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  'Rp $totalHarga',
                                  style: poppinsText.copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(
                        height: 100,
                      ), // Spasi bawah biar konten nggak ketutup tombol
                    ],
                  ),
                ),
              ],
            ),
          ),

          // --- TOMBOL BACK & CHIP ---
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: CircleAvatar(
                      backgroundColor: Colors.black.withValues(alpha: 0.3),
                      child: const Icon(
                        Icons.arrow_back_ios_new,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: whiteColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      'Pemesanan Ticket',
                      style: interText.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color: blackColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),

      // --- TOMBOL BAYAR SEKARANG ---
      bottomSheet: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        decoration: BoxDecoration(
          color: whiteColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
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

            // booking_page.dart
            onPressed: (adultCount + childCount == 0)
                ? null // Tombol jadi abu-abu/mati kalau belum pilih tiket
                : () {
                    final tiketBaru = Ticket(
                      id: 'NAV-${DateTime.now().millisecondsSinceEpoch.toString().substring(8)}',
                      title: widget.wisata.name,
                      location: widget.wisata.location,
                      adultCount: adultCount,
                      childCount: childCount,
                      motorCount: motorCount,
                      carCount: carCount,
                      guideCount: guideCount,
                      isActive: true,
                    );
                    // Masukin tiket yang barusan dibikin ke dalam list penyimpanan!
                    mockTickets.add(tiketBaru);

                    // Kodingan pindah halamannya:
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SuccessPage(
                          // 1. Lempar total harganya
                          totalBayar: totalHarga,

                          // 2. Lempar metode pembayarannya PAKE VARIABEL
                          paymentMethod: selectedPayment,
                        ),
                      ),
                    );
                  },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Bayar Sekarang',
                  style: poppinsText.copyWith(
                    color: whiteColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(width: 10),
                const Icon(Icons.send, color: Colors.white, size: 18),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // WIDGET BANTUAN DI BAWAH SINI

  Widget _buildTextField(String hint) {
    return Container(
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: interText.copyWith(color: greyColor, fontSize: 14),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
        ),
      ),
    );
  }

  Widget _buildCounterItem(
    String title,
    String price,
    int count,
    Function(int) onChanged,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: interText.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                price,
                style: interText.copyWith(color: greyColor, fontSize: 12),
              ),
            ],
          ),
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFFF0F0F0),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                IconButton(
                  onPressed: () => count > 0 ? onChanged(count - 1) : null,
                  icon: const Icon(Icons.remove_circle_outline, size: 20),
                ),
                Text(
                  '$count',
                  style: poppinsText.copyWith(fontWeight: FontWeight.bold),
                ),
                IconButton(
                  onPressed: () => onChanged(count + 1),
                  icon: const Icon(Icons.add_circle_outline, size: 20),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Widget baru buat milih metode pembayaran
  Widget _buildPaymentMethod(String name, IconData icon, Color iconColor) {
    bool isSelected = selectedPayment == name;
    return GestureDetector(
      onTap: () => setState(() => selectedPayment = name),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? Colors.green : Colors.grey.shade300,
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            Icon(icon, color: iconColor, size: 24),
            const SizedBox(width: 12),
            Text(
              name,
              style: interText.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 14,
                color: blackColor,
              ),
            ),
            const Spacer(),
            // Lingkaran Radio Button
            Container(
              width: 18,
              height: 18,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? Colors.green : Colors.grey.shade400,
                  width: 2,
                ),
              ),
              child: isSelected
                  ? Center(
                      child: Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.green,
                        ),
                      ),
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }

  // Widget baru buat nge-print baris rincian pembayaran
  Widget _buildSummaryRow(String title, int count, int price) {
    if (count == 0) {
      return const SizedBox(); // Kalau kuantitas 0, barisnya sembunyi
    }
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '$title x$count',
            style: interText.copyWith(fontSize: 14, color: blackColor),
          ),
          Text(
            'Rp ${count * price}',
            style: interText.copyWith(
              fontWeight: FontWeight.w600,
              fontSize: 14,
              color: blackColor,
            ),
          ),
        ],
      ),
    );
  }
}
