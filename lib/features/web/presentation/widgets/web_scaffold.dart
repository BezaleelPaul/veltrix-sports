import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/web_colors.dart';
import '../../core/providers/web_providers.dart';

class WebScaffold extends ConsumerWidget {
  final Widget child;

  const WebScaffold({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = ref.watch(webDarkModeProvider);

    return Scaffold(
      backgroundColor: isDark ? WebColors.darkBackground : WebColors.white,
      body: Column(
        children: [
          WebHeader(isDark: isDark, onToggleDark: () {
            ref.read(webDarkModeProvider.notifier).state = !isDark;
          }),
          Expanded(child: child),
          WebFooter(isDark: isDark),
        ],
      ),
    );
  }
}

class WebHeader extends StatelessWidget {
  final bool isDark;
  final VoidCallback onToggleDark;

  const WebHeader({super.key, required this.isDark, required this.onToggleDark});

  @override
  Widget build(BuildContext context) {
    final currentPath = GoRouterState.of(context).uri.toString();
    final bgColor = isDark ? WebColors.darkSurface : WebColors.white;
    final textColor = isDark ? WebColors.darkTextPrimary : WebColors.textPrimary;
    final secondaryText = isDark ? WebColors.darkTextSecondary : WebColors.textSecondary;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 16),
      decoration: BoxDecoration(
        color: bgColor,
        boxShadow: [
          BoxShadow(
            color: (isDark ? Colors.black : Colors.black).withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Logo
          GestureDetector(
            onTap: () => context.go('/'),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: WebColors.primary,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(Icons.fitness_center, color: WebColors.white, size: 24),
                ),
                const SizedBox(width: 12),
                Text(
                  'Veltrix Sports',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: textColor),
                ),
              ],
            ),
          ),
          const SizedBox(width: 48),
          // Nav Links
          _buildNavLink(context, 'Home', '/', currentPath, textColor, secondaryText),
          _buildNavLink(context, 'Training', '/training', currentPath, textColor, secondaryText),
          _buildNavLink(context, 'Events', '/events', currentPath, textColor, secondaryText),
          _buildNavLink(context, 'Coaches', '/coaches', currentPath, textColor, secondaryText),
          _buildNavLink(context, 'Pricing', '/pricing', currentPath, textColor, secondaryText),
          _buildNavLink(context, 'About', '/about', currentPath, textColor, secondaryText),
          const Spacer(),
          // Dark Mode Toggle
          IconButton(
            onPressed: onToggleDark,
            icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode, color: secondaryText),
            tooltip: isDark ? 'Switch to Light Mode' : 'Switch to Dark Mode',
          ),
          const SizedBox(width: 8),
          // CTA Buttons
          TextButton(
            onPressed: () => context.go('/login'),
            child: Text('Log In', style: TextStyle(color: textColor, fontWeight: FontWeight.w600)),
          ),
          const SizedBox(width: 16),
          ElevatedButton(
            onPressed: () => context.go('/signup'),
            style: ElevatedButton.styleFrom(
              backgroundColor: WebColors.primary,
              foregroundColor: WebColors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            child: const Text('Get Started'),
          ),
        ],
      ),
    );
  }

  Widget _buildNavLink(BuildContext context, String label, String path, String currentPath, Color activeColor, Color inactiveColor) {
    final isActive = currentPath == path;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: GestureDetector(
        onTap: () => context.go(path),
        child: Text(
          label,
          style: TextStyle(
            color: isActive ? WebColors.primary : inactiveColor,
            fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
            fontSize: 15,
          ),
        ),
      ),
    );
  }
}

class WebFooter extends StatelessWidget {
  final bool isDark;

  const WebFooter({super.key, required this.isDark});

  @override
  Widget build(BuildContext context) {
    final bgColor = isDark ? WebColors.darkSurface : WebColors.grey900;
    final textColor = isDark ? WebColors.darkTextPrimary : WebColors.white;
    final secondaryText = isDark ? WebColors.darkTextSecondary : WebColors.grey400;
    final mutedText = isDark ? WebColors.darkTextHint : WebColors.grey500;
    final linkColor = isDark ? WebColors.darkTextSecondary : WebColors.grey400;

    return Container(
      padding: const EdgeInsets.all(48),
      decoration: BoxDecoration(color: bgColor),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Brand
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                            color: WebColors.primary,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(Icons.fitness_center, color: WebColors.white, size: 20),
                        ),
                        const SizedBox(width: 10),
                        Text('Veltrix Sports', style: TextStyle(color: textColor, fontSize: 20, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Your complete sports platform for coaching,\nevents, and ticketing.',
                      style: TextStyle(color: secondaryText, fontSize: 14, height: 1.5),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        _buildSocialIcon(Icons.facebook, linkColor),
                        const SizedBox(width: 12),
                        _buildSocialIcon(Icons.camera_alt, linkColor),
                        const SizedBox(width: 12),
                        _buildSocialIcon(Icons.cancel, linkColor),
                        const SizedBox(width: 12),
                        _buildSocialIcon(Icons.link, linkColor),
                      ],
                    ),
                  ],
                ),
              ),
              _buildFooterColumn('Platform', ['Training Plans', 'Events', 'Coaches', 'Ticketing'], textColor, linkColor),
              _buildFooterColumn('Company', ['About Us', 'Careers', 'Blog', 'Press'], textColor, linkColor),
              _buildFooterColumn('Support', ['Help Center', 'Contact Us', 'Privacy Policy', 'Terms of Service'], textColor, linkColor),
            ],
          ),
          const SizedBox(height: 40),
          Divider(color: isDark ? WebColors.darkBorder : WebColors.grey700),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('© 2026 Veltrix Sports. All rights reserved.', style: TextStyle(color: mutedText, fontSize: 14)),
              Row(
                children: [
                  Text('Made with ', style: TextStyle(color: mutedText, fontSize: 14)),
                  const Icon(Icons.favorite, color: WebColors.error, size: 14),
                  Text(' in India', style: TextStyle(color: mutedText, fontSize: 14)),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSocialIcon(IconData icon, Color color) {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        color: isDark ? WebColors.darkBackground : WebColors.grey800,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(icon, color: color, size: 18),
    );
  }

  Widget _buildFooterColumn(String title, List<String> links, Color titleColor, Color linkColor) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(color: titleColor, fontWeight: FontWeight.w600, fontSize: 16)),
          const SizedBox(height: 16),
          ...links.map((link) => Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Text(link, style: TextStyle(color: linkColor, fontSize: 14)),
          )),
        ],
      ),
    );
  }
}
