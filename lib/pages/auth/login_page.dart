import 'package:flutter/material.dart';
import '../../utils/theme.dart';
import '../main_page.dart'; // Sesuaikan path-nya kalau folder lo beda
import 'register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // --- TAMBAHAN: Controller buat nangkep input teks ---
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _obscureText = true;

  // --- TAMBAHAN: Jangan lupa di-dispose biar gak bocor memorinya ---
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: Stack(
        children: [
          // 1. Ornamen Lingkaran Hijau di Kiri Atas
          Positioned(
            top: -80,
            left: -80,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    secondaryColor.withValues(alpha: 1.0),
                    secondaryColor.withValues(alpha: 0.0),
                  ],
                  stops: const [0.0, 1],
                ),
              ),
            ),
          ),

          // 2. Isi Halaman Utama
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 120),
                  // --- JUDUL ---
                  Text(
                    'Masuk',
                    style: poppinsText.copyWith(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: blackColor,
                    ),
                  ),
                  const SizedBox(height: 30),

                  // --- INPUT EMAIL ---
                  Text(
                    'Email',
                    style: poppinsText.copyWith(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _emailController, // <-- TAMBAHAN
                    keyboardType: TextInputType.emailAddress,
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

                  // --- INPUT KATA SANDI ---
                  Text(
                    'Kata Sandi',
                    style: poppinsText.copyWith(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _passwordController, // <-- TAMBAHAN
                    obscureText: _obscureText,
                    decoration: InputDecoration(
                      hintText: 'Masukkan kata sandi Anda',
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
                          _obscureText
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: greyColor,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // --- LUPA KATA SANDI ---
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      'Lupa Kata Sandi?',
                      style: poppinsText.copyWith(
                        color: redColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),

                  // --- TOMBOL MASUK (REVISI LOGIKA) ---
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        String email = _emailController.text.trim();
                        String password = _passwordController.text.trim();

                        // 1. Validasi kalau ada field yang kosong
                        if (email.isEmpty || password.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Email dan kata sandi tidak boleh kosong!',
                                style: interText.copyWith(color: whiteColor),
                              ),
                              backgroundColor: Colors.redAccent,
                            ),
                          );
                          return; // Stop proses
                        }

                        // 2. Validasi harus pake @gmail.com
                        if (!email.endsWith('@gmail.com')) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Format salah!',
                                style: interText.copyWith(color: whiteColor),
                              ),
                              backgroundColor: Colors.orangeAccent,
                            ),
                          );
                          return; // Stop proses
                        }

                        // Jika lolos semua validasi
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MainPage(),
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
                        'Masuk',
                        style: poppinsText.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: whiteColor,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),

                  // --- DIVIDER ---
                  Row(
                    children: [
                      Expanded(child: Divider(color: greyColor, thickness: 1)),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          'Atau Login Dengan',
                          style: interText.copyWith(
                            color: greyColor,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      Expanded(child: Divider(color: greyColor, thickness: 1)),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // --- TOMBOL SOSMED ---
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildSocialButton(Icons.apple, Colors.black),
                      const SizedBox(width: 20),
                      _buildSocialButton(Icons.g_mobiledata, Colors.red),
                      const SizedBox(width: 20),
                      _buildSocialButton(Icons.facebook, Colors.blue),
                    ],
                  ),
                  const SizedBox(height: 40),

                  // --- LINK KE HALAMAN DAFTAR ---
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'belum Punya Akun? ',
                        style: interText.copyWith(
                          color: greyColor,
                          fontSize: 14,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const RegisterPage(),
                            ),
                          );
                        },
                        child: Text(
                          'Daftar',
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

  Widget _buildSocialButton(IconData icon, Color color) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: greyColor.withValues(alpha: 0.5)),
        color: whiteColor,
      ),
      child: Center(child: Icon(icon, color: color, size: 28)),
    );
  }
}
