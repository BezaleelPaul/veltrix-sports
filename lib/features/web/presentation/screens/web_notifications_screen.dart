import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/constants/web_colors.dart';
import '../../core/providers/web_providers.dart';

class WebNotificationsScreen extends ConsumerWidget {
  const WebNotificationsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;
    final isTablet = screenWidth >= 768 && screenWidth < 1024;
    final isDark = ref.watch(webDarkModeProvider);

    final notifications = [
      _NotificationItem(
        icon: Icons.check_circle_outline,
        color: WebColors.accent,
        title: 'Event Registration Confirmed',
        body: 'Your registration for Mumbai Marathon 2026 has been confirmed.',
        time: '30m ago',
      ),
      _NotificationItem(
        icon: Icons.school_outlined,
        color: WebColors.primary,
        title: 'New Training Plan Available',
        body: 'Coach Rajesh just released a new marathon prep plan.',
        time: '2h ago',
      ),
      _NotificationItem(
        icon: Icons.alarm_outlined,
        color: WebColors.secondary,
        title: 'Coach Session Reminder',
        body: 'Your session with Coach Priya is tomorrow at 6:00 AM.',
        time: '5h ago',
      ),
      _NotificationItem(
        icon: Icons.payment,
        color: WebColors.accent,
        title: 'Payment Successful',
        body: 'Payment of ₹1500 for Mumbai Marathon ticket processed.',
        time: '1d ago',
      ),
      _NotificationItem(
        icon: Icons.emoji_events_outlined,
        color: Colors.amber,
        title: 'Training Milestone',
        body: 'Congratulations! You completed 10 workouts this week.',
        time: '2d ago',
      ),
      _NotificationItem(
        icon: Icons.event_outlined,
        color: WebColors.primary,
        title: 'Event Update',
        body: 'Delhi Cycling Grand Prix date has been updated to March 20.',
        time: '3d ago',
      ),
    ];

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 800),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(isMobile ? 16 : 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      'Notifications',
                      style: TextStyle(
                        fontSize: isMobile ? 22 : 28,
                        fontWeight: FontWeight.bold,
                        color: isDark ? WebColors.darkTextPrimary : WebColors.textPrimary,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text('Mark all read'),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              if (notifications.isEmpty)
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 64),
                    child: Column(
                      children: [
                        Icon(Icons.notifications_none, size: 64, color: isDark ? WebColors.darkTextHint : WebColors.grey300),
                        const SizedBox(height: 16),
                        Text(
                          'No notifications',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: isDark ? WebColors.darkTextPrimary : WebColors.textPrimary),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'You\'re all caught up!',
                          style: TextStyle(color: isDark ? WebColors.darkTextSecondary : WebColors.grey500),
                        ),
                      ],
                    ),
                  ),
                )
              else
                ...notifications.map((item) => Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: isDark ? WebColors.darkCard : WebColors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: isDark ? WebColors.darkBorder : WebColors.grey100),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: item.color.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(item.icon, color: item.color, size: 22),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.title,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: isDark ? WebColors.darkTextPrimary : WebColors.textPrimary,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              item.body,
                              style: TextStyle(fontSize: 13, color: isDark ? WebColors.darkTextSecondary : WebColors.textSecondary),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        item.time,
                        style: TextStyle(fontSize: 12, color: isDark ? WebColors.darkTextHint : WebColors.grey500),
                      ),
                    ],
                  ),
                )),
            ],
          ),
        ),
      ),
    );
  }
}

class _NotificationItem {
  final IconData icon;
  final Color color;
  final String title;
  final String body;
  final String time;
  const _NotificationItem({
    required this.icon,
    required this.color,
    required this.title,
    required this.body,
    required this.time,
  });
}
