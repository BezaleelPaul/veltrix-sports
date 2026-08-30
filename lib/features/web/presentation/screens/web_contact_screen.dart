import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/constants/web_colors.dart';
import '../../core/providers/web_providers.dart';

class WebContactScreen extends ConsumerWidget {
  const WebContactScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;
    final isTablet = screenWidth >= 768 && screenWidth < 1024;
    final isDark = ref.watch(webDarkModeProvider);

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 16 : (isTablet ? 24 : 48), vertical: isMobile ? 32 : 64),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 900),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(child: Text('Contact Us', style: TextStyle(fontSize: isMobile ? 24 : 36, fontWeight: FontWeight.bold, color: isDark ? WebColors.darkTextPrimary : WebColors.textPrimary))),
              const SizedBox(height: 8),
              Center(child: Text('Have a question? We\'d love to hear from you.', style: TextStyle(fontSize: isMobile ? 14 : 16, color: isDark ? WebColors.darkTextSecondary : WebColors.textSecondary))),
              SizedBox(height: isMobile ? 24 : 48),
              _buildLayout(context, isDark, isMobile),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLayout(BuildContext context, bool isDark, bool isMobile) {
    final formWidget = Container(
      padding: EdgeInsets.all(isMobile ? 20 : 32),
      decoration: BoxDecoration(
        color: isDark ? WebColors.darkCard : WebColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: isDark ? WebColors.darkBorder : WebColors.grey100),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Send a Message', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: isDark ? WebColors.darkTextPrimary : WebColors.textPrimary)),
          const SizedBox(height: 24),
          _TextField(label: 'Name', isDark: isDark),
          const SizedBox(height: 16),
          _TextField(label: 'Email', isDark: isDark),
          const SizedBox(height: 16),
          _TextField(label: 'Subject', isDark: isDark),
          const SizedBox(height: 16),
          _TextField(label: 'Message', isDark: isDark, maxLines: 5),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(backgroundColor: WebColors.primary, foregroundColor: WebColors.white, padding: const EdgeInsets.symmetric(vertical: 16), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
              child: const Text('Send Message', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
            ),
          ),
        ],
      ),
    );

    final contactsWidget = Column(
      children: [
        _ContactCard(icon: Icons.email_outlined, title: 'Email', detail: 'support@veltrixsports.com', isDark: isDark),
        const SizedBox(height: 16),
        _ContactCard(icon: Icons.phone_outlined, title: 'Phone', detail: '+91 98765 43210', isDark: isDark),
        const SizedBox(height: 16),
        _ContactCard(icon: Icons.location_on_outlined, title: 'Office', detail: 'Mumbai, Maharashtra\nIndia', isDark: isDark),
      ],
    );

    if (isMobile) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          formWidget,
          const SizedBox(height: 24),
          contactsWidget,
        ],
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(flex: 2, child: formWidget),
        const SizedBox(width: 32),
        Expanded(child: contactsWidget),
      ],
    );
  }
}

class _TextField extends StatelessWidget {
  final String label;
  final bool isDark;
  final int maxLines;
  const _TextField({required this.label, required this.isDark, this.maxLines = 1});

  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: isDark ? WebColors.darkTextSecondary : WebColors.grey500),
        filled: true,
        fillColor: isDark ? WebColors.darkBackground : WebColors.grey50,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: isDark ? WebColors.darkBorder : WebColors.grey200),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: isDark ? WebColors.darkBorder : WebColors.grey200),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: WebColors.primary),
        ),
      ),
    );
  }
}

class _ContactCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String detail;
  final bool isDark;
  const _ContactCard({required this.icon, required this.title, required this.detail, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: isDark ? WebColors.darkCard : WebColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: isDark ? WebColors.darkBorder : WebColors.grey100),
      ),
      child: Column(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(color: WebColors.primary.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(12)),
            child: Icon(icon, color: WebColors.primary),
          ),
          const SizedBox(height: 12),
          Text(title, style: TextStyle(fontWeight: FontWeight.w600, color: isDark ? WebColors.darkTextPrimary : WebColors.textPrimary)),
          const SizedBox(height: 4),
          Text(detail, textAlign: TextAlign.center, style: TextStyle(fontSize: 14, color: isDark ? WebColors.darkTextSecondary : WebColors.textSecondary)),
        ],
      ),
    );
  }
}
