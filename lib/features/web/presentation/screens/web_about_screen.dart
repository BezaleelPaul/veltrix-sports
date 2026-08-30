import 'package:flutter/material.dart';
import '../../core/constants/web_colors.dart';

class WebAboutScreen extends StatelessWidget {
  const WebAboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 80),
            color: WebColors.grey50,
            child: Column(
              children: [
                const Text('About Veltrix Sports', style: TextStyle(fontSize: 44, fontWeight: FontWeight.bold)),
                const SizedBox(height: 12),
                const Text('India\'s leading sports platform for athletes, coaches, and event organizers.', style: TextStyle(fontSize: 18, color: WebColors.textSecondary)),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 60),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Our Mission', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 16),
                          const Text(
                            'Veltrix Sports was founded with a simple mission: make sports accessible to everyone. We believe that every athlete deserves access to expert coaching, exciting events, and a community that supports their journey.',
                            style: TextStyle(fontSize: 16, color: WebColors.textSecondary, height: 1.6),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 60),
                    Expanded(
                      child: Container(
                        height: 300,
                        decoration: BoxDecoration(
                          color: WebColors.primary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: const Center(child: Icon(Icons.fitness_center, size: 80, color: WebColors.primary)),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 60),
                const Text('Our Values', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                const SizedBox(height: 32),
                Row(
                  children: [
                    _buildValueItem(Icons.groups, 'Community', 'Building a supportive sports community across India.'),
                    const SizedBox(width: 24),
                    _buildValueItem(Icons.emoji_events, 'Excellence', 'Striving for the highest quality in everything we do.'),
                    const SizedBox(width: 24),
                    _buildValueItem(Icons.accessibility_new, 'Inclusivity', 'Making sports accessible to everyone regardless of skill level.'),
                    const SizedBox(width: 24),
                    _buildValueItem(Icons.lightbulb, 'Innovation', 'Continuously improving our platform with technology.'),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildValueItem(IconData icon, String title, String description) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(color: WebColors.grey50, borderRadius: BorderRadius.circular(16)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: WebColors.primary, size: 32),
            const SizedBox(height: 16),
            Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(description, style: const TextStyle(color: WebColors.textSecondary, height: 1.5)),
          ],
        ),
      ),
    );
  }
}
