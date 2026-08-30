import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/web_colors.dart';

class WebSignupScreen extends StatelessWidget {
  const WebSignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // Left - Visual
          Expanded(
            flex: 1,
            child: Container(
              decoration: const BoxDecoration(gradient: WebColors.heroGradient),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        color: WebColors.white.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: const Icon(Icons.fitness_center, size: 60, color: WebColors.white),
                    ),
                    const SizedBox(height: 32),
                    const Text(
                      'Start Your Journey',
                      style: TextStyle(color: WebColors.white, fontSize: 32, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Join the fastest growing sports community',
                      style: TextStyle(color: WebColors.white.withOpacity(0.8), fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Right - Form
          Expanded(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 40),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () => context.go('/'),
                      child: Row(
                        children: [
                          Container(
                            width: 36, height: 36,
                            decoration: BoxDecoration(color: WebColors.primary, borderRadius: BorderRadius.circular(8)),
                            child: const Icon(Icons.fitness_center, color: WebColors.white, size: 20),
                          ),
                          const SizedBox(width: 10),
                          const Text('Veltrix Sports', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),
                    const Text('Create Account', style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    const Text('Join Veltrix Sports today', style: TextStyle(fontSize: 16, color: WebColors.textSecondary)),
                    const SizedBox(height: 32),
                    // Role selection
                    Row(
                      children: [
                        Expanded(child: _buildRoleCard('I\'m an Athlete', Icons.sports_gymnastics, true)),
                        const SizedBox(width: 16),
                        Expanded(child: _buildRoleCard('I\'m a Coach', Icons.school, false)),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Full Name', style: TextStyle(fontWeight: FontWeight.w600)),
                              const SizedBox(height: 8),
                              TextField(decoration: _inputDecoration('Enter your name', Icons.person_outlined)),
                            ],
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Phone', style: TextStyle(fontWeight: FontWeight.w600)),
                              const SizedBox(height: 8),
                              TextField(decoration: _inputDecoration('Enter phone number', Icons.phone_outlined)),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    const Text('Email', style: TextStyle(fontWeight: FontWeight.w600)),
                    const SizedBox(height: 8),
                    TextField(decoration: _inputDecoration('Enter your email', Icons.email_outlined)),
                    const SizedBox(height: 20),
                    const Text('Password', style: TextStyle(fontWeight: FontWeight.w600)),
                    const SizedBox(height: 8),
                    TextField(obscureText: true, decoration: _inputDecoration('Create a password', Icons.lock_outlined)),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity, height: 52,
                      child: ElevatedButton(
                        onPressed: () => context.go('/dashboard'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: WebColors.primary, foregroundColor: WebColors.white,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        child: const Text('Create Account'),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Center(
                      child: Text.rich(TextSpan(
                        text: 'Already have an account? ',
                        children: [TextSpan(text: 'Sign In', style: TextStyle(color: WebColors.primary, fontWeight: FontWeight.w600))],
                      )),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRoleCard(String label, IconData icon, bool selected) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: selected ? WebColors.primary.withOpacity(0.05) : WebColors.grey50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: selected ? WebColors.primary : WebColors.grey200, width: selected ? 2 : 1),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: selected ? WebColors.primary : WebColors.grey400),
          const SizedBox(width: 8),
          Text(label, style: TextStyle(color: selected ? WebColors.primary : WebColors.textSecondary, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }

  InputDecoration _inputDecoration(String hint, IconData icon) {
    return InputDecoration(
      hintText: hint,
      prefixIcon: Icon(icon),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: WebColors.grey300)),
      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: WebColors.primary, width: 2)),
    );
  }
}
