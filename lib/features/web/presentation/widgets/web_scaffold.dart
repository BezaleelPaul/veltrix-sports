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
          WebHeader(isDark: isDark, onToggleDark: () => ref.read(webDarkModeProvider.notifier).state = !isDark),
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
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 16),
      decoration: BoxDecoration(
        color: isDark ? WebColors.darkSurface : WebColors.white,
        border: Border(bottom: BorderSide(color: isDark ? WebColors.darkBorder : WebColors.grey200)),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => context.go('/'),
            child: Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    gradient: WebColors.heroGradient,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.play_arrow, color: WebColors.white, size: 24),
                ),
                const SizedBox(width: 10),
                Text(
                  'Veltrix Sports',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: isDark ? WebColors.darkTextPrimary : WebColors.textPrimary,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 48),
          _NavLink(label: 'Home', path: '/', isDark: isDark),
          _NavLink(label: 'Training', path: '/training', isDark: isDark),
          _NavLink(label: 'Events', path: '/events', isDark: isDark),
          _NavLink(label: 'Coaches', path: '/coaches', isDark: isDark),
          _NavLink(label: 'Pricing', path: '/pricing', isDark: isDark),
          _NavLink(label: 'About', path: '/about', isDark: isDark),
          const Spacer(),
          IconButton(
            icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode, color: isDark ? WebColors.darkTextSecondary : WebColors.grey600),
            onPressed: onToggleDark,
          ),
          const SizedBox(width: 12),
          TextButton(
            onPressed: () => context.go('/login'),
            child: Text('Log In', style: TextStyle(color: isDark ? WebColors.darkTextPrimary : WebColors.textPrimary)),
          ),
          const SizedBox(width: 12),
          Container(
            decoration: BoxDecoration(
              gradient: WebColors.primaryGradient,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(8),
                onTap: () => context.go('/signup'),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Text('Get Started', style: TextStyle(color: WebColors.white, fontWeight: FontWeight.w600)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _NavLink extends StatelessWidget {
  final String label;
  final String path;
  final bool isDark;

  const _NavLink({required this.label, required this.path, required this.isDark});

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    final isActive = location == path;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: TextButton(
        onPressed: () => context.go(path),
        child: Text(
          label,
          style: TextStyle(
            color: isActive
                ? WebColors.primary
                : isDark
                    ? WebColors.darkTextSecondary
                    : WebColors.textSecondary,
            fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
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
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 48),
      decoration: BoxDecoration(
        color: isDark ? WebColors.darkSurface : WebColors.grey50,
        border: Border(top: BorderSide(color: isDark ? WebColors.darkBorder : WebColors.grey200)),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            gradient: WebColors.heroGradient,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: const Icon(Icons.play_arrow, color: WebColors.white, size: 20),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Veltrix Sports',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: isDark ? WebColors.darkTextPrimary : WebColors.textPrimary,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'The complete sports platform for athletes, coaches, and event organizers.',
                      style: TextStyle(color: isDark ? WebColors.darkTextSecondary : WebColors.textSecondary, fontSize: 14),
                    ),
                  ],
                ),
              ),
              _FooterColumn(
                title: 'Platform',
                links: ['Training Plans', 'Find Events', 'Find Coaches', 'Pricing'],
                isDark: isDark,
              ),
              _FooterColumn(
                title: 'Company',
                links: ['About Us', 'Contact', 'Careers', 'Blog'],
                isDark: isDark,
              ),
              _FooterColumn(
                title: 'Support',
                links: ['Help Center', 'Privacy Policy', 'Terms of Service', 'FAQ'],
                isDark: isDark,
              ),
            ],
          ),
          const SizedBox(height: 32),
          Divider(color: isDark ? WebColors.darkBorder : WebColors.grey200),
          const SizedBox(height: 16),
          Text(
            '© 2026 Veltrix Sports. All rights reserved.',
            style: TextStyle(color: isDark ? WebColors.darkTextHint : WebColors.grey500, fontSize: 13),
          ),
        ],
      ),
    );
  }
}

class _FooterColumn extends StatelessWidget {
  final String title;
  final List<String> links;
  final bool isDark;

  const _FooterColumn({required this.title, required this.links, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: isDark ? WebColors.darkTextPrimary : WebColors.textPrimary,
            ),
          ),
          const SizedBox(height: 12),
          ...links.map(
            (link) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text(
                link,
                style: TextStyle(color: isDark ? WebColors.darkTextSecondary : WebColors.textSecondary, fontSize: 14),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
