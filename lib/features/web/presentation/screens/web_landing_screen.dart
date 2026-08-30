import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/web_colors.dart';
import '../../core/providers/web_providers.dart';

class WebLandingScreen extends ConsumerWidget {
  const WebLandingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;
    final isTablet = screenWidth >= 768 && screenWidth < 1024;
    final isDark = ref.watch(webDarkModeProvider);
    return SingleChildScrollView(
      child: Column(
        children: [
          _HeroSection(isDark: isDark),
          _TrustedBySection(isDark: isDark),
          _FeaturesSection(isDark: isDark),
          _HowItWorksSection(isDark: isDark),
          _StatsSection(isDark: isDark),
          _TestimonialsSection(isDark: isDark),
          _CTASection(isDark: isDark),
        ],
      ),
    );
  }
}

class _HeroSection extends StatelessWidget {
  final bool isDark;
  const _HeroSection({required this.isDark});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;
    final isTablet = screenWidth >= 768 && screenWidth < 1024;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 16 : (isTablet ? 24 : 48), vertical: isMobile ? 48 : 100),
      decoration: BoxDecoration(
        gradient: isDark ? WebColors.darkGradient : const LinearGradient(
          colors: [Color(0xFFF0EEFF), Color(0xFFFFF0F3)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1000),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                decoration: BoxDecoration(
                  color: WebColors.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text('🚀 Trusted by 10,000+ athletes across India',
                    style: TextStyle(color: WebColors.primary, fontSize: 14, fontWeight: FontWeight.w500)),
              ),
              SizedBox(height: isMobile ? 20 : 32),
              Text(
                'Your Complete\nSports Platform',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: isMobile ? 32 : (isTablet ? 44 : 56),
                  fontWeight: FontWeight.bold,
                  height: 1.15,
                  color: isDark ? WebColors.darkTextPrimary : WebColors.textPrimary,
                ),
              ),
              SizedBox(height: isMobile ? 12 : 20),
              Text(
                'Find expert coaches, discover events, enroll in training plans,\nand manage your tickets — all in one place.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: isMobile ? 15 : 18,
                  color: isDark ? WebColors.darkTextSecondary : WebColors.textSecondary,
                  height: 1.6,
                ),
              ),
              SizedBox(height: isMobile ? 24 : 40),
              isMobile
                  ? Column(
                      children: [
                        _PrimaryButton(label: 'Get Started Free', onTap: () => context.go('/signup')),
                        const SizedBox(height: 12),
                        _OutlineButton(label: 'Explore Training', isDark: isDark, onTap: () => context.go('/training')),
                      ],
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _PrimaryButton(label: 'Get Started Free', onTap: () => context.go('/signup')),
                        const SizedBox(width: 16),
                        _OutlineButton(label: 'Explore Training', isDark: isDark, onTap: () => context.go('/training')),
                      ],
                    ),
              SizedBox(height: isMobile ? 32 : 56),
              Wrap(
                alignment: WrapAlignment.center,
                spacing: isMobile ? 16 : 24,
                runSpacing: isMobile ? 16 : 24,
                children: [
                  _StatItem(value: '10K+', label: 'Active Athletes', isDark: isDark),
                  _StatItem(value: '500+', label: 'Expert Coaches', isDark: isDark),
                  _StatItem(value: '200+', label: 'Events Monthly', isDark: isDark),
                  _StatItem(value: '4.9★', label: 'App Rating', isDark: isDark),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  const _PrimaryButton({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: WebColors.primaryGradient, borderRadius: BorderRadius.circular(12)),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            child: Text(label, style: const TextStyle(color: WebColors.white, fontWeight: FontWeight.w600, fontSize: 16)),
          ),
        ),
      ),
    );
  }
}

class _OutlineButton extends StatelessWidget {
  final String label;
  final bool isDark;
  final VoidCallback onTap;
  const _OutlineButton({required this.label, required this.isDark, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: isDark ? WebColors.darkBorder : WebColors.grey300),
        ),
        child: Text(label,
            style: TextStyle(color: isDark ? WebColors.darkTextPrimary : WebColors.textPrimary, fontWeight: FontWeight.w600, fontSize: 16)),
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String value;
  final String label;
  final bool isDark;
  const _StatItem({required this.value, required this.label, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          Text(value, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: WebColors.primary)),
          const SizedBox(height: 4),
          Text(label, style: TextStyle(fontSize: 14, color: isDark ? WebColors.darkTextSecondary : WebColors.textSecondary)),
        ],
      ),
    );
  }
}

