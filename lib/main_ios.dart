import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/theme/app_theme.dart';
import 'core/router/app_router.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: VeltrixSportsIOSApp()));
}

class VeltrixSportsIOSApp extends StatelessWidget {
  const VeltrixSportsIOSApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Veltrix Sports',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      routerConfig: AppRouter.router,
      // iOS-style scroll behavior
      scrollBehavior: const CupertinoScrollBehavior(),
    );
  }
}

// iOS-style scrolling behavior
class CupertinoScrollBehavior extends ScrollBehavior {
  const CupertinoScrollBehavior();

  @override
  ScrollPhysics getScrollPhysics(BuildContext context) {
    return const BouncingScrollPhysics(
      parent: AlwaysScrollableScrollPhysics(),
    );
  }
}
