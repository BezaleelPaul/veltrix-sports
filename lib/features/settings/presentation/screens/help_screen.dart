import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text('Help & Support', style: GoogleFonts.poppins()),
        backgroundColor: AppColors.background,
        elevation: 0,
        foregroundColor: AppColors.textPrimary,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _buildHelpItem(Icons.help_outline, 'FAQs', 'Frequently asked questions'),
          _buildHelpItem(Icons.email, 'Contact Us', 'support@veltrixsports.com'),
          _buildHelpItem(Icons.chat, 'Live Chat', 'Chat with our support team'),
          _buildHelpItem(Icons.bug_report, 'Report a Bug', 'Let us know about issues'),
          _buildHelpItem(Icons.star, 'Rate Us', 'Rate Veltrix Sports on Play Store'),
        ],
      ),
    );
  }

  Widget _buildHelpItem(IconData icon, String title, String subtitle) {
    return ListTile(
      leading: Icon(icon, color: AppColors.primary),
      title: Text(title),
      subtitle: Text(subtitle, style: TextStyle(color: AppColors.textSecondary)),
      trailing: const Icon(Icons.chevron_right),
      onTap: () {},
    );
  }
}
