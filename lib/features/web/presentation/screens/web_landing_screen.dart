import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/web_colors.dart';
import '../../core/providers/web_providers.dart';

class WebLandingScreen extends ConsumerWidget {
  const WebLandingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = ref.watch(webDarkModeProvider);
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildHeroSection(context, isDark),
          _buildTrustedBySection(isDark),
          _buildFeaturesSection(context, isDark),
          _buildHowItWorksSection(isDark),
          _buildStatsSection(isDark),
          _buildTestimonialsSection(isDark),
          _buildCTASection(context, isDark),
        ],
      ),
    );
  }

  Widget _buildHeroSection(BuildContext context, bool isDark) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 80),
      decoration: const BoxDecoration(gradient: WebColors.heroGradient),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  decoration: BoxDecoration(color: WebColors.white.withOpacity(0.15), borderRadius: BorderRadius.circular(20)),
                  child: const Text('🚀 Launching Soon - Join 10,000+ Athletes', style: TextStyle(color: WebColors.white, fontSize: 14)),
                ),
                const SizedBox(height: 24),
                const Text('Your Complete\nSports Platform', style: TextStyle(color: WebColors.white, fontSize: 56, fontWeight: FontWeight.bold, height: 1.1)),
                const SizedBox(height: 20),
                const Text('Find expert coaches, discover events, book tickets,\nand track your progress — all in one place.', style: TextStyle(color: WebColors.white70, fontSize: 18, height: 1.5)),
                const SizedBox(height: 36),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () => context.go('/signup'),
                      style: ElevatedButton.styleFrom(backgroundColor: WebColors.white, foregroundColor: WebColors.primary, padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 18), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)), textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                      child: const Text('Get Started Free'),
                    ),
                    const SizedBox(width: 16),
                    OutlinedButton(
                      onPressed: () => context.go('/training'),
                      style: OutlinedButton.styleFrom(foregroundColor: WebColors.white, side: const BorderSide(color: WebColors.white38), padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 18), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)), textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                      child: const Text('Explore Plans'),
                    ),
                  ],
                ),
                const SizedBox(height: 36),
                const Row(children: [_HeroStat('10K+', 'Athletes'), SizedBox(width: 32), _HeroStat('500+', 'Coaches'), SizedBox(width: 32), _HeroStat('200+', 'Events')]),
              ],
            ),
          ),
          const SizedBox(width: 60),
          Expanded(
            child: Container(
              height: 420,
              decoration: BoxDecoration(color: WebColors.white.withOpacity(0.1), borderRadius: BorderRadius.circular(24), border: Border.all(color: WebColors.white.withOpacity(0.2))),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildFeatureCard(Icons.fitness_center, 'Training', WebColors.white.withOpacity(0.15)),
                        const SizedBox(width: 16),
                        _buildFeatureCard(Icons.event, 'Events', WebColors.white.withOpacity(0.15)),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildFeatureCard(Icons.confirmation_number, 'Tickets', WebColors.white.withOpacity(0.15)),
                        const SizedBox(width: 16),
                        _buildFeatureCard(Icons.analytics, 'Progress', WebColors.white.withOpacity(0.15)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  static Widget _buildHeroStat(String value, String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(value, style: const TextStyle(color: WebColors.white, fontSize: 28, fontWeight: FontWeight.bold)),
        Text(label, style: TextStyle(color: WebColors.white.withOpacity(0.7), fontSize: 14)),
      ],
    );
  }

  static Widget _buildFeatureCard(IconData icon, String label, Color bgColor) {
    return Container(
      width: 160,
      height: 160,
      decoration: BoxDecoration(color: bgColor, borderRadius: BorderRadius.circular(16)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 40, color: WebColors.white),
          const SizedBox(height: 12),
          Text(label, style: const TextStyle(color: WebColors.white, fontSize: 16, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }

  Widget _buildTrustedBySection(bool isDark) {
    final bg = isDark ? WebColors.darkBackground : WebColors.grey50;
    final textColor = isDark ? WebColors.darkTextSecondary : WebColors.textSecondary;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 40),
      color: bg,
      child: Column(
        children: [
          Text('Trusted by athletes and coaches across India', style: TextStyle(color: textColor, fontSize: 16)),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildBrandLogo('Mumbai Running Club', textColor),
              const SizedBox(width: 48),
              _buildBrandLogo('Delhi Cycling Fed.', textColor),
              const SizedBox(width: 48),
              _buildBrandLogo('Bangalore Triathlon', textColor),
              const SizedBox(width: 48),
              _buildBrandLogo('Goa Sports Council', textColor),
              const SizedBox(width: 48),
              _buildBrandLogo('Chennai Athletics', textColor),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBrandLogo(String name, Color color) {
    return Text(name, style: TextStyle(color: color, fontSize: 18, fontWeight: FontWeight.w600));
  }

  Widget _buildFeaturesSection(BuildContext context, bool isDark) {
    final bg = isDark ? WebColors.darkBackground : WebColors.white;
    final titleColor = isDark ? WebColors.darkTextPrimary : WebColors.textPrimary;
    final subtitleColor = isDark ? WebColors.darkTextSecondary : WebColors.textSecondary;
    final cardBg = isDark ? WebColors.darkCard : WebColors.white;
    final borderColor = isDark ? WebColors.darkBorder : WebColors.grey200;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 80),
      color: bg,
      child: Column(
        children: [
          Text('Everything You Need', style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: titleColor)),
          const SizedBox(height: 12),
          Text('A complete platform designed for athletes, coaches, and event organizers.', style: TextStyle(fontSize: 18, color: subtitleColor)),
          const SizedBox(height: 60),
          Row(
            children: [
              Expanded(child: _buildFeatureItem(Icons.fitness_center, 'Training Plans', 'Expert-designed training plans for every level.\nPersonalized coaching at your fingertips.', WebColors.primary, cardBg, borderColor, titleColor, subtitleColor)),
              const SizedBox(width: 32),
              Expanded(child: _buildFeatureItem(Icons.event, 'Discover Events', 'Find marathons, triathlons, cycling events\nand more happening near you.', WebColors.secondary, cardBg, borderColor, titleColor, subtitleColor)),
              const SizedBox(width: 32),
              Expanded(child: _buildFeatureItem(Icons.confirmation_number, 'Book Tickets', 'Easy ticket booking with instant confirmation.\nManage all your event tickets in one place.', WebColors.accent, cardBg, borderColor, titleColor, subtitleColor)),
            ],
          ),
          const SizedBox(height: 32),
          Row(
            children: [
              Expanded(child: _buildFeatureItem(Icons.person, 'Expert Coaches', 'Connect with certified coaches.\nGet personalized guidance and support.', const Color(0xFF8B5CF6), cardBg, borderColor, titleColor, subtitleColor)),
              const SizedBox(width: 32),
              Expanded(child: _buildFeatureItem(Icons.analytics, 'Track Progress', 'Monitor your training progress with detailed\nanalytics and performance insights.', const Color(0xFFEC4899), cardBg, borderColor, titleColor, subtitleColor)),
              const SizedBox(width: 32),
              Expanded(child: _buildFeatureItem(Icons.payment, 'Secure Payments', 'Integrated payment system with\nRazorpay for secure transactions.', const Color(0xFF06B6D4), cardBg, borderColor, titleColor, subtitleColor)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureItem(IconData icon, String title, String description, Color color, Color cardBg, Color borderColor, Color titleColor, Color subtitleColor) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(color: cardBg, borderRadius: BorderRadius.circular(16), border: Border.all(color: borderColor)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
            child: Icon(icon, color: color, size: 28),
          ),
          const SizedBox(height: 20),
          Text(title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: titleColor)),
          const SizedBox(height: 8),
          Text(description, style: TextStyle(fontSize: 15, color: subtitleColor, height: 1.5)),
        ],
      ),
    );
  }

  Widget _buildHowItWorksSection(bool isDark) {
    final bg = isDark ? WebColors.darkBackground : WebColors.grey50;
    final titleColor = isDark ? WebColors.darkTextPrimary : WebColors.textPrimary;
    final subtitleColor = isDark ? WebColors.darkTextSecondary : WebColors.textSecondary;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 80),
      color: bg,
      child: Column(
        children: [
          Text('How It Works', style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: titleColor)),
          const SizedBox(height: 12),
          Text('Get started in three simple steps.', style: TextStyle(fontSize: 18, color: subtitleColor)),
          const SizedBox(height: 60),
          Row(
            children: [
              _buildStepItem('1', 'Create Account', 'Sign up as an athlete or coach\nin just a few seconds.', titleColor, subtitleColor),
              _buildStepConnector(),
              _buildStepItem('2', 'Choose & Book', 'Browse training plans, events,\nand book your spot.', titleColor, subtitleColor),
              _buildStepConnector(),
              _buildStepItem('3', 'Track & Improve', 'Monitor your progress and\nachieve your goals.', titleColor, subtitleColor),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStepItem(String number, String title, String description, Color titleColor, Color subtitleColor) {
    return Expanded(
      child: Column(
        children: [
          const CircleAvatar(radius: 32, backgroundColor: WebColors.primary, child: Text('1', style: TextStyle(color: WebColors.white, fontSize: 28, fontWeight: FontWeight.bold))),
          const SizedBox(height: 20),
          Text(title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: titleColor)),
          const SizedBox(height: 8),
          Text(description, textAlign: TextAlign.center, style: TextStyle(fontSize: 15, color: subtitleColor, height: 1.5)),
        ],
      ),
    );
  }

  Widget _buildStepConnector() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 24),
      child: Icon(Icons.arrow_forward, color: WebColors.grey300, size: 32),
    );
  }

  Widget _buildStatsSection(bool isDark) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 60),
      decoration: const BoxDecoration(gradient: WebColors.darkGradient),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatItem('10,000+', 'Active Athletes'),
          _buildStatItem('500+', 'Certified Coaches'),
          _buildStatItem('200+', 'Events Completed'),
          _buildStatItem('₹50L+', 'Prize Money Distributed'),
        ],
      ),
    );
  }

  static Widget _buildStatItem(String value, String label) {
    return Column(
      children: [
        Text(value, style: const TextStyle(color: WebColors.white, fontSize: 40, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Text(label, style: TextStyle(color: WebColors.white.withOpacity(0.7), fontSize: 16)),
      ],
    );
  }

  Widget _buildTestimonialsSection(bool isDark) {
    final bg = isDark ? WebColors.darkBackground : WebColors.white;
    final titleColor = isDark ? WebColors.darkTextPrimary : WebColors.textPrimary;
    final cardBg = isDark ? WebColors.darkCard : WebColors.grey50;
    final textColor = isDark ? WebColors.darkTextSecondary : WebColors.textSecondary;
    final nameColor = isDark ? WebColors.darkTextPrimary : WebColors.textPrimary;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 80),
      color: bg,
      child: Column(
        children: [
          Text('What Athletes Say', style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: titleColor)),
          const SizedBox(height: 48),
          Row(
            children: [
              Expanded(child: _buildTestimonialCard('"Veltrix Sports helped me find the perfect coach for my marathon training. The platform is incredibly user-friendly."', 'Priya Sharma', 'Marathon Runner', 5, cardBg, textColor, nameColor)),
              const SizedBox(width: 24),
              Expanded(child: _buildTestimonialCard('"As a coach, Veltrix Sports has helped me reach hundreds of athletes. The booking system is seamless."', 'Coach Rajesh', 'Swimming Coach', 5, cardBg, textColor, nameColor)),
              const SizedBox(width: 24),
              Expanded(child: _buildTestimonialCard('"Managing event tickets has never been easier. The QR code system works flawlessly at check-in."', 'Amit Patel', 'Event Organizer', 5, cardBg, textColor, nameColor)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTestimonialCard(String quote, String name, String role, int rating, Color cardBg, Color textColor, Color nameColor) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(color: cardBg, borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: List.generate(rating, (index) => const Icon(Icons.star, color: WebColors.accent, size: 18))),
          const SizedBox(height: 16),
          Text(quote, style: TextStyle(fontSize: 15, color: textColor, height: 1.6, fontStyle: FontStyle.italic)),
          const SizedBox(height: 24),
          Row(
            children: [
              CircleAvatar(
                radius: 24,
                backgroundColor: WebColors.primary.withOpacity(0.1),
                child: Text(name[0], style: const TextStyle(color: WebColors.primary, fontWeight: FontWeight.bold, fontSize: 18)),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: TextStyle(fontWeight: FontWeight.w600, color: nameColor)),
                  Text(role, style: TextStyle(fontSize: 13, color: textColor)),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCTASection(BuildContext context, bool isDark) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 80),
      decoration: const BoxDecoration(gradient: WebColors.heroGradient),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Ready to Start Your\nSports Journey?', style: TextStyle(color: WebColors.white, fontSize: 40, fontWeight: FontWeight.bold, height: 1.2)),
                const SizedBox(height: 16),
                const Text('Join thousands of athletes and coaches already using Veltrix Sports.', style: TextStyle(color: WebColors.white70, fontSize: 18)),
                const SizedBox(height: 32),
                ElevatedButton(
                  onPressed: () => context.go('/signup'),
                  style: ElevatedButton.styleFrom(backgroundColor: WebColors.white, foregroundColor: WebColors.primary, padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 18), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)), textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                  child: const Text('Create Free Account'),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(32),
              decoration: BoxDecoration(color: WebColors.white.withOpacity(0.1), borderRadius: BorderRadius.circular(16)),
              child: Column(
                children: [
                  _CtaCheck('Free to join — no hidden fees'),
                  const SizedBox(height: 16),
                  _CtaCheck('Access to 500+ coaches'),
                  const SizedBox(height: 16),
                  _CtaCheck('Browse 200+ events'),
                  const SizedBox(height: 16),
                  _CtaCheck('Track your progress'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCtaCheck(String text) {
    return Row(
      children: [
        const Icon(Icons.check_circle, color: WebColors.white, size: 20),
        const SizedBox(width: 12),
        Text(text, style: const TextStyle(color: WebColors.white, fontSize: 16)),
      ],
    );
  }
}

class _HeroStat extends StatelessWidget {
  final String value;
  final String label;
  const _HeroStat(this.value, this.label);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(value, style: const TextStyle(color: WebColors.white, fontSize: 28, fontWeight: FontWeight.bold)),
        Text(label, style: TextStyle(color: WebColors.white.withOpacity(0.7), fontSize: 14)),
      ],
    );
  }
}

class _CtaCheck extends StatelessWidget {
  final String text;
  const _CtaCheck(this.text);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.check_circle, color: WebColors.white, size: 20),
        const SizedBox(width: 12),
        Text(text, style: const TextStyle(color: WebColors.white, fontSize: 16)),
      ],
    );
  }
}
