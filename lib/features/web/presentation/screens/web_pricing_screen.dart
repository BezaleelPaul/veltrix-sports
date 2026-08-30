import 'package:flutter/material.dart';
import '../../core/constants/web_colors.dart';

class WebPricingScreen extends StatelessWidget {
  const WebPricingScreen({super.key});

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
                const Text('Simple, Transparent Pricing', style: TextStyle(fontSize: 44, fontWeight: FontWeight.bold)),
                const SizedBox(height: 12),
                const Text('Choose the plan that fits your needs.', style: TextStyle(fontSize: 18, color: WebColors.textSecondary)),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 60),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildPricingCard('Free', '₹0', 'forever', [
                  'Browse training plans',
                  'View events',
                  'Basic progress tracking',
                  'Community access',
                ], false),
                const SizedBox(width: 24),
                _buildPricingCard('Pro', '₹499', '/month', [
                  'Everything in Free',
                  'Unlimited training plans',
                  'Priority event booking',
                  '1-on-1 coach sessions',
                  'Advanced analytics',
                ], true),
                const SizedBox(width: 24),
                _buildPricingCard('Elite', '₹999', '/month', [
                  'Everything in Pro',
                  'Unlimited coach sessions',
                  'Custom training plans',
                  'VIP event access',
                  'Nutrition guidance',
                  'Injury support',
                ], false),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPricingCard(String name, String price, String period, List<String> features, bool isPopular) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          color: WebColors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: isPopular ? WebColors.primary : WebColors.grey200, width: isPopular ? 2 : 1),
        ),
        child: Column(
          children: [
            if (isPopular)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(color: WebColors.primary, borderRadius: BorderRadius.circular(12)),
                child: const Text('Most Popular', style: TextStyle(color: WebColors.white, fontSize: 12, fontWeight: FontWeight.w600)),
              ),
            const SizedBox(height: 16),
            Text(name, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(price, style: const TextStyle(fontSize: 44, fontWeight: FontWeight.bold)),
                Text(period, style: const TextStyle(color: WebColors.textSecondary, fontSize: 16)),
              ],
            ),
            const SizedBox(height: 24),
            ...features.map((f) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(children: [
                const Icon(Icons.check_circle, color: WebColors.secondary, size: 18),
                const SizedBox(width: 8),
                Expanded(child: Text(f, style: const TextStyle(fontSize: 14))),
              ]),
            )),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: isPopular ? WebColors.primary : WebColors.white,
                  foregroundColor: isPopular ? WebColors.white : WebColors.primary,
                  side: isPopular ? null : const BorderSide(color: WebColors.primary),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text('Get Started'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