class _TrustedBySection extends StatelessWidget {
  final bool isDark;
  const _TrustedBySection({required this.isDark});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;
    final isTablet = screenWidth >= 768 && screenWidth < 1024;
    final orgs = ['Sports Authority of India', 'Olympic Committee', 'Fit India', 'Running Club India', 'National Sports Federation'];
    return Container(
      padding: EdgeInsets.symmetric(vertical: isMobile ? 24 : 48),
      color: isDark ? WebColors.darkSurface : WebColors.white,
      child: Column(
        children: [
          Text('Trusted By Leading Organizations',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: isDark ? WebColors.darkTextHint : WebColors.grey500)),
          const SizedBox(height: 24),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: isMobile ? 16 : 32,
            runSpacing: isMobile ? 12 : 16,
            children: orgs.map((org) => Padding(
              padding: EdgeInsets.symmetric(horizontal: isMobile ? 4 : 16),
              child: Text(org,
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: isDark ? WebColors.darkTextSecondary : WebColors.grey400)),
            )).toList(),
          ),
        ],
      ),
    );
  }
}

class _FeaturesSection extends StatelessWidget {
  final bool isDark;
  const _FeaturesSection({required this.isDark});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;
    final isTablet = screenWidth >= 768 && screenWidth < 1024;
    final features = [
      _Feature(Icons.school, 'Expert Coaching', 'Connect with certified coaches across 20+ sports.'),
      _Feature(Icons.event, 'Event Discovery', 'Find and register for marathons, triathlons, and more.'),
      _Feature(Icons.fitness_center, 'Training Plans', 'Structured plans for every level, from beginner to pro.'),
      _Feature(Icons.confirmation_number, 'Digital Tickets', 'Paperless tickets with QR codes for seamless entry.'),
      _Feature(Icons.analytics, 'Performance Tracking', 'Track your progress with detailed analytics.'),
      _Feature(Icons.group, 'Community', 'Join a community of 10,000+ like-minded athletes.'),
    ];
    return Container(
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 16 : (isTablet ? 24 : 48), vertical: isMobile ? 40 : 80),
      color: isDark ? WebColors.darkBackground : WebColors.grey50,
      child: Column(
        children: [
          Text('Everything You Need',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: WebColors.primary)),
          const SizedBox(height: 12),
          Text('Powerful Features for Athletes',
              style: TextStyle(fontSize: isMobile ? 24 : (isTablet ? 32 : 36), fontWeight: FontWeight.bold, color: isDark ? WebColors.darkTextPrimary : WebColors.textPrimary)),
          const SizedBox(height: 16),
          Text('All the tools you need to train smarter, compete better, and achieve your goals.',
              style: TextStyle(fontSize: isMobile ? 14 : 16, color: isDark ? WebColors.darkTextSecondary : WebColors.textSecondary)),
          SizedBox(height: isMobile ? 24 : 48),
          Wrap(
            spacing: isMobile ? 16 : 32,
            runSpacing: isMobile ? 16 : 32,
            children: features.map((f) => SizedBox(
              width: isMobile ? double.infinity : 300,
              child: Container(
                padding: const EdgeInsets.all(28),
                decoration: BoxDecoration(
                  color: isDark ? WebColors.darkCard : WebColors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: isDark ? WebColors.darkBorder : WebColors.grey100),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: WebColors.primary.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(f.icon, color: WebColors.primary),
                    ),
                    const SizedBox(height: 16),
                    Text(f.title,
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: isDark ? WebColors.darkTextPrimary : WebColors.textPrimary)),
                    const SizedBox(height: 8),
                    Text(f.description,
                        style: TextStyle(fontSize: 14, color: isDark ? WebColors.darkTextSecondary : WebColors.textSecondary)),
                  ],
                ),
              ),
            )).toList(),
          ),
        ],
      ),
    );
  }
}

