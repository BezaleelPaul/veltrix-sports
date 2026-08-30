import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../core/constants/web_colors.dart';
import '../../core/providers/web_providers.dart';
import '../../../../core/mock/mock_data.dart';

class WebEventsScreen extends ConsumerWidget {
  const WebEventsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = ref.watch(webDarkModeProvider);
    final events = MockData.events;

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 48),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Upcoming Events', style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: isDark ? WebColors.darkTextPrimary : WebColors.textPrimary)),
          const SizedBox(height: 8),
          Text('Discover and register for exciting sports events.',
              style: TextStyle(fontSize: 16, color: isDark ? WebColors.darkTextSecondary : WebColors.textSecondary)),
          const SizedBox(height: 40),
          Wrap(
            spacing: 32,
            runSpacing: 32,
            children: events.map((event) => SizedBox(
              width: 350,
              child: Container(
                decoration: BoxDecoration(
                  color: isDark ? WebColors.darkCard : WebColors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: isDark ? WebColors.darkBorder : WebColors.grey100),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: WebColors.secondary.withValues(alpha: 0.1),
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(event.sport, style: const TextStyle(color: WebColors.secondary, fontSize: 12, fontWeight: FontWeight.w600)),
                          const SizedBox(height: 4),
                          Text(event.name, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: isDark ? WebColors.darkTextPrimary : WebColors.textPrimary)),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(event.description,
                              style: TextStyle(fontSize: 14, color: isDark ? WebColors.darkTextSecondary : WebColors.textSecondary)),
                          const SizedBox(height: 16),
                          _InfoRow(icon: Icons.location_on_outlined, text: '${event.location}, ${event.city}', isDark: isDark),
                          const SizedBox(height: 8),
                          _InfoRow(icon: Icons.calendar_today, text: DateFormat('MMM dd, yyyy').format(event.eventDate), isDark: isDark),
                          const SizedBox(height: 8),
                          _InfoRow(icon: Icons.people_outline, text: '${event.currentParticipants}/${event.maxParticipants} registered', isDark: isDark),
                          const SizedBox(height: 8),
                          _InfoRow(icon: Icons.star_outline, text: '${event.rating} rating', isDark: isDark),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('₹${event.registrationFee}', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: WebColors.primary)),
                              Container(
                                decoration: BoxDecoration(gradient: WebColors.primaryGradient, borderRadius: BorderRadius.circular(8)),
                                child: Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(8),
                                    onTap: () {},
                                    child: const Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                      child: Text('Register', style: TextStyle(color: WebColors.white, fontWeight: FontWeight.w600)),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )).toList(),
          ),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String text;
  final bool isDark;
  const _InfoRow({required this.icon, required this.text, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 16, color: isDark ? WebColors.darkTextHint : WebColors.grey500),
        const SizedBox(width: 8),
        Expanded(child: Text(text, style: TextStyle(fontSize: 13, color: isDark ? WebColors.darkTextSecondary : WebColors.grey700))),
      ],
    );
  }
}
