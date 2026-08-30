import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../core/constants/web_colors.dart';
import '../../core/providers/web_providers.dart';
import '../../../../core/mock/mock_data.dart';

class WebEventDetailScreen extends ConsumerWidget {
  final String id;
  const WebEventDetailScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;
    final isTablet = screenWidth >= 768 && screenWidth < 1024;
    final isDark = ref.watch(webDarkModeProvider);
    final event = MockData.events.firstWhere(
      (e) => e.id == id,
      orElse: () => MockData.events.first,
    );
    final spotsLeft = event.maxParticipants - event.currentParticipants;
    final capacityRatio = event.currentParticipants / event.maxParticipants;

    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(isMobile ? 20 : 48),
            decoration: BoxDecoration(
              gradient: WebColors.heroGradient,
            ),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 800),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () => context.pop(),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.arrow_back, color: WebColors.white),
                          SizedBox(width: 8),
                          Text('Back', style: TextStyle(color: WebColors.white, fontSize: 14)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    Icon(
                      Icons.event,
                      size: 48,
                      color: WebColors.white.withValues(alpha: 0.9),
                    ),
                    const SizedBox(height: 16),
                    Text(event.name, style: TextStyle(color: WebColors.white, fontSize: isMobile ? 22 : 32, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Text(event.sport, style: const TextStyle(color: WebColors.white70, fontSize: 16)),
                  ],
                ),
              ),
            ),
          ),
          Container(
            color: isDark ? WebColors.darkBackground : WebColors.grey50,
            padding: EdgeInsets.symmetric(vertical: isMobile ? 24 : 48),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 800),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: isMobile ? 16 : 32),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _InfoCard(
                        icon: Icons.calendar_today,
                        label: 'Date',
                        value: DateFormat('EEEE, MMM dd, yyyy').format(event.eventDate),
                        isDark: isDark,
                      ),
                      const SizedBox(height: 12),
                      _InfoCard(
                        icon: Icons.location_on_outlined,
                        label: 'Location',
                        value: event.location,
                        isDark: isDark,
                      ),
                      const SizedBox(height: 12),
                      _InfoCard(
                        icon: Icons.location_city,
                        label: 'City',
                        value: event.city,
                        isDark: isDark,
                      ),
                      const SizedBox(height: 12),
                      _InfoCard(
                        icon: Icons.payments_outlined,
                        label: 'Fee',
                        value: '₹${event.registrationFee}',
                        isDark: isDark,
                        valueColor: WebColors.primary,
                      ),
                      const SizedBox(height: 12),
                      _InfoCard(
                        icon: Icons.people_outline,
                        label: 'Spots Available',
                        value: '$spotsLeft of ${event.maxParticipants}',
                        isDark: isDark,
                        trailing: SizedBox(
                          width: 120,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(4),
                                child: LinearProgressIndicator(
                                  value: capacityRatio,
                                  backgroundColor: isDark ? WebColors.darkBorder : WebColors.grey200,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    capacityRatio > 0.9 ? WebColors.error : WebColors.primary,
                                  ),
                                  minHeight: 6,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text('${(capacityRatio * 100).toStringAsFixed(0)}% filled',
                                  style: TextStyle(fontSize: 11, color: isDark ? WebColors.darkTextHint : WebColors.grey500)),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 40),
                      Text('Categories', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: isDark ? WebColors.darkTextPrimary : WebColors.textPrimary)),
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: event.categories.map((c) => Container(
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                              decoration: BoxDecoration(
                                color: WebColors.secondary.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(c, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: WebColors.secondary)),
                            )).toList(),
                      ),
                      const SizedBox(height: 40),
                      Text('Rules', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: isDark ? WebColors.darkTextPrimary : WebColors.textPrimary)),
                      const SizedBox(height: 12),
                      ...event.rules.map((r) => Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Icon(Icons.rule, size: 18, color: WebColors.secondary),
                                const SizedBox(width: 12),
                                Expanded(child: Text(r, style: TextStyle(fontSize: 15, color: isDark ? WebColors.darkTextSecondary : WebColors.grey700))),
                              ],
                            ),
                          )),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: isDark ? WebColors.darkSurface : WebColors.white,
              border: Border(top: BorderSide(color: isDark ? WebColors.darkBorder : WebColors.grey200)),
            ),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 800),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(gradient: WebColors.primaryGradient, borderRadius: BorderRadius.circular(12)),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: () {},
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        child: Center(
                          child: Text('Register Now', style: TextStyle(color: WebColors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final bool isDark;
  final Color? valueColor;
  final Widget? trailing;

  const _InfoCard({
    required this.icon,
    required this.label,
    required this.value,
    required this.isDark,
    this.valueColor,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? WebColors.darkCard : WebColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: isDark ? WebColors.darkBorder : WebColors.grey100),
      ),
      child: Row(
        children: [
          Icon(icon, size: 20, color: WebColors.primary),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: TextStyle(fontSize: 12, color: isDark ? WebColors.darkTextHint : WebColors.grey500)),
                const SizedBox(height: 2),
                Text(value, style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: valueColor ?? (isDark ? WebColors.darkTextPrimary : WebColors.textPrimary))),
              ],
            ),
          ),
          if (trailing != null) trailing!,
        ],
      ),
    );
  }
}
