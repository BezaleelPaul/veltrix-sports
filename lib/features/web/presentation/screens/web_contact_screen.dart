import 'package:flutter/material.dart';
import '../../core/constants/web_colors.dart';

class WebContactScreen extends StatelessWidget {
  const WebContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 60),
            color: WebColors.grey50,
            child: Column(
              children: [
                const Text('Contact Us', style: TextStyle(fontSize: 44, fontWeight: FontWeight.bold)),
                const SizedBox(height: 12),
                const Text('Have questions? We\'d love to hear from you.', style: TextStyle(fontSize: 18, color: WebColors.textSecondary)),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 60),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Send us a message', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 24),
                      Row(
                        children: [
                          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                            const Text('First Name', style: TextStyle(fontWeight: FontWeight.w600)),
                            const SizedBox(height: 8),
                            TextField(decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)), hintText: 'First name')),
                          ])),
                          const SizedBox(width: 16),
                          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                            const Text('Last Name', style: TextStyle(fontWeight: FontWeight.w600)),
                            const SizedBox(height: 8),
                            TextField(decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)), hintText: 'Last name')),
                          ])),
                        ],
                      ),
                      const SizedBox(height: 20),
                      const Text('Email', style: TextStyle(fontWeight: FontWeight.w600)),
                      const SizedBox(height: 8),
                      TextField(decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)), hintText: 'your@email.com')),
                      const SizedBox(height: 20),
                      const Text('Message', style: TextStyle(fontWeight: FontWeight.w600)),
                      const SizedBox(height: 8),
                      TextField(maxLines: 5, decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)), hintText: 'Tell us how we can help...')),
                      const SizedBox(height: 24),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(backgroundColor: WebColors.primary, foregroundColor: WebColors.white, padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                        child: const Text('Send Message'),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 60),
                Expanded(
                  child: Column(
                    children: [
                      _buildContactCard(Icons.email, 'Email', 'support@veltrixsports.com'),
                      const SizedBox(height: 16),
                      _buildContactCard(Icons.phone, 'Phone', '+91 1800-123-4567'),
                      const SizedBox(height: 16),
                      _buildContactCard(Icons.location_on, 'Office', 'Mumbai, Maharashtra, India'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactCard(IconData icon, String title, String value) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(color: WebColors.grey50, borderRadius: BorderRadius.circular(12)),
      child: Row(
        children: [
          Icon(icon, color: WebColors.primary),
          const SizedBox(width: 16),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
            Text(value, style: const TextStyle(color: WebColors.textSecondary, fontSize: 14)),
          ]),
        ],
      ),
    );
  }
}
