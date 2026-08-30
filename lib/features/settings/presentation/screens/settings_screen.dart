import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/providers/auth_provider.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  bool _notificationsEnabled = true;
  bool _emailNotifications = true;
  String _language = 'English';

  @override
  Widget build(BuildContext context) {
    final themeMode = ref.watch(themeModeProvider);
    final isDark = themeMode == ThemeMode.dark;
    final scaffoldBg = isDark ? AppColorsDark.background : AppColors.background;
    final surfaceColor = isDark ? AppColorsDark.surface : AppColors.white;
    final textPrimary = isDark ? AppColorsDark.textPrimary : AppColors.textPrimary;
    final textSecondary = isDark ? AppColorsDark.textSecondary : AppColors.textSecondary;

    return Scaffold(
      backgroundColor: scaffoldBg,
      appBar: AppBar(title: const Text('Settings')),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeader('Account', textSecondary),
            _buildSettingsTile(
              icon: Icons.person,
              title: 'Edit Profile',
              textColor: textPrimary,
              onTap: () => context.push('/profile/edit'),
            ),
            _buildSettingsTile(
              icon: Icons.lock,
              title: 'Change Password',
              textColor: textPrimary,
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Change password (Demo)')),
                );
              },
            ),
            _buildSettingsTile(
              icon: Icons.payment,
              title: 'Payment Methods',
              textColor: textPrimary,
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Payment methods (Demo)')),
                );
              },
            ),
            Divider(color: isDark ? AppColorsDark.divider : AppColors.grey200),
            _buildSectionHeader('Notifications', textSecondary),
            _buildSwitchTile(
              icon: Icons.notifications,
              title: 'Push Notifications',
              textColor: textPrimary,
              value: _notificationsEnabled,
              onChanged: (value) {
                setState(() {
                  _notificationsEnabled = value;
                });
              },
            ),
            _buildSwitchTile(
              icon: Icons.email,
              title: 'Email Notifications',
              textColor: textPrimary,
              value: _emailNotifications,
              onChanged: (value) {
                setState(() {
                  _emailNotifications = value;
                });
              },
            ),
            Divider(color: isDark ? AppColorsDark.divider : AppColors.grey200),
            _buildSectionHeader('Appearance', textSecondary),
            _buildSwitchTile(
              icon: isDark ? Icons.light_mode : Icons.dark_mode,
              title: isDark ? 'Light Mode' : 'Dark Mode',
              textColor: textPrimary,
              value: isDark,
              onChanged: (value) {
                ref.read(themeModeProvider.notifier).state =
                    value ? ThemeMode.dark : ThemeMode.light;
              },
            ),
            _buildSettingsTile(
              icon: Icons.language,
              title: 'Language',
              subtitle: _language,
              textColor: textPrimary,
              subtitleColor: textSecondary,
              onTap: () {
                _showLanguageDialog(isDark, textPrimary);
              },
            ),
            Divider(color: isDark ? AppColorsDark.divider : AppColors.grey200),
            _buildSectionHeader('Support', textSecondary),
            _buildSettingsTile(
              icon: Icons.help,
              title: 'Help Center',
              textColor: textPrimary,
              onTap: () => context.push('/help'),
            ),
            _buildSettingsTile(
              icon: Icons.info,
              title: 'About',
              textColor: textPrimary,
              onTap: () => context.push('/about'),
            ),
            _buildSettingsTile(
              icon: Icons.description,
              title: 'Terms of Service',
              textColor: textPrimary,
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Terms of service (Demo)')),
                );
              },
            ),
            _buildSettingsTile(
              icon: Icons.privacy_tip,
              title: 'Privacy Policy',
              textColor: textPrimary,
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Privacy policy (Demo)')),
                );
              },
            ),
            Divider(color: isDark ? AppColorsDark.divider : AppColors.grey200),
            _buildSectionHeader('Danger Zone', textSecondary),
            _buildSettingsTile(
              icon: Icons.delete_forever,
              title: 'Delete Account',
              textColor: isDark ? AppColorsDark.error : AppColors.error,
              onTap: () {
                _showDeleteAccountDialog(isDark);
              },
            ),
            const SizedBox(height: 24),
            Center(
              child: Text(
                'Veltrix Sports v1.0.0',
                style: TextStyle(color: textSecondary, fontSize: 12),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, Color color) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Text(
        title,
        style: TextStyle(color: color, fontWeight: FontWeight.w600, fontSize: 14),
      ),
    );
  }

  Widget _buildSettingsTile({
    required IconData icon,
    required String title,
    String? subtitle,
    Color? textColor,
    Color? subtitleColor,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: textColor),
      title: Text(title, style: TextStyle(color: textColor, fontWeight: FontWeight.w500)),
      subtitle: subtitle != null
          ? Text(subtitle, style: TextStyle(color: subtitleColor))
          : null,
      trailing: Icon(Icons.arrow_forward_ios, size: 16, color: textColor?.withOpacity(0.5)),
      onTap: onTap,
    );
  }

  Widget _buildSwitchTile({
    required IconData icon,
    required String title,
    required bool value,
    Color? textColor,
    required ValueChanged<bool> onChanged,
  }) {
    return SwitchListTile(
      secondary: Icon(icon, color: textColor),
      title: Text(title, style: TextStyle(color: textColor, fontWeight: FontWeight.w500)),
      value: value,
      onChanged: onChanged,
      activeColor: AppColors.primary,
    );
  }

  void _showLanguageDialog(bool isDark, Color textPrimary) {
    final surfaceColor = isDark ? AppColorsDark.surface : AppColors.white;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: surfaceColor,
        title: Text('Select Language', style: TextStyle(color: textPrimary)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildLanguageOption('English', textPrimary),
            _buildLanguageOption('Hindi', textPrimary),
            _buildLanguageOption('Tamil', textPrimary),
            _buildLanguageOption('Telugu', textPrimary),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageOption(String language, Color textPrimary) {
    return RadioListTile<String>(
      title: Text(language, style: TextStyle(color: textPrimary)),
      value: language,
      groupValue: _language,
      onChanged: (value) {
        setState(() {
          _language = value!;
        });
        Navigator.pop(context);
      },
      activeColor: AppColors.primary,
    );
  }

  void _showDeleteAccountDialog(bool isDark) {
    final surfaceColor = isDark ? AppColorsDark.surface : AppColors.white;
    final textPrimary = isDark ? AppColorsDark.textPrimary : AppColors.textPrimary;
    final textSecondary = isDark ? AppColorsDark.textSecondary : AppColors.textSecondary;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: surfaceColor,
        title: Text('Delete Account', style: TextStyle(color: textPrimary)),
        content: Text(
          'Are you sure you want to delete your account? This action cannot be undone.',
          style: TextStyle(color: textSecondary),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Account deletion (Demo)')),
              );
            },
            child: Text(
              'Delete',
              style: TextStyle(color: isDark ? AppColorsDark.error : AppColors.error),
            ),
          ),
        ],
      ),
    );
  }
}
