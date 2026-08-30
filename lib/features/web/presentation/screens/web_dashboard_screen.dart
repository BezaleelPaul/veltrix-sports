import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/web_colors.dart';
import '../../core/providers/web_providers.dart';

class WebDashboardScreen extends ConsumerWidget {
  const WebDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;
    final isTablet = screenWidth >= 768 && screenWidth < 1024;
    final isDark = ref.watch(webDarkModeProvider);
    final location = GoRouterState.of(context).uri.toString();

    return isMobile
        ? Column(
            children: [
              Expanded(
                child: _DashboardContent(isDark: isDark),
              ),
            ],
          )
        : Row(
      children: [
        Container(
          width: 240,
          decoration: BoxDecoration(
            color: isDark ? WebColors.darkSurface : WebColors.white,
            border: Border(right: BorderSide(color: isDark ? WebColors.darkBorder : WebColors.grey200)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(24),
                child: Row(
                  children: [
                    Container(
                      width: 32, height: 32,
                      decoration: BoxDecoration(gradient: WebColors.heroGradient, borderRadius: BorderRadius.circular(6)),
                      child: const Icon(Icons.play_arrow, color: WebColors.white, size: 20),
                    ),
                    const SizedBox(width: 8),
                    Text('Veltrix Sports', style: TextStyle(fontWeight: FontWeight.bold, color: isDark ? WebColors.darkTextPrimary : WebColors.textPrimary)),
                  ],
                ),
              ),
              Divider(color: isDark ? WebColors.darkBorder : WebColors.grey200),
              const SizedBox(height: 8),
              _SidebarSection(label: 'Main', isDark: isDark),
              _SidebarItem(icon: Icons.dashboard, label: 'Dashboard', isActive: location == '/dashboard', onTap: () => context.go('/dashboard'), isDark: isDark),
              _SidebarItem(icon: Icons.confirmation_number, label: 'My Tickets', isActive: location.contains('/dashboard/tickets'), onTap: () => context.go('/dashboard/tickets'), isDark: isDark),
              const SizedBox(height: 8),
              _SidebarSection(label: 'Explore', isDark: isDark),
              _SidebarItem(icon: Icons.school, label: 'Training', isActive: location.startsWith('/training'), onTap: () => context.go('/training'), isDark: isDark),
              _SidebarItem(icon: Icons.event, label: 'Events', isActive: location.startsWith('/events'), onTap: () => context.go('/events'), isDark: isDark),
              _SidebarItem(icon: Icons.person, label: 'Coaches', isActive: location.startsWith('/coaches'), onTap: () => context.go('/coaches'), isDark: isDark),
              const SizedBox(height: 8),
              _SidebarSection(label: 'Account', isDark: isDark),
              _SidebarItem(icon: Icons.account_circle, label: 'Profile', isActive: location.startsWith('/profile'), onTap: () => context.go('/profile'), isDark: isDark),
              _SidebarItem(icon: Icons.search, label: 'Search', isActive: location.startsWith('/search'), onTap: () => context.go('/search'), isDark: isDark),
              _SidebarItem(icon: Icons.notifications, label: 'Notifications', isActive: location.startsWith('/notifications'), onTap: () => context.go('/notifications'), isDark: isDark),
              _SidebarItem(icon: Icons.trending_up, label: 'Progress', isActive: location.startsWith('/progress'), onTap: () => context.go('/progress'), isDark: isDark),
              _SidebarItem(icon: Icons.settings, label: 'Settings', isActive: location.startsWith('/settings'), onTap: () => context.go('/settings'), isDark: isDark),
              _SidebarItem(icon: Icons.help_outline, label: 'Help', isActive: location.startsWith('/help'), onTap: () => context.go('/help'), isDark: isDark),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: WebColors.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Need Help?', style: TextStyle(fontWeight: FontWeight.w600, color: WebColors.primary)),
                      const SizedBox(height: 4),
                      Text('Contact our support team', style: TextStyle(fontSize: 12, color: isDark ? WebColors.darkTextSecondary : WebColors.grey600)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: _DashboardContent(isDark: isDark),
        ),
      ],
    );
  }
}

class _SidebarSection extends StatelessWidget {
  final String label;
  final bool isDark;
  const _SidebarSection({required this.label, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
          color: isDark ? WebColors.darkTextSecondary : WebColors.grey500,
        ),
      ),
    );
  }
}

