import 'package:flutter/material.dart';
import 'package:naventure_apk/pages/main/home_page.dart';
import '../../utils/theme.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: Stack(
        children: [
          // 1. Ornamen Lingkaran Hijau di Kiri Atas
          Positioned(
            top: -80, // Sesuaikan lagi biar pas sama prototype
            left: -80,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  begin: Alignment.topCenter, // Mulai dari atas
                  end: Alignment.bottomCenter, // Arah ke bawah
                  colors: [
                    secondaryColor.withValues(
                      alpha: 1.0,
                    ), // 100% Opacity (Pekat)
                    secondaryColor.withValues(alpha: 0.0), // 0% Opacity (Ilang)
                  ],
                  // --- INI KUNCI BIAR "TAJEM" ---
                  // 0.0 artinya warna pekat mulai di paling atas
                  // 0.5 artinya di tengah-tengah lingkaran warnanya udah lunas jadi transparan
                  stops: const [0.0, 1],
                ),
              ),
            ),
          ),

          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Tombol Back di pojok kiri atas
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context); // Balik ke halaman Login
                    },
                    child: Icon(Icons.arrow_back, color: blackColor),
                  ),
                  const SizedBox(height: 40),

                  // --- JUDUL ---
                  Text(
                    'Daftar',
                    style: poppinsText.copyWith(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: blackColor,
                    ),
                  ),
                  const SizedBox(height: 30),

                  // --- INPUT NAMA LENGKAP ---
                  Text(
                    'Nama Lengkap',
                    style: poppinsText.copyWith(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Masukkan nama lengkap Anda',
                      hintStyle: interText.copyWith(color: greyColor),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: greyColor),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: greyColor),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // --- INPUT EMAIL ---
                  Text(
                    'Email',
                    style: poppinsText.copyWith(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Masukkan email Anda',
                      hintStyle: interText.copyWith(color: greyColor),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: greyColor),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: greyColor),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // --- INPUT PASSWORD ---
                  Text(
                    'Kata Sandi',
                    style: poppinsText.copyWith(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    obscureText: _obscurePassword,
                    decoration: InputDecoration(
                      hintText: 'Buat kata sandi',
                      hintStyle: interText.copyWith(color: greyColor),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: greyColor),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: greyColor),
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: greyColor,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // --- INPUT KONFIRMASI PASSWORD ---
                  Text(
                    'Konfirmasi Kata Sandi',
                    style: poppinsText.copyWith(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    obscureText: _obscureConfirmPassword,
                    decoration: InputDecoration(
                      hintText: 'Ulangi kata sandi',
                      hintStyle: interText.copyWith(color: greyColor),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: greyColor),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: greyColor),
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureConfirmPassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: greyColor,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscureConfirmPassword = !_obscureConfirmPassword;
                          });
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),

                  // --- TOMBOL DAFTAR ---
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HomePage(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: secondaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      child: Text(
                        'Daftar',
                        style: poppinsText.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: whiteColor,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),

                  // --- LINK KEMBALI KE LOGIN ---
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Sudah Punya Akun? ',
                        style: interText.copyWith(
                          color: greyColor,
                          fontSize: 14,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context); // Balik ke halaman login
                        },
                        child: Text(
                          'Masuk',
                          style: poppinsText.copyWith(
                            color: redColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
