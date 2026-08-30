import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/web_colors.dart';
import '../../core/providers/web_providers.dart';

class WebSettingsScreen extends ConsumerStatefulWidget {
  const WebSettingsScreen({super.key});

  @override
  ConsumerState<WebSettingsScreen> createState() => _WebSettingsScreenState();
}

class _WebSettingsScreenState extends ConsumerState<WebSettingsScreen> {
  bool _pushNotifications = true;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;
    final isTablet = screenWidth >= 768 && screenWidth < 1024;
    final isDark = ref.watch(webDarkModeProvider);

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 600),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(isMobile ? 16 : 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Settings',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: isDark ? WebColors.darkTextPrimary : WebColors.textPrimary,
                ),
              ),
              const SizedBox(height: 24),
              _sectionTitle('Appearance', isDark),
              const SizedBox(height: 8),
              _card(isDark, [
                SwitchListTile(
                  title: Text('Dark Mode', style: TextStyle(color: isDark ? WebColors.darkTextPrimary : WebColors.textPrimary)),
                  subtitle: Text('Use dark theme', style: TextStyle(fontSize: 13, color: isDark ? WebColors.darkTextSecondary : WebColors.grey500)),
                  value: isDark,
                  activeColor: WebColors.primary,
                  onChanged: (v) => ref.read(webDarkModeProvider.notifier).state = v,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                ),
              ]),
              const SizedBox(height: 20),
              _sectionTitle('Notifications', isDark),
              const SizedBox(height: 8),
              _card(isDark, [
                SwitchListTile(
                  title: Text('Push Notifications', style: TextStyle(color: isDark ? WebColors.darkTextPrimary : WebColors.textPrimary)),
                  subtitle: Text('Receive push notifications', style: TextStyle(fontSize: 13, color: isDark ? WebColors.darkTextSecondary : WebColors.grey500)),
                  value: _pushNotifications,
                  activeColor: WebColors.primary,
                  onChanged: (v) => setState(() => _pushNotifications = v),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                ),
              ]),
              const SizedBox(height: 20),
              _sectionTitle('Account', isDark),
              const SizedBox(height: 8),
              _card(isDark, [
                _tile(Icons.edit_outlined, 'Edit Profile', isDark, () => context.go('/profile/edit')),
                _divider(isDark),
                _tile(Icons.lock_outline, 'Change Password', isDark, () {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Password change coming soon!')));
                }),
                _divider(isDark),
                _tile(Icons.language, 'Language', isDark, () {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Language settings coming soon!')));
                }),
              ]),
              const SizedBox(height: 20),
              _sectionTitle('Legal', isDark),
              const SizedBox(height: 8),
              _card(isDark, [
                _tile(Icons.privacy_tip_outlined, 'Privacy Policy', isDark, () {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Privacy Policy coming soon!')));
                }),
                _divider(isDark),
                _tile(Icons.description_outlined, 'Terms of Service', isDark, () {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Terms of Service coming soon!')));
                }),
              ]),
              const SizedBox(height: 20),
              _sectionTitle('Danger Zone', isDark),
              const SizedBox(height: 8),
              _card(isDark, [
                ListTile(
                  leading: const Icon(Icons.delete_outline, color: WebColors.error),
                  title: const Text('Delete Account', style: TextStyle(color: WebColors.error, fontWeight: FontWeight.w600)),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                  onTap: () => _showDeleteDialog(context),
                ),
              ]),
            ],
          ),
        ),
      ),
    );
  }

  void _showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete Account'),
        content: const Text('Are you sure you want to delete your account? This action cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Account deleted (placeholder)')));
            },
            child: const Text('Delete', style: TextStyle(color: WebColors.error)),
          ),
        ],
      ),
    );
  }

  Widget _sectionTitle(String title, bool isDark) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: isDark ? WebColors.darkTextSecondary : WebColors.grey600,
      ),
    );
  }

  Widget _card(bool isDark, List<Widget> children) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: isDark ? WebColors.darkCard : WebColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: isDark ? WebColors.darkBorder : WebColors.grey100),
      ),
      child: Column(children: children),
    );
  }

  Widget _tile(IconData icon, String label, bool isDark, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: isDark ? WebColors.darkTextSecondary : WebColors.grey600),
      title: Text(label, style: TextStyle(color: isDark ? WebColors.darkTextPrimary : WebColors.textPrimary)),
      trailing: Icon(Icons.chevron_right, color: isDark ? WebColors.darkTextHint : WebColors.grey400),
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
    );
  }

  Widget _divider(bool isDark) {
    return Divider(height: 1, color: isDark ? WebColors.darkBorder : WebColors.grey100, indent: 56);
  }
}
