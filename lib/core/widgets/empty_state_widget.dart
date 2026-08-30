import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class EmptyStateWidget extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final String? buttonText;
  final VoidCallback? onButtonPressed;

  const EmptyStateWidget({
    super.key,
    required this.icon,
    required this.title,
    this.subtitle,
    this.buttonText,
    this.onButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 80,
              color: AppColors.grey300,
            ),
            const SizedBox(height: 24),
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
              textAlign: TextAlign.center,
            ),
            if (subtitle != null) ...[
              const SizedBox(height: 8),
              Text(
                subtitle!,
                style: const TextStyle(
                  fontSize: 14,
                  color: AppColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
            ],
            if (buttonText != null && onButtonPressed != null) ...[
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: onButtonPressed,
                child: Text(buttonText!),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class EmptyBookings extends StatelessWidget {
  const EmptyBookings({super.key});

  @override
  Widget build(BuildContext context) {
    return EmptyStateWidget(
      icon: Icons.event_busy,
      title: 'No Bookings Yet',
      subtitle: 'Start exploring events and training plans',
      buttonText: 'Browse Events',
      onButtonPressed: () {
        // Navigate to events
      },
    );
  }
}

class EmptyTickets extends StatelessWidget {
  const EmptyTickets({super.key});

  @override
  Widget build(BuildContext context) {
    return EmptyStateWidget(
      icon: Icons.confirmation_number_outlined,
      title: 'No Tickets',
      subtitle: 'Buy tickets for upcoming events',
      buttonText: 'Browse Events',
      onButtonPressed: () {
        // Navigate to events
      },
    );
  }
}

class EmptyTraining extends StatelessWidget {
  const EmptyTraining({super.key});

  @override
  Widget build(BuildContext context) {
    return EmptyStateWidget(
      icon: Icons.fitness_center,
      title: 'No Training Plans',
      subtitle: 'Start a training plan to improve your skills',
      buttonText: 'Browse Plans',
      onButtonPressed: () {
        // Navigate to training
      },
    );
  }
}

class EmptySearch extends StatelessWidget {
  final String query;

  const EmptySearch({super.key, required this.query});

  @override
  Widget build(BuildContext context) {
    return EmptyStateWidget(
      icon: Icons.search_off,
      title: 'No results found',
      subtitle: 'No results for "$query". Try different keywords.',
    );
  }
}

class ErrorStateWidget extends StatelessWidget {
  final String message;
  final VoidCallback? onRetry;

  const ErrorStateWidget({
    super.key,
    required this.message,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return EmptyStateWidget(
      icon: Icons.error_outline,
      title: 'Something went wrong',
      subtitle: message,
      buttonText: onRetry != null ? 'Retry' : null,
      onButtonPressed: onRetry,
    );
  }
}

class NoInternetWidget extends StatelessWidget {
  final VoidCallback? onRetry;

  const NoInternetWidget({super.key, this.onRetry});

  @override
  Widget build(BuildContext context) {
    return EmptyStateWidget(
      icon: Icons.wifi_off,
      title: 'No Internet Connection',
      subtitle: 'Please check your internet settings',
      buttonText: 'Retry',
      onButtonPressed: onRetry,
    );
  }
}
