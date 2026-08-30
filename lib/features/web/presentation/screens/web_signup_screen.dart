import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/web_colors.dart';
import '../../../../core/providers/auth_provider.dart';
import '../../core/providers/web_providers.dart';

class WebSignupScreen extends ConsumerStatefulWidget {
  const WebSignupScreen({super.key});

  @override
  ConsumerState<WebSignupScreen> createState() => _WebSignupScreenState();
}

class _WebSignupScreenState extends ConsumerState<WebSignupScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleSignup() async {
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text;

    if (name.isEmpty || email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields')),
      );
      return;
    }

    setState(() => _isLoading = true);
    try {
      await ref.read(authProvider.notifier).signup(name, email, password);
      if (mounted) {
        final authState = ref.read(authProvider);
        if (authState.hasError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(authState.error.toString())),
          );
        } else {
          context.go('/dashboard');
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Signup failed: ${e.toString()}')),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;
    final isTablet = screenWidth >= 768 && screenWidth < 1024;
    final isDark = ref.watch(webDarkModeProvider);
    return Scaffold(
      backgroundColor: isDark ? WebColors.darkBackground : WebColors.white,
      body: isMobile
          ? SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(isMobile ? 20 : 48),
                    child: Center(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 400),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Create Account', style: TextStyle(fontSize: isMobile ? 26 : 32, fontWeight: FontWeight.bold, color: isDark ? WebColors.darkTextPrimary : WebColors.textPrimary)),
                            const SizedBox(height: 8),
                            Text('Join Veltrix Sports today', style: TextStyle(fontSize: 15, color: isDark ? WebColors.darkTextSecondary : WebColors.textSecondary)),
                            const SizedBox(height: 40),
                            _buildTextField('Full Name', Icons.person_outline, isDark, controller: _nameController),
                            const SizedBox(height: 16),
                            _buildTextField('Email', Icons.email_outlined, isDark, controller: _emailController),
                            const SizedBox(height: 16),
                            _buildTextField('Password', Icons.lock_outline, isDark, isPassword: true, controller: _passwordController),
                            const SizedBox(height: 24),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: _isLoading ? null : _handleSignup,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: WebColors.primary,
                                  foregroundColor: WebColors.white,
                                  padding: const EdgeInsets.symmetric(vertical: 16),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                ),
                                child: _isLoading
                                    ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(color: WebColors.white, strokeWidth: 2))
                                    : const Text('Create Account', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
                              ),
                            ),
                            const SizedBox(height: 24),
                            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                              Text('Already have an account? ', style: TextStyle(color: isDark ? WebColors.darkTextSecondary : WebColors.textSecondary)),
                              GestureDetector(
                                onTap: () => context.go('/login'),
                                child: const Text('Sign In', style: TextStyle(color: WebColors.primary, fontWeight: FontWeight.w600)),
                              ),
                            ]),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          : Row(
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
                            Text('Create Account', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: isDark ? WebColors.darkTextPrimary : WebColors.textPrimary)),
                            const SizedBox(height: 8),
                            Text('Join Veltrix Sports today', style: TextStyle(fontSize: 15, color: isDark ? WebColors.darkTextSecondary : WebColors.textSecondary)),
                            const SizedBox(height: 40),
                            _buildTextField('Full Name', Icons.person_outline, isDark, controller: _nameController),
                            const SizedBox(height: 16),
                            _buildTextField('Email', Icons.email_outlined, isDark, controller: _emailController),
                            const SizedBox(height: 16),
                            _buildTextField('Password', Icons.lock_outline, isDark, isPassword: true, controller: _passwordController),
                            const SizedBox(height: 24),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: _isLoading ? null : _handleSignup,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: WebColors.primary,
                                  foregroundColor: WebColors.white,
                                  padding: const EdgeInsets.symmetric(vertical: 16),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                ),
                                child: _isLoading
                                    ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(color: WebColors.white, strokeWidth: 2))
                                    : const Text('Create Account', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
                              ),
                            ),
                            const SizedBox(height: 24),
                            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                              Text('Already have an account? ', style: TextStyle(color: isDark ? WebColors.darkTextSecondary : WebColors.textSecondary)),
                              GestureDetector(
                                onTap: () => context.go('/login'),
                                child: const Text('Sign In', style: TextStyle(color: WebColors.primary, fontWeight: FontWeight.w600)),
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
                            child: const Icon(Icons.fitness_center, color: WebColors.white, size: 48),
                          ),
                          const SizedBox(height: 24),
                          const Text('Veltrix Sports', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: WebColors.white)),
                          const SizedBox(height: 8),
                          const Text('Start Your Sports Journey', style: TextStyle(color: WebColors.white70)),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildTextField(String label, IconData icon, bool isDark, {bool isPassword = false, TextEditingController? controller}) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: isDark ? WebColors.darkTextSecondary : WebColors.grey500),
        labelStyle: TextStyle(color: isDark ? WebColors.darkTextSecondary : WebColors.grey500),
        filled: true,
        fillColor: isDark ? WebColors.darkSurface : WebColors.grey50,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: isDark ? WebColors.darkBorder : WebColors.grey200)),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: isDark ? WebColors.darkBorder : WebColors.grey200)),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: WebColors.primary)),
      ),
    );
  }
}
