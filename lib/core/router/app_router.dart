import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../widgets/main_scaffold.dart';
import '../../features/splash/presentation/screens/splash_screen.dart';
import '../../features/onboarding/presentation/screens/onboarding_screen.dart';
import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/auth/presentation/screens/signup_screen.dart';
import '../../features/auth/presentation/screens/otp_screen.dart';
import '../../features/auth/presentation/screens/forgot_password_screen.dart';
import '../../features/home/presentation/screens/home_screen.dart';
import '../../features/training/presentation/screens/training_list_screen.dart';
import '../../features/training/presentation/screens/training_details_screen.dart';
import '../../features/events/presentation/screens/events_list_screen.dart';
import '../../features/events/presentation/screens/event_details_screen.dart';
import '../../features/tickets/presentation/screens/tickets_list_screen.dart';
import '../../features/tickets/presentation/screens/ticket_details_screen.dart';
import '../../features/coaches/presentation/screens/coaches_list_screen.dart';
import '../../features/coaches/presentation/screens/coach_profile_screen.dart';
import '../../features/profile/presentation/screens/profile_screen.dart';
import '../../features/profile/presentation/screens/edit_profile_screen.dart';
import '../../features/search/presentation/screens/search_screen.dart';
import '../../features/notifications/presentation/screens/notifications_screen.dart';
import '../../features/progress/presentation/screens/progress_screen.dart';
import '../../features/settings/presentation/screens/settings_screen.dart';
import '../../features/settings/presentation/screens/help_screen.dart';
import '../../features/settings/presentation/screens/about_screen.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/splash',
    routes: [
      GoRoute(path: '/splash', builder: (context, state) => const SplashScreen()),
      GoRoute(path: '/onboarding', builder: (context, state) => const OnboardingScreen()),
      GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
      GoRoute(path: '/signup', builder: (context, state) => const SignupScreen()),
      GoRoute(path: '/otp', builder: (context, state) => const OtpScreen()),
      GoRoute(path: '/forgot-password', builder: (context, state) => const ForgotPasswordScreen()),
      ShellRoute(
        builder: (context, state, child) => MainScaffold(child: child),
        routes: [
          GoRoute(path: '/home', builder: (context, state) => const HomeScreen()),
          GoRoute(path: '/training', builder: (context, state) => const TrainingListScreen()),
          GoRoute(path: '/training/:id', builder: (context, state) => TrainingDetailsScreen(id: state.pathParameters['id']!)),
          GoRoute(path: '/events', builder: (context, state) => const EventsListScreen()),
          GoRoute(path: '/events/:id', builder: (context, state) => EventDetailsScreen(id: state.pathParameters['id']!)),
          GoRoute(path: '/tickets', builder: (context, state) => const TicketsListScreen()),
          GoRoute(path: '/tickets/:id', builder: (context, state) => TicketDetailsScreen(id: state.pathParameters['id']!)),
          GoRoute(path: '/coaches', builder: (context, state) => const CoachesListScreen()),
          GoRoute(path: '/coaches/:id', builder: (context, state) => CoachProfileScreen(id: state.pathParameters['id']!)),
          GoRoute(path: '/profile', builder: (context, state) => const ProfileScreen()),
          GoRoute(path: '/profile/edit', builder: (context, state) => const EditProfileScreen()),
          GoRoute(path: '/search', builder: (context, state) => const SearchScreen()),
          GoRoute(path: '/notifications', builder: (context, state) => const NotificationsScreen()),
          GoRoute(path: '/progress', builder: (context, state) => const ProgressScreen()),
          GoRoute(path: '/settings', builder: (context, state) => const SettingsScreen()),
          GoRoute(path: '/help', builder: (context, state) => const HelpScreen()),
          GoRoute(path: '/about', builder: (context, state) => const AboutScreen()),
        ],
      ),
    ],
  );
}