class _Feature {
  final IconData icon;
  final String title;
  final String description;
  const _Feature(this.icon, this.title, this.description);
}

class _HowItWorksSection extends StatelessWidget {
  final bool isDark;
  const _HowItWorksSection({required this.isDark});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;
    final isTablet = screenWidth >= 768 && screenWidth < 1024;
    final steps = [
      _Step('01', 'Create Account', 'Sign up in seconds and set your athletic goals.'),
      _Step('02', 'Choose Your Path', 'Browse coaches, training plans, and events.'),
      _Step('03', 'Train & Compete', 'Follow your plan, track progress, and race.'),
    ];
    return Container(
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 16 : (isTablet ? 24 : 48), vertical: isMobile ? 40 : 80),
      color: isDark ? WebColors.darkSurface : WebColors.white,
      child: Column(
        children: [
          Text('How It Works', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: WebColors.primary)),
          const SizedBox(height: 12),
          Text('Get Started in 3 Steps',
              style: TextStyle(fontSize: isMobile ? 24 : (isTablet ? 32 : 36), fontWeight: FontWeight.bold, color: isDark ? WebColors.darkTextPrimary : WebColors.textPrimary)),
          SizedBox(height: isMobile ? 24 : 48),
          isMobile
              ? Column(
                  children: steps.map((s) => Padding(
                    padding: const EdgeInsets.only(bottom: 32),
                    child: Column(
                      children: [
                        Container(
                          width: 64,
                          height: 64,
                          decoration: BoxDecoration(
                            gradient: WebColors.primaryGradient,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Center(
                            child: Text(s.num, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: WebColors.white)),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(s.title,
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: isDark ? WebColors.darkTextPrimary : WebColors.textPrimary)),
                        const SizedBox(height: 8),
                        Text(s.description,
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 14, color: isDark ? WebColors.darkTextSecondary : WebColors.textSecondary)),
                      ],
                    ),
                  )).toList(),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: steps.map((s) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: Column(
                      children: [
                        Container(
                          width: 64,
                          height: 64,
                          decoration: BoxDecoration(
                            gradient: WebColors.primaryGradient,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Center(
                            child: Text(s.num, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: WebColors.white)),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(s.title,
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: isDark ? WebColors.darkTextPrimary : WebColors.textPrimary)),
                        const SizedBox(height: 8),
                        Text(s.description,
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 14, color: isDark ? WebColors.darkTextSecondary : WebColors.textSecondary)),
                      ],
                    ),
                  )).toList(),
                ),
        ],
      ),
    );
  }
}

class _Step {
  final String num;
  final String title;
  final String description;
  const _Step(this.num, this.title, this.description);
}

class _StatsSection extends StatelessWidget {
  final bool isDark;
  const _StatsSection({required this.isDark});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;
    final isTablet = screenWidth >= 768 && screenWidth < 1024;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 16 : (isTablet ? 24 : 48), vertical: isMobile ? 32 : 64),
      decoration: const BoxDecoration(gradient: WebColors.heroGradient),
      child: Wrap(
        alignment: WrapAlignment.center,
        spacing: isMobile ? 16 : 48,
        runSpacing: isMobile ? 24 : 32,
        children: const [
          _HeroStat(value: '10,000+', label: 'Active Athletes'),
          _HeroStat(value: '500+', label: 'Expert Coaches'),
          _HeroStat(value: '2,000+', label: 'Events Completed'),
          _HeroStat(value: '98%', label: 'Satisfaction Rate'),
        ],
      ),
    );
  }
}

class _HeroStat extends StatelessWidget {
  final String value;
  final String label;
  const _HeroStat({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 48),
      child: Column(
        children: [
          Text(value, style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: WebColors.white)),
          const SizedBox(height: 4),
          Text(label, style: const TextStyle(fontSize: 14, color: WebColors.white70)),
        ],
      ),
    );
  }
}

