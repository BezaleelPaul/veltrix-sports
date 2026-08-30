import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../widgets/web_scaffold.dart';
import '../screens/web_landing_screen.dart';
import '../screens/web_training_screen.dart';
import '../screens/web_training_detail_screen.dart';
import '../screens/web_events_screen.dart';
import '../screens/web_event_detail_screen.dart';
import '../screens/web_coaches_screen.dart';
import '../screens/web_coach_detail_screen.dart';
import '../screens/web_pricing_screen.dart';
import '../screens/web_about_screen.dart';
import '../screens/web_contact_screen.dart';
import '../screens/web_login_screen.dart';
import '../screens/web_signup_screen.dart';
import '../screens/web_dashboard_screen.dart';
import '../screens/web_tickets_screen.dart';
import '../screens/web_ticket_detail_screen.dart';
import '../screens/web_profile_screen.dart';
import '../screens/web_edit_profile_screen.dart';
import '../screens/web_search_screen.dart';
import '../screens/web_notifications_screen.dart';
import '../screens/web_progress_screen.dart';
import '../screens/web_settings_screen.dart';
import '../screens/web_help_screen.dart';

final webRouter = GoRouter(
  initialLocation: '/',
  routes: [
    ShellRoute(
      builder: (context, state, child) => WebScaffold(child: child),
      routes: [
        GoRoute(path: '/', builder: (context, state) => const WebLandingScreen()),
        GoRoute(path: '/training', builder: (context, state) => const WebTrainingScreen()),
        GoRoute(path: '/training/:id', builder: (context, state) => WebTrainingDetailScreen(id: state.pathParameters['id']!)),
        GoRoute(path: '/events', builder: (context, state) => const WebEventsScreen()),
        GoRoute(path: '/events/:id', builder: (context, state) => WebEventDetailScreen(id: state.pathParameters['id']!)),
        GoRoute(path: '/coaches', builder: (context, state) => const WebCoachesScreen()),
        GoRoute(path: '/coaches/:id', builder: (context, state) => WebCoachDetailScreen(id: state.pathParameters['id']!)),
        GoRoute(path: '/pricing', builder: (context, state) => const WebPricingScreen()),
        GoRoute(path: '/about', builder: (context, state) => const WebAboutScreen()),
        GoRoute(path: '/contact', builder: (context, state) => const WebContactScreen()),
        GoRoute(path: '/search', builder: (context, state) => const WebSearchScreen()),
        GoRoute(path: '/notifications', builder: (context, state) => const WebNotificationsScreen()),
        GoRoute(path: '/progress', builder: (context, state) => const WebProgressScreen()),
        GoRoute(path: '/settings', builder: (context, state) => const WebSettingsScreen()),
        GoRoute(path: '/help', builder: (context, state) => const WebHelpScreen()),
        GoRoute(path: '/profile', builder: (context, state) => const WebProfileScreen()),
        GoRoute(path: '/profile/edit', builder: (context, state) => const WebEditProfileScreen()),
      ],
    ),
    GoRoute(path: '/login', builder: (context, state) => const WebLoginScreen()),
    GoRoute(path: '/signup', builder: (context, state) => const WebSignupScreen()),
    GoRoute(
      path: '/dashboard',
      builder: (context, state) => const WebDashboardScreen(),
      routes: [
        GoRoute(path: 'tickets', builder: (context, state) => const WebTicketsScreen()),
        GoRoute(path: 'tickets/:id', builder: (context, state) => WebTicketDetailScreen(id: state.pathParameters['id']!)),
      ],
    ),
  ],
);
