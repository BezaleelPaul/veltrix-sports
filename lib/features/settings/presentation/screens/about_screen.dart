import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text('About', style: GoogleFonts.poppins()),
        backgroundColor: AppColors.background,
        elevation: 0,
        foregroundColor: AppColors.textPrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.sports_soccer, size: 50, color: AppColors.primary),
            ),
            const SizedBox(height: 20),
            Text('Veltrix Sports', style: GoogleFonts.poppins(fontSize: 28, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text('Version 1.0.0', style: TextStyle(color: AppColors.textSecondary)),
            const SizedBox(height: 24),
            Text(
              'Your all-in-one platform for training plans, sports events, and ticketing.',
              textAlign: TextAlign.center,
              style: TextStyle(color: AppColors.textSecondary, height: 1.5),
            ),
            const SizedBox(height: 32),
            _buildSectionHeader('Features'),
            const SizedBox(height: 12),
            _buildFeature(Icons.fitness_center, 'Training Plans', 'Expert-designed plans for every sport'),
            _buildFeature(Icons.event, 'Sports Events', 'Discover and register for events'),
            _buildFeature(Icons.confirmation_number, 'Digital Tickets', 'QR-coded tickets with easy transfers'),
            _buildFeature(Icons.person, 'Top Coaches', 'Connect with certified coaches'),
            _buildFeature(Icons.trending_up, 'Progress Tracking', 'Track workouts and achievements'),
            _buildFeature(Icons.search, 'Smart Search', 'Find training, events, and coaches'),
            const SizedBox(height: 32),
            _buildSectionHeader('Built With'),
            const SizedBox(height: 12),
            Text(
              'Flutter • Riverpod • GoRouter • fl_chart',
              textAlign: TextAlign.center,
              style: TextStyle(color: AppColors.textSecondary),
            ),
            const SizedBox(height: 32),
            Text('Made with passion for sports', style: TextStyle(color: AppColors.textHint)),
            const SizedBox(height: 8),
            Text('© 2026 Veltrix Sports', style: TextStyle(color: AppColors.textHint, fontSize: 12)),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(title, style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildFeature(IconData icon, String title, String description) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: AppColors.primary, size: 22),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
                Text(description, style: TextStyle(color: AppColors.textSecondary, fontSize: 13)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
