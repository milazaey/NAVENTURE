import 'package:flutter/material.dart';
import 'package:naventure_apk/pages/auth/login_page.dart';
import 'package:naventure_apk/pages/main/account_security_page.dart';
import '../../utils/theme.dart';
import 'favorite_page.dart';
import 'ticket_page.dart';
import 'emergency_page.dart';
import 'dart:io'; // Tambahin ini buat baca file gambar
import 'package:image_picker/image_picker.dart'; // Tambahin ini buat galeri

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // 1. Siapkan Variabel Penampung
  String userName = 'Maki Zenin';
  String userEmail = 'zenin_makin@email.com';
  File? _imageFile; // Buat nyimpen gambar dari galeri

  // 2. Fungsi buat ngambil gambar dari galeri
  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  // 3. Fungsi buat nampilin Popup Edit Nama & Email
  void _showEditPopup() {
    TextEditingController nameController = TextEditingController(
      text: userName,
    );
    TextEditingController emailController = TextEditingController(
      text: userEmail,
    );

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Profil'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Nama'),
              ),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(labelText: 'Email'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context), // Batal
              child: const Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () {
                // Simpan perubahan dan refresh layar (setState)
                setState(() {
                  userName = nameController.text;
                  userEmail = emailController.text;
                });
                Navigator.pop(context); // Tutup popup
              },
              child: const Text('Simpan'),
            ),
          ],
        );
      },
    );
  }

  // 4. Fungsi baru buat nampilin Popup Info Lonceng/Notifikasi
  void _showNotificationPopup() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Text(
            'Notifikasi',
            style: poppinsText.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          content: Text(
            'Belum ada info terbaru',
            style: interText.copyWith(color: greyColor, fontSize: 14),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'Oke',
                style: poppinsText.copyWith(
                  color: blackColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Profil',
          style: poppinsText.copyWith(
            color: blackColor,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 20),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: IconButton(
              icon: const Icon(
                Icons.notifications_none,
                color: Colors.black,
                size: 20,
              ),
              // --- DISINI KUNCINYA BOI, KITA PANGGIL FUNGSI BARUNYA ---
              onPressed: _showNotificationPopup,
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          // --- ORNAMEN GRADIENT (KIRI ATAS & KANAN BAWAH) ---
          _buildBackgroundOrnament(top: -50, left: -100),
          _buildBackgroundOrnament(bottom: 0, right: -120),

          // --- KONTEN UTAMA ---
          ListView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            children: [
              // 1. FOTO PROFIL & NAMA
              Center(
                child: Column(
                  children: [
                    Stack(
                      children: [
                        // --- BAGIAN FOTO ---
                        GestureDetector(
                          onTap: _pickImage, // Kalo foto diklik, buka galeri
                          child: Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              // Cek apakah ada file gambar baru? Kalo gak ada, pake asset bawaan
                              image: DecorationImage(
                                image: _imageFile != null
                                    ? FileImage(_imageFile!)
                                          as ImageProvider // <--- Pake foto dari galeri (File)
                                    : const AssetImage(
                                        'assets/img/profile.jpg',
                                      ), // <--- Pake foto bawaan (Asset)
                                fit: BoxFit.cover,
                              ),
                              border: Border.all(color: Colors.white, width: 3),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.1),
                                  blurRadius: 10,
                                  offset: const Offset(0, 5),
                                ),
                              ],
                            ),
                          ),
                        ),

                        // --- BAGIAN ICON PENSIL ---
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: GestureDetector(
                            onTap:
                                _showEditPopup, // Kalo pensil diklik, buka popup edit nama/email
                            child: Container(
                              padding: const EdgeInsets.all(6),
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.edit,
                                size: 14,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // --- NAMA (Pake Variabel) ---
                    Text(
                      userName,
                      style: poppinsText.copyWith(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: blackColor,
                      ),
                    ),
                    const SizedBox(height: 4),

                    // --- EMAIL (Pake Variabel) ---
                    Text(
                      userEmail,
                      style: interText.copyWith(fontSize: 14, color: greyColor),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),

              // 2. MENU LIST
              _buildMenuItem(
                icon: Icons.favorite_border,
                title: 'Favorit',
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const FavoritePage()),
                ),
              ),
              const SizedBox(height: 12),
              _buildMenuItem(
                icon: Icons.confirmation_number_outlined,
                title: 'Tiket',
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const TicketPage()),
                ),
              ),
              const SizedBox(height: 12),
              _buildMenuItem(
                icon: Icons.settings_outlined,
                title: 'Pengaturan Akun & Keamanan',
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AccountSecurityPage(),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              _buildMenuItem(
                icon: Icons.help_outline,
                title: 'Layanan Darurat',
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const EmergencyPage(),
                  ),
                ),
              ),

              const SizedBox(height: 60),

              // 3. TOMBOL LOGOUT
              GestureDetector(
                onTap: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                    (route) => false,
                  );
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Colors.red.withValues(alpha: 0.2),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Keluar',
                        style: poppinsText.copyWith(
                          color: Colors.redAccent,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Icon(
                        Icons.logout,
                        color: Colors.redAccent,
                        size: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // --- HELPER MENU ITEM ---
  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade200),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.02),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.black87, size: 22),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: poppinsText.copyWith(
                  color: blackColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
            ),
            const Icon(Icons.chevron_right, color: Colors.black54, size: 20),
          ],
        ),
      ),
    );
  }

  // --- HELPER ORNAMEN GRADIENT ---
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
        width: 320,
        height: 320,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(
            colors: [
              const Color(0xFF4CAF50).withValues(alpha: 0.1),
              const Color(0xFF4CAF50).withValues(alpha: 0),
            ],
          ),
        ),
      ),
    );
  }
}
