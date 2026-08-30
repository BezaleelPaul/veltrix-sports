import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../widgets/web_scaffold.dart';
import '../screens/web_landing_screen.dart';
import '../screens/web_training_screen.dart';
import '../screens/web_events_screen.dart';
import '../screens/web_coaches_screen.dart';
import '../screens/web_pricing_screen.dart';
import '../screens/web_about_screen.dart';
import '../screens/web_contact_screen.dart';
import '../screens/web_login_screen.dart';
import '../screens/web_signup_screen.dart';
import '../screens/web_dashboard_screen.dart';
import '../screens/web_tickets_screen.dart';

final webRouter = GoRouter(
  initialLocation: '/',
  routes: [
    ShellRoute(
      builder: (context, state, child) => WebScaffold(child: child),
      routes: [
        GoRoute(path: '/', builder: (context, state) => const WebLandingScreen()),
        GoRoute(path: '/training', builder: (context, state) => const WebTrainingScreen()),
        GoRoute(path: '/events', builder: (context, state) => const WebEventsScreen()),
        GoRoute(path: '/coaches', builder: (context, state) => const WebCoachesScreen()),
        GoRoute(path: '/pricing', builder: (context, state) => const WebPricingScreen()),
        GoRoute(path: '/about', builder: (context, state) => const WebAboutScreen()),
        GoRoute(path: '/contact', builder: (context, state) => const WebContactScreen()),
      ],
    ),
    GoRoute(path: '/login', builder: (context, state) => const WebLoginScreen()),
    GoRoute(path: '/signup', builder: (context, state) => const WebSignupScreen()),
    GoRoute(
      path: '/dashboard',
      builder: (context, state) => const WebDashboardScreen(),
      routes: [
        GoRoute(path: 'tickets', builder: (context, state) => const WebTicketsScreen()),
      ],
    ),
  ],
);
