import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  final List<_Notification> _notifications = [
    _Notification(
      id: '1',
      title: 'Event Registration Confirmed',
      message: 'You have been registered for Mumbai Marathon 2026',
      icon: Icons.check_circle,
      color: AppColors.success,
      time: '2 hours ago',
      isRead: false,
    ),
    _Notification(
      id: '2',
      title: 'Training Reminder',
      message: 'Don\'t forget your training session tomorrow at 6 AM',
      icon: Icons.fitness_center,
      color: AppColors.primary,
      time: '5 hours ago',
      isRead: false,
    ),
    _Notification(
      id: '3',
      title: 'New Event Near You',
      message: 'Delhi Cycling Championship - Register now!',
      icon: Icons.event,
      color: AppColors.secondary,
      time: '1 day ago',
      isRead: true,
    ),
    _Notification(
      id: '4',
      title: 'Payment Successful',
      message: 'Payment of ₹500 for Mumbai Marathon confirmed',
      icon: Icons.payment,
      color: AppColors.success,
      time: '2 days ago',
      isRead: true,
    ),
    _Notification(
      id: '5',
      title: 'Coach Message',
      message: 'Coach Sarah sent you a message about your progress',
      icon: Icons.message,
      color: AppColors.primary,
      time: '3 days ago',
      isRead: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Notifications'),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                for (var n in _notifications) {
                  n.isRead = true;
                }
              });
            },
            child: const Text('Mark all read'),
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
                  Text(
                    'No notifications',
                    style: TextStyle(
                      fontSize: 18,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _notifications.length,
              itemBuilder: (context, index) {
                return _buildNotificationCard(_notifications[index]);
              },
            ),
    );
  }

  Widget _buildNotificationCard(_Notification notification) {
    return GestureDetector(
      onTap: () {
        setState(() {
          notification.isRead = true;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Opened: ${notification.title}')),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: notification.isRead ? AppColors.white : AppColors.primary.withOpacity(0.05),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: notification.isRead ? AppColors.grey200 : AppColors.primary.withOpacity(0.2),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: notification.color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(notification.icon, color: notification.color, size: 20),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          notification.title,
                          style: TextStyle(
                            fontWeight: notification.isRead ? FontWeight.w500 : FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      if (!notification.isRead)
                        Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: AppColors.primary,
                            shape: BoxShape.circle,
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    notification.message,
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    notification.time,
                    style: TextStyle(
                      color: AppColors.textHint,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Notification {
  final String id;
  final String title;
  final String message;
  final IconData icon;
  final Color color;
  final String time;
  bool isRead;

  _Notification({
    required this.id,
    required this.title,
    required this.message,
    required this.icon,
    required this.color,
    required this.time,
    required this.isRead,
  });
}
