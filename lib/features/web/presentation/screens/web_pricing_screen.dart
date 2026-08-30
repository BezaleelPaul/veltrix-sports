import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/constants/web_colors.dart';
import '../../core/providers/web_providers.dart';

class WebPricingScreen extends ConsumerWidget {
  const WebPricingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;
    final isTablet = screenWidth >= 768 && screenWidth < 1024;
    final isDark = ref.watch(webDarkModeProvider);

    final plans = [
      _PricingPlan('Free', '0', '/month', [
        'Access to 5 training plans',
        'Browse upcoming events',
        'Community forum access',
        'Basic performance tracking',
      ], false),
      _PricingPlan('Pro', '499', '/month', [
        'Unlimited training plans',
        'Priority event registration',
        '1-on-1 coach sessions (4/mo)',
        'Advanced analytics',
        'Custom workout plans',
        'Nutrition guidance',
      ], true),
      _PricingPlan('Elite', '999', '/month', [
        'Everything in Pro',
        'Unlimited coach sessions',
        'Competition preparation',
        'Travel & logistics support',
        'Team management tools',
        'Dedicated support agent',
        'API access',
      ], false),
    ];

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 16 : (isTablet ? 24 : 48), vertical: isMobile ? 32 : 64),
      child: Column(
        children: [
          Text('Pricing', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: WebColors.primary)),
          const SizedBox(height: 12),
          Text('Simple, Transparent Pricing',
              style: TextStyle(fontSize: isMobile ? 24 : 36, fontWeight: FontWeight.bold, color: isDark ? WebColors.darkTextPrimary : WebColors.textPrimary)),
          const SizedBox(height: 12),
          Text('Choose the plan that fits your athletic journey.',
              style: TextStyle(fontSize: isMobile ? 14 : 16, color: isDark ? WebColors.darkTextSecondary : WebColors.textSecondary)),
          SizedBox(height: isMobile ? 24 : 48),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: isMobile ? 12 : 16,
            runSpacing: isMobile ? 16 : 24,
            children: plans.map((p) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0),
              child: SizedBox(
                width: isMobile ? double.infinity : 340,
                child: Container(
                  padding: EdgeInsets.all(isMobile ? 20 : 32),
                  decoration: BoxDecoration(
                    color: isDark ? WebColors.darkCard : WebColors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: p.isPopular ? WebColors.primary : (isDark ? WebColors.darkBorder : WebColors.grey100),
                      width: p.isPopular ? 2 : 1,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (p.isPopular)
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                          decoration: BoxDecoration(
                            color: WebColors.primary,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Text('Most Popular', style: TextStyle(color: WebColors.white, fontSize: 12, fontWeight: FontWeight.w600)),
                        ),
                      const SizedBox(height: 16),
                      Text(p.name,
                          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: isDark ? WebColors.darkTextPrimary : WebColors.textPrimary)),
                      const SizedBox(height: 8),
                      Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
                        Text('₹${p.price}',
                            style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: isDark ? WebColors.darkTextPrimary : WebColors.textPrimary)),
                        Text(p.period,
                            style: TextStyle(fontSize: 14, color: isDark ? WebColors.darkTextSecondary : WebColors.grey500)),
                      ]),
                      const SizedBox(height: 24),
                      ...p.features.map((f) => Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Row(
                          children: [
                            const Icon(Icons.check, size: 18, color: WebColors.accent),
                            const SizedBox(width: 10),
                            Expanded(child: Text(f, style: TextStyle(fontSize: 14, color: isDark ? WebColors.darkTextSecondary : WebColors.grey700))),
                          ],
                        ),
                      )),
                      const SizedBox(height: 24),
                      SizedBox(
                        width: double.infinity,
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: p.isPopular ? WebColors.primaryGradient : null,
                            border: p.isPopular ? null : Border.all(color: isDark ? WebColors.darkBorder : WebColors.grey300),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(12),
                              onTap: () {},
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 14),
                                child: Center(
                                  child: Text(
                                    p.isPopular ? 'Get Started' : 'Choose Plan',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: p.isPopular
                                          ? WebColors.white
                                          : isDark
                                              ? WebColors.darkTextPrimary
                                              : WebColors.textPrimary,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )).toList(),
          ),
        ],
      ),
    );
  }
}

class _PricingPlan {
  final String name;
  final String price;
  final String period;
  final List<String> features;
  final bool isPopular;
  const _PricingPlan(this.name, this.price, this.period, this.features, this.isPopular);
}
