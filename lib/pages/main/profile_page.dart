import 'package:flutter/material.dart';
import 'package:naventure_apk/pages/auth/login_page.dart';
import 'package:naventure_apk/pages/main/account_security_page.dart';
import 'package:shared_preferences/shared_preferences.dart'; // <-- Tambahin import ini
import '../../utils/theme.dart';
import 'favorite_page.dart';
import 'ticket_page.dart';
import 'emergency_page.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // --- 1. LOGIKA VARIABEL STATE ---
  String userName = 'Maki Zenin'; // Ini bakal jadi nilai default awal aja
  String userEmail = 'zenin_makin@email.com';
  File? _imageFile;

  // --- TAMBAHAN: INITSTATE BUAT LOAD DATA PAS HALAMAN DIBUKA ---
  @override
  void initState() {
    super.initState();
    _loadProfileData(); // Panggil fungsi load data tiap kali masuk halaman
  }

  // Fungsi buat ngambil data yang tersimpan di HP
  Future<void> _loadProfileData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      // Kalau datanya belum pernah disimpan, dia pake nilai default ('Maki Zenin')
      userName = prefs.getString('userName') ?? 'Maki Zenin';
      userEmail = prefs.getString('userEmail') ?? 'zenin_makin@email.com';

      // Bonus: Amankan juga path foto profilnya biar ga ilang boi
      String? imagePath = prefs.getString('userImagePath');
      if (imagePath != null) {
        _imageFile = File(imagePath);
      }
    });
  }

  // Fungsi buat nyimpen data ke memori HP
  Future<void> _saveProfileData(String name, String email) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userName', name);
    await prefs.setString('userEmail', email);
  }

  // --- 2. FUNGSI PICK IMAGE DARI GALERI ---
  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      final prefs = await SharedPreferences.getInstance();
      setState(() {
        _imageFile = File(pickedFile.path);
      });
      // Simpan path gambar ke lokal HP
      await prefs.setString('userImagePath', pickedFile.path);
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
          backgroundColor: Colors.white,
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
              onPressed: () async {
                // 1. Ambil nilainya dulu
                String newName = nameController.text;
                String newEmail = emailController.text;

                // 2. Langsung tutup popup-nya duluan biar UI-nya responsif!
                Navigator.pop(context);

                // 3. Update tampilan layar (State)
                setState(() {
                  userName = newName;
                  userEmail = newEmail;
                });

                // 4. Simpan ke storage HP di background
                await _saveProfileData(newName, newEmail);
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
          backgroundColor: Colors.white,
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
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
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
              border: Border.all(color: Colors.grey.shade200),
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
          _buildBackgroundOrnament(
            top: -20,
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

          ListView(
            padding: const EdgeInsets.fromLTRB(24, 20, 24, 100),
            children: [
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
                              border: Border.all(color: Colors.white, width: 4),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.06),
                                  blurRadius: 15,
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
                              decoration: BoxDecoration(
                                color: const Color(0xFF2E7D32),
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.white,
                                  width: 2,
                                ),
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
                      style: interText.copyWith(fontSize: 14, color: greyColor),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 36),

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

              const SizedBox(height: 48),

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
    );
  }

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
            Icon(icon, color: const Color(0xFF2E7D32), size: 22),
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
              color.withValues(alpha: 0.12),
              color.withValues(alpha: 0.11),
              color.withValues(alpha: 0.0),
            ],
            stops: const [0.0, 0.4, 1.0],
          ),
        ),
      ),
    );
  }
}
