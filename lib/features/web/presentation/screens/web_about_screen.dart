import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/constants/web_colors.dart';
import '../../core/providers/web_providers.dart';

class WebAboutScreen extends ConsumerWidget {
  const WebAboutScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = ref.watch(webDarkModeProvider);

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 64),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(child: Text('About Veltrix Sports', style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: isDark ? WebColors.darkTextPrimary : WebColors.textPrimary))),
              const SizedBox(height: 16),
              Center(
                child: Text(
                  'Empowering athletes across India with the tools, coaching, and community they need to succeed.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18, color: isDark ? WebColors.darkTextSecondary : WebColors.textSecondary),
                ),
              ),
              const SizedBox(height: 48),
              _Section(
                title: 'Our Mission',
                body: 'Veltrix Sports was founded with a simple mission: to make world-class sports coaching, training resources, and event participation accessible to every athlete in India. We believe that talent is everywhere, but opportunity isn\'t always. Our platform bridges that gap.',
                isDark: isDark,
              ),
              const SizedBox(height: 32),
              _Section(
                title: 'What We Do',
                body: 'We connect athletes with certified coaches, provide structured training plans for 20+ sports, discover and manage events from local fun runs to national championships, and offer seamless digital ticketing. Everything an athlete needs, in one platform.',
                isDark: isDark,
              ),
              const SizedBox(height: 32),
              _Section(
                title: 'Our Values',
                body: 'Excellence in coaching. Inclusivity in access. Innovation in technology. Integrity in every interaction. These core values guide every feature we build and every partnership we form.',
                isDark: isDark,
              ),
              const SizedBox(height: 48),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(40),
                decoration: BoxDecoration(
                  gradient: WebColors.primaryGradient,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    const Text('Join the Movement', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: WebColors.white)),
                    const SizedBox(height: 8),
                    const Text('10,000+ athletes are already training smarter.', style: TextStyle(color: WebColors.white70)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Section extends StatelessWidget {
  final String title;
  final String body;
  final bool isDark;
  const _Section({required this.title, required this.body, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: isDark ? WebColors.darkTextPrimary : WebColors.textPrimary)),
        const SizedBox(height: 12),
        Text(body, style: TextStyle(fontSize: 16, height: 1.7, color: isDark ? WebColors.darkTextSecondary : WebColors.textSecondary)),
      ],
    );
  }
}
