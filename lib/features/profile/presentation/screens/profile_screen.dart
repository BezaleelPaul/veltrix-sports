import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/providers/auth_provider.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authProvider).valueOrNull;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(height: 20),
              CircleAvatar(
                radius: 50,
                backgroundColor: AppColors.primary,
                child: Text(
                  (user?.name ?? 'A')[0],
                  style: const TextStyle(color: Colors.white, fontSize: 36, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 16),
              Text(user?.name ?? 'Athlete', style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              Text(user?.email ?? 'athlete@email.com', style: TextStyle(color: AppColors.textSecondary)),
              const SizedBox(height: 32),
              _buildMenuItem(Icons.edit, 'Edit Profile', () => context.push('/profile/edit')),
              _buildMenuItem(Icons.notifications_outlined, 'Notifications', () => context.push('/notifications')),
              _buildMenuItem(Icons.trending_up, 'Progress', () => context.push('/progress')),
              _buildMenuItem(Icons.search, 'Search', () => context.push('/search')),
              _buildMenuItem(Icons.settings, 'Settings', () => context.push('/settings')),
              _buildMenuItem(Icons.help_outline, 'Help', () => context.push('/help')),
              _buildMenuItem(Icons.info_outline, 'About', () => context.push('/about')),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.red),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: () async {
                    await ref.read(authProvider.notifier).logout();
                    if (context.mounted) context.go('/login');
                  },
                  child: const Text('Logout', style: TextStyle(color: Colors.red)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String label, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: AppColors.textPrimary),
      title: Text(label),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}
