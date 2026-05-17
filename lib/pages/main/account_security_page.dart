import 'package:flutter/material.dart';
import '../../utils/theme.dart';

class AccountSecurityPage extends StatelessWidget {
  const AccountSecurityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context), // Balik ke profil
        ),
        title: Text(
          'Pengaturan & Keamanan',
          style: poppinsText.copyWith(
            color: blackColor,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          _buildSectionHeader('Data Akun'),
          _buildSettingTile(
            icon: Icons.mail_outline,
            title: 'Email',
            subtitle: 'david_septian@email.com',
            trailing: const Icon(
              Icons.check_circle,
              color: Colors.green,
              size: 20,
            ),
          ),
          _buildSettingTile(
            icon: Icons.phone_android,
            title: 'Nomor HP',
            subtitle: '+62812****4321',
          ),
          const SizedBox(height: 32),

          _buildSectionHeader('Keamanan'),
          _buildSettingTile(
            icon: Icons.lock_outline,
            title: 'Ubah Password',
            subtitle: 'Terakhir diubah 2 bulan lalu',
            onTap: () {
              // Nanti bisa arahin ke halaman ganti password
            },
          ),
          _buildSettingTile(
            icon: Icons.security,
            title: 'Verifikasi 2 Langkah',
            subtitle: 'Amankan akun dengan kode OTP',
            trailing: Switch(
              value: true,
              onChanged: (val) {},
              activeThumbColor: Colors.green,
            ),
          ),
          const SizedBox(height: 32),

          _buildSectionHeader('Zona Bahaya'),
          _buildSettingTile(
            icon: Icons.delete_outline,
            title: 'Hapus Akun',
            subtitle: 'Hapus data akun secara permanen',
            titleColor: Colors.red,
            iconColor: Colors.red,
            onTap: () {
              // Logika hapus akun
            },
          ),
        ],
      ),
    );
  }

  // Widget bantuan biar gak ngetik berulang buat judul section
  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Text(
        title,
        style: poppinsText.copyWith(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: greyColor,
        ),
      ),
    );
  }

  // Widget buat baris pengaturannya
  Widget _buildSettingTile({
    required IconData icon,
    required String title,
    String? subtitle,
    Widget? trailing,
    Color? titleColor,
    Color? iconColor,
    VoidCallback? onTap,
  }) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      onTap: onTap,
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: (iconColor ?? blackColor).withValues(alpha: 0.1),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: iconColor ?? blackColor, size: 20),
      ),
      title: Text(
        title,
        style: poppinsText.copyWith(
          fontSize: 15,
          fontWeight: FontWeight.w600,
          color: titleColor ?? blackColor,
        ),
      ),
      subtitle: subtitle != null
          ? Text(
              subtitle,
              style: interText.copyWith(fontSize: 12, color: greyColor),
            )
          : null,
      trailing:
          trailing ??
          const Icon(Icons.chevron_right, size: 20, color: Colors.grey),
    );
  }
}
