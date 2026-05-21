import 'package:flutter/material.dart';
import 'package:naventure_apk/pages/auth/login_page.dart';
import 'package:naventure_apk/pages/main/account_security_page.dart';
import '../../utils/theme.dart';
import 'favorite_page.dart';
import 'ticket_page.dart';
import 'emergency_page.dart';
import 'dart:io'; // Amankan pembacaan file gambar
import 'package:image_picker/image_picker.dart'; // Amankan akses galeri

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // --- 1. LOGIKA VARIABEL STATE (TETAP AMAN) ---
  String userName = 'Maki Zenin';
  String userEmail = 'zenin_makin@email.com';
  File? _imageFile;

  // --- 2. FUNGSI PICK IMAGE DARI GALERI ---
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

  // --- 3. FUNGSI EDIT POPUP NAMA & EMAIL ---
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
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Text(
            'Edit Profil',
            style: poppinsText.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Nama',
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF2E7D32)),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF2E7D32)),
                  ),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Batal', style: interText.copyWith(color: greyColor)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2E7D32),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () {
                setState(() {
                  userName = nameController.text;
                  userEmail = emailController.text;
                });
                Navigator.pop(context);
              },
              child: Text(
                'Simpan',
                style: interText.copyWith(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }

  // --- 4. FUNGSI NOTIFIKASI POPUP ---
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
                  color: const Color(0xFF2E7D32),
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
    return Container(
      // --- BACKGROUND GRADASI ALAM (SERAGAM DAN KONSISTEN) ---
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
        backgroundColor: Colors.transparent, // Tembus ke gradasi background
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
                onPressed: _showNotificationPopup,
              ),
            ),
          ],
        ),
        body: Stack(
          children: [
            // --- ORNAMEN MESH MAKSIMAL ---
            _buildBackgroundOrnament(
              top: -50,
              left: -50,
              size: 280,
              color: const Color(0xFF81C784),
            ),
            _buildBackgroundOrnament(
              bottom: 50,
              right: -100,
              size: 350,
              color: const Color(0xFFAED581),
            ),

            // --- KONTEN LIST ---
            ListView(
              // Padding bawah dikasih 100 biar aman dari tabrakan navbar custom boi
              padding: const EdgeInsets.fromLTRB(24, 20, 24, 100),
              children: [
                // 1. BLOK FOTO PROFIL & IDENTITAS
                Center(
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          GestureDetector(
                            onTap: _pickImage,
                            child: Container(
                              width: 104,
                              height: 104,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.white,
                                  width: 3,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.08),
                                    blurRadius: 12,
                                    offset: const Offset(0, 6),
                                  ),
                                ],
                                image: DecorationImage(
                                  image: _imageFile != null
                                      ? FileImage(_imageFile!) as ImageProvider
                                      : const AssetImage(
                                          'assets/img/profile.jpg',
                                        ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 2,
                            right: 2,
                            child: GestureDetector(
                              onTap: _showEditPopup,
                              child: Container(
                                padding: const EdgeInsets.all(7),
                                decoration: const BoxDecoration(
                                  color: Color(
                                    0xFF2E7D32,
                                  ), // Ubah jadi hijau biar estetik boi
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.edit,
                                  size: 14,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        userName,
                        style: poppinsText.copyWith(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: blackColor,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        userEmail,
                        style: interText.copyWith(
                          fontSize: 14,
                          color: greyColor,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 36),

                // 2. KELOMPOK MENU UTAMA
                _buildMenuItem(
                  icon: Icons.favorite_border,
                  title: 'Favorit',
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const FavoritePage(),
                    ),
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

                const SizedBox(height: 48),

                // 3. SEKTOR TOMBOL LOGOUT PREMIUM
                GestureDetector(
                  onTap: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginPage(),
                      ),
                      (route) => false,
                    );
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: Colors.red.withValues(alpha: 0.15),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.red.withValues(alpha: 0.03),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
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
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Colors.grey.shade100),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: const Color(0xFF2E7D32),
              size: 22,
            ), // Warna ikon diselaraskan ke hijau tema
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
            const Icon(Icons.chevron_right, color: Colors.black38, size: 20),
          ],
        ),
      ),
    );
  }

  // --- HELPER ORNAMEN GRADIENT REUSABLE ---
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
              color.withValues(alpha: 0.1),
              color.withValues(alpha: 0.1),
              color.withValues(alpha: 0.0),
            ],
            stops: const [0.0, 0.5, 1.0],
          ),
        ),
      ),
    );
  }
}
