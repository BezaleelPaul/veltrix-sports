import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';

class _NotificationItem {
  final String title;
  final String body;
  final DateTime time;
  final IconData icon;
  final Color iconColor;
  final bool isRead;

  const _NotificationItem({
    required this.title,
    required this.body,
    required this.time,
    required this.icon,
    required this.iconColor,
    this.isRead = false,
  });
}

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  static final List<_NotificationItem> _notifications = [
    _NotificationItem(
      title: 'Event Registration Confirmed',
      body: 'Your registration for Mumbai Marathon 2026 has been confirmed.',
      time: DateTime.now().subtract(const Duration(minutes: 30)),
      icon: Icons.check_circle_outline,
      iconColor: AppColors.success,
    ),
    _NotificationItem(
      title: 'New Training Plan Available',
      body: 'Coach Rajesh just released a new marathon prep plan.',
      time: DateTime.now().subtract(const Duration(hours: 2)),
      icon: Icons.fitness_center,
      iconColor: AppColors.primary,
    ),
    _NotificationItem(
      title: 'Coach Session Reminder',
      body: 'Your session with Coach Priya is tomorrow at 6:00 AM.',
      time: DateTime.now().subtract(const Duration(hours: 5)),
      icon: Icons.event_note,
      iconColor: AppColors.accent,
    ),
    _NotificationItem(
      title: 'Payment Successful',
      body: 'Payment of ₹1500 for Mumbai Marathon ticket processed.',
      time: DateTime.now().subtract(const Duration(days: 1)),
      icon: Icons.payment,
      iconColor: AppColors.success,
    ),
    _NotificationItem(
      title: 'Training Milestone',
      body: 'Congratulations! You completed 10 workouts this week.',
      time: DateTime.now().subtract(const Duration(days: 2)),
      icon: Icons.emoji_events,
      iconColor: AppColors.accent,
    ),
    _NotificationItem(
      title: 'Event Update',
      body: 'Delhi Cycling Grand Prix date has been updated to March 20.',
      time: DateTime.now().subtract(const Duration(days: 3)),
      icon: Icons.info_outline,
      iconColor: AppColors.info,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text('Notifications', style: GoogleFonts.poppins()),
        backgroundColor: AppColors.background,
        elevation: 0,
        foregroundColor: AppColors.textPrimary,
        actions: [
          TextButton(
            onPressed: () {},
            child: Text('Mark all read', style: TextStyle(color: AppColors.primary)),
          ),
        ],
      ),
      body: _notifications.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.notifications_none, size: 64, color: AppColors.grey300),
                  const SizedBox(height: 16),
                  Text('No notifications', style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text('You\'re all caught up!', style: TextStyle(color: AppColors.textSecondary)),
                ],
              ),
            )
          : ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: _notifications.length,
              separatorBuilder: (_, __) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final item = _notifications[index];
                final isDark = Theme.of(context).brightness == Brightness.dark;
                return Container(
                  color: item.isRead
                      ? null
                      : (isDark ? AppColors.primary.withOpacity(0.05) : AppColors.primary.withOpacity(0.03)),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    leading: Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: item.iconColor.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(item.icon, color: item.iconColor, size: 22),
                    ),
                    title: Text(
                      item.title,
                      style: TextStyle(
                        fontWeight: item.isRead ? FontWeight.normal : FontWeight.w600,
                        fontSize: 15,
                      ),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Text(
                        item.body,
                        style: TextStyle(color: AppColors.textSecondary, fontSize: 13),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    trailing: Text(
                      _formatTime(item.time),
                      style: TextStyle(color: AppColors.textHint, fontSize: 12),
                    ),
                  ),
                );
              },
            ),
    );
  }

  String _formatTime(DateTime time) {
    final diff = DateTime.now().difference(time);
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    if (diff.inDays < 7) return '${diff.inDays}d ago';
    return '${time.day}/${time.month}';
  }
}