class _TestimonialsSection extends StatelessWidget {
  final bool isDark;
  const _TestimonialsSection({required this.isDark});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;
    final isTablet = screenWidth >= 768 && screenWidth < 1024;
    final testimonials = [
      _Testimonial('Arjun Mehta', 'Marathon Runner', 'Veltrix Sports completely changed how I train. My coach found here helped me cut 20 minutes off my marathon PR!'),
      _Testimonial('Priya Sharma', 'Triathlete', 'The event discovery feature is amazing. I found 3 triathlons in my first month and booked them all through the app.'),
      _Testimonial('Rahul Verma', 'Cycling Enthusiast', 'Best sports platform in India. The training plans are structured and the community keeps me motivated.'),
    ];
    return Container(
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 16 : (isTablet ? 24 : 48), vertical: isMobile ? 40 : 80),
      color: isDark ? WebColors.darkBackground : WebColors.grey50,
      child: Column(
        children: [
          Text('What Athletes Say', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: WebColors.primary)),
          const SizedBox(height: 12),
          Text('Loved by Athletes',
              style: TextStyle(fontSize: isMobile ? 24 : (isTablet ? 32 : 36), fontWeight: FontWeight.bold, color: isDark ? WebColors.darkTextPrimary : WebColors.textPrimary)),
          SizedBox(height: isMobile ? 24 : 48),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: isMobile ? 12 : 16,
            runSpacing: isMobile ? 16 : 24,
            children: testimonials.map((t) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0),
              child: SizedBox(
                width: isMobile ? double.infinity : 320,
                child: Container(
                  padding: const EdgeInsets.all(28),
                  decoration: BoxDecoration(
                    color: isDark ? WebColors.darkCard : WebColors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: isDark ? WebColors.darkBorder : WebColors.grey100),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(children: [
                        Icon(Icons.star, color: Colors.amber, size: 18),
                        Icon(Icons.star, color: Colors.amber, size: 18),
                        Icon(Icons.star, color: Colors.amber, size: 18),
                        Icon(Icons.star, color: Colors.amber, size: 18),
                        Icon(Icons.star, color: Colors.amber, size: 18),
                      ]),
                      const SizedBox(height: 16),
                      Text('"${t.quote}"',
                          style: TextStyle(fontSize: 14, color: isDark ? WebColors.darkTextSecondary : WebColors.textSecondary, height: 1.6)),
                      const SizedBox(height: 16),
                      Text(t.name,
                          style: TextStyle(fontWeight: FontWeight.w600, color: isDark ? WebColors.darkTextPrimary : WebColors.textPrimary)),
                      const SizedBox(height: 4),
                      Text(t.role, style: TextStyle(fontSize: 13, color: isDark ? WebColors.darkTextHint : WebColors.grey500)),
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

class _Testimonial {
  final String name;
  final String role;
  final String quote;
  const _Testimonial(this.name, this.role, this.quote);
}

class _CTASection extends StatelessWidget {
  final bool isDark;
  const _CTASection({required this.isDark});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;
    final isTablet = screenWidth >= 768 && screenWidth < 1024;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 16 : (isTablet ? 24 : 48), vertical: isMobile ? 40 : 80),
      color: isDark ? WebColors.darkSurface : WebColors.white,
      child: Center(
        child: Container(
          padding: EdgeInsets.all(isMobile ? 24 : 56),
          decoration: BoxDecoration(
            gradient: WebColors.heroGradient,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Column(
            children: [
              Text('Ready to Level Up Your Game?',
                  style: TextStyle(fontSize: isMobile ? 22 : 32, fontWeight: FontWeight.bold, color: WebColors.white)),
              const SizedBox(height: 16),
              Text('Join 10,000+ athletes already training smarter with Veltrix Sports.',
                  style: TextStyle(fontSize: isMobile ? 14 : 16, color: WebColors.white70)),
              const SizedBox(height: 32),
              Container(
                decoration: BoxDecoration(color: WebColors.white, borderRadius: BorderRadius.circular(12)),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: () => context.go('/signup'),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: isMobile ? 20 : 32, vertical: 16),
                      child: Text('Get Started Free →', style: TextStyle(color: WebColors.primary, fontWeight: FontWeight.bold, fontSize: isMobile ? 14 : 16)),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
