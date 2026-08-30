import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/web_colors.dart';
import '../../core/providers/web_providers.dart';

class WebLoginScreen extends ConsumerWidget {
  const WebLoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = ref.watch(webDarkModeProvider);
    return Scaffold(
      backgroundColor: isDark ? WebColors.darkBackground : WebColors.white,
      body: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.all(48),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 400),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Welcome Back', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: isDark ? WebColors.darkTextPrimary : WebColors.textPrimary)),
                      const SizedBox(height: 8),
                      Text('Sign in to your Veltrix Sports account', style: TextStyle(fontSize: 15, color: isDark ? WebColors.darkTextSecondary : WebColors.textSecondary)),
                      const SizedBox(height: 40),
                      _buildTextField('Email', Icons.email_outlined, isDark),
                      const SizedBox(height: 16),
                      _buildTextField('Password', Icons.lock_outline, isDark, isPassword: true),
                      const SizedBox(height: 8),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(onPressed: () {}, child: const Text('Forgot Password?', style: TextStyle(color: WebColors.primary))),
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () => context.go('/dashboard'),
                          style: ElevatedButton.styleFrom(backgroundColor: WebColors.primary, foregroundColor: WebColors.white, padding: const EdgeInsets.symmetric(vertical: 16), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                          child: const Text('Sign In', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
                        ),
                      ),
                      const SizedBox(height: 24),
                      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                        Text("Don't have an account? ", style: TextStyle(color: isDark ? WebColors.darkTextSecondary : WebColors.textSecondary)),
                        GestureDetector(
                          onTap: () => context.go('/signup'),
                          child: const Text('Sign Up', style: TextStyle(color: WebColors.primary, fontWeight: FontWeight.w600)),
                        ),
                      ]),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              decoration: const BoxDecoration(gradient: WebColors.heroGradient),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 72, height: 72,
                      decoration: BoxDecoration(color: WebColors.white.withValues(alpha: 0.2), borderRadius: BorderRadius.circular(18)),
                      child: const Icon(Icons.play_arrow, color: WebColors.white, size: 48),
                    ),
                    const SizedBox(height: 24),
                    const Text('Veltrix Sports', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: WebColors.white)),
                    const SizedBox(height: 8),
                    const Text('Your Complete Sports Platform', style: TextStyle(color: WebColors.white70)),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(String label, IconData icon, bool isDark, {bool isPassword = false}) {
    return TextField(
      obscureText: isPassword,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: isDark ? WebColors.darkTextSecondary : WebColors.grey500),
        labelStyle: TextStyle(color: isDark ? WebColors.darkTextSecondary : WebColors.grey500),
        filled: true,
        fillColor: isDark ? WebColors.darkSurface : WebColors.grey50,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: isDark ? WebColors.darkBorder : WebColors.grey200)),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: isDark ? WebColors.darkBorder : WebColors.grey200)),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: WebColors.primary)),
      ),
    );
  }
}
