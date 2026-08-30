import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/constants/web_colors.dart';
import '../../core/providers/web_providers.dart';

class WebHelpScreen extends ConsumerWidget {
  const WebHelpScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;
    final isTablet = screenWidth >= 768 && screenWidth < 1024;
    final isDark = ref.watch(webDarkModeProvider);

    final items = [
      _HelpItem(Icons.help_outline, 'FAQs', 'Frequently asked questions'),
      _HelpItem(Icons.email_outlined, 'Contact Us', 'support@veltrixsports.com'),
      _HelpItem(Icons.chat_bubble_outline, 'Live Chat', 'Chat with our support team'),
      _HelpItem(Icons.bug_report_outlined, 'Report a Bug', 'Let us know about issues'),
      _HelpItem(Icons.star_outline, 'Rate Us', 'Rate us on the App Store'),
    ];

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 600),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(isMobile ? 16 : 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Help & Support',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: isDark ? WebColors.darkTextPrimary : WebColors.textPrimary,
                ),
              ),
              const SizedBox(height: 24),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: isDark ? WebColors.darkCard : WebColors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: isDark ? WebColors.darkBorder : WebColors.grey100),
                ),
                child: Column(
                  children: items.asMap().entries.map((entry) {
                    final i = entry.key;
                    final item = entry.value;
                    final isLast = i == items.length - 1;
                    return Column(
                      children: [
                        ListTile(
                          leading: Icon(item.icon, color: isDark ? WebColors.darkTextSecondary : WebColors.grey600),
                          title: Text(
                            item.title,
                            style: TextStyle(fontWeight: FontWeight.w500, color: isDark ? WebColors.darkTextPrimary : WebColors.textPrimary),
                          ),
                          subtitle: Text(
                            item.subtitle,
                            style: TextStyle(fontSize: 13, color: isDark ? WebColors.darkTextSecondary : WebColors.grey500),
                          ),
                          trailing: Icon(Icons.chevron_right, color: isDark ? WebColors.darkTextHint : WebColors.grey400),
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('${item.title} - coming soon!')),
                            );
                          },
                          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                        ),
                        if (!isLast)
                          Divider(height: 1, color: isDark ? WebColors.darkBorder : WebColors.grey100, indent: 56),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _HelpItem {
  final IconData icon;
  final String title;
  final String subtitle;
  const _HelpItem(this.icon, this.title, this.subtitle);
}
