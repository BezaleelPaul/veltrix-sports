import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/web_colors.dart';
import '../../core/providers/web_providers.dart';
import '../../../../core/mock/mock_data.dart';

class WebProfileScreen extends ConsumerWidget {
  const WebProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;
    final isTablet = screenWidth >= 768 && screenWidth < 1024;
    final isDark = ref.watch(webDarkModeProvider);
    final user = MockData.currentUser;
    final initial = user.name.isNotEmpty ? user.name[0].toUpperCase() : '?';

    final menuItems = [
      _MenuItem(Icons.edit, 'Edit Profile', '/profile/edit'),
      _MenuItem(Icons.notifications_outlined, 'Notifications', '/notifications'),
      _MenuItem(Icons.bar_chart, 'Progress', '/progress'),
      _MenuItem(Icons.search, 'Search', '/search'),
      _MenuItem(Icons.settings, 'Settings', '/settings'),
      _MenuItem(Icons.help_outline, 'Help & Support', '/help'),
      _MenuItem(Icons.info_outline, 'About', '/about'),
    ];

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 600),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(isMobile ? 16 : 32),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(32),
                decoration: BoxDecoration(
                  color: isDark ? WebColors.darkCard : WebColors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: isDark ? WebColors.darkBorder : WebColors.grey100),
                ),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: WebColors.primary.withValues(alpha: 0.15),
                      child: Text(
                        initial,
                        style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: WebColors.primary),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      user.name,
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: isDark ? WebColors.darkTextPrimary : WebColors.textPrimary),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      user.email,
                      style: TextStyle(fontSize: 14, color: isDark ? WebColors.darkTextSecondary : WebColors.textSecondary),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: isDark ? WebColors.darkCard : WebColors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: isDark ? WebColors.darkBorder : WebColors.grey100),
                ),
                child: Column(
                  children: menuItems.map((item) {
                    final isLast = item == menuItems.last;
                    return Column(
                      children: [
                        ListTile(
                          leading: Icon(item.icon, color: isDark ? WebColors.darkTextSecondary : WebColors.grey600),
                          title: Text(
                            item.label,
                            style: TextStyle(color: isDark ? WebColors.darkTextPrimary : WebColors.textPrimary),
                          ),
                          trailing: Icon(Icons.chevron_right, color: isDark ? WebColors.darkTextHint : WebColors.grey400),
                          onTap: () => context.go(item.route),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                        ),
                        if (!isLast)
                          Divider(height: 1, color: isDark ? WebColors.darkBorder : WebColors.grey100, indent: 56),
                      ],
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () => context.go('/login'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: WebColors.error,
                    side: const BorderSide(color: WebColors.error),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text('Logout', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MenuItem {
  final IconData icon;
  final String label;
  final String route;
  const _MenuItem(this.icon, this.label, this.route);
}