class _SidebarItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;
  final bool isDark;
  const _SidebarItem({required this.icon, required this.label, required this.isActive, required this.onTap, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
      child: Material(
        color: isActive ? WebColors.primary.withValues(alpha: 0.1) : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Row(
              children: [
                Icon(icon, size: 20, color: isActive ? WebColors.primary : (isDark ? WebColors.darkTextSecondary : WebColors.grey600)),
                const SizedBox(width: 12),
                Text(label, style: TextStyle(
                  fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
                  color: isActive ? WebColors.primary : (isDark ? WebColors.darkTextSecondary : WebColors.grey700),
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _DashboardContent extends StatelessWidget {
  final bool isDark;
  const _DashboardContent({required this.isDark});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;
    final isTablet = screenWidth >= 768 && screenWidth < 1024;
    final stats = [
      _DashStat(Icons.event, 'Registered Events', '3', WebColors.primary),
      _DashStat(Icons.school, 'Active Plans', '2', WebColors.accent),
      _DashStat(Icons.confirmation_number, 'Tickets', '2', WebColors.secondary),
      _DashStat(Icons.star, 'Avg Rating', '4.8', Colors.amber),
    ];

    return SingleChildScrollView(
      padding: EdgeInsets.all(isMobile ? 16 : 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Dashboard', style: TextStyle(fontSize: isMobile ? 22 : 28, fontWeight: FontWeight.bold, color: isDark ? WebColors.darkTextPrimary : WebColors.textPrimary)),
          const SizedBox(height: 8),
          Text('Welcome back! Here\'s an overview of your account.', style: TextStyle(color: isDark ? WebColors.darkTextSecondary : WebColors.textSecondary)),
          const SizedBox(height: 32),
          isMobile
              ? Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: stats.map((s) => SizedBox(
                    width: (MediaQuery.of(context).size.width - 44) / 2,
                    child: Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: isDark ? WebColors.darkCard : WebColors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: isDark ? WebColors.darkBorder : WebColors.grey100),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(s.icon, color: s.color, size: 28),
                          const SizedBox(height: 12),
                          Text(s.value, style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: isDark ? WebColors.darkTextPrimary : WebColors.textPrimary)),
                          const SizedBox(height: 4),
                          Text(s.label, style: TextStyle(fontSize: 13, color: isDark ? WebColors.darkTextSecondary : WebColors.grey500)),
                        ],
                      ),
                    ),
                  )).toList(),
                )
              : Row(
                  children: stats.map((s) => Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: isDark ? WebColors.darkCard : WebColors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: isDark ? WebColors.darkBorder : WebColors.grey100),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(s.icon, color: s.color, size: 28),
                            const SizedBox(height: 12),
                            Text(s.value, style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: isDark ? WebColors.darkTextPrimary : WebColors.textPrimary)),
                            const SizedBox(height: 4),
                            Text(s.label, style: TextStyle(fontSize: 13, color: isDark ? WebColors.darkTextSecondary : WebColors.grey500)),
                          ],
                        ),
                      ),
                    ),
                  )).toList(),
                ),
          const SizedBox(height: 32),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: isDark ? WebColors.darkCard : WebColors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: isDark ? WebColors.darkBorder : WebColors.grey100),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Recent Activity', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: isDark ? WebColors.darkTextPrimary : WebColors.textPrimary)),
                const SizedBox(height: 16),
                _ActivityRow(icon: Icons.check_circle, color: WebColors.accent, text: 'Completed Marathon Training - Week 8', time: '2 hours ago', isDark: isDark),
                _ActivityRow(icon: Icons.event, color: WebColors.primary, text: 'Registered for Mumbai Marathon 2026', time: '1 day ago', isDark: isDark),
                _ActivityRow(icon: Icons.school, color: WebColors.secondary, text: 'Enrolled in Swimming Mastery', time: '3 days ago', isDark: isDark),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DashStat {
  final IconData icon;
  final String label;
  final String value;
  final Color color;
  const _DashStat(this.icon, this.label, this.value, this.color);
}

class _ActivityRow extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String text;
  final String time;
  final bool isDark;
  const _ActivityRow({required this.icon, required this.color, required this.text, required this.time, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(width: 12),
          Expanded(child: Text(text, style: TextStyle(color: isDark ? WebColors.darkTextPrimary : WebColors.textPrimary))),
          Text(time, style: TextStyle(fontSize: 13, color: isDark ? WebColors.darkTextHint : WebColors.grey500)),
        ],
      ),
    );
  }
}
