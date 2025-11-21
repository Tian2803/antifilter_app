import 'package:antifilter_app/shared/widgets/navigator_bar/main_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/onboard/presentation/pages/onboard_page.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../../features/historial/presentation/pages/historial_page.dart';
import '../../features/favoritos/presentation/pages/favoritos_page.dart';
import '../../features/profile/presentation/pages/profile_page.dart';
import '../../features/settings/presentation/pages/settings_page.dart';
import '../../shared/themes/app_theme.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/onboard',
    routes: [
      GoRoute(
        path: '/onboard',
        builder: (context, state) => const OnboardPage(),
      ),
      GoRoute(path: '/login', builder: (context, state) => const LoginPage()),
      ShellRoute(
        builder: (context, state, child) => MainScaffold(child: child),
        routes: [
          GoRoute(
            path: '/home',
            builder: (context, state) =>
                Theme(data: AppTheme.lightTheme, child: const HomePage()),
          ),
          GoRoute(
            path: '/historial',
            builder: (context, state) =>
                Theme(data: AppTheme.lightTheme, child: const HistorialPage()),
          ),
          GoRoute(
            path: '/favoritos',
            builder: (context, state) =>
                Theme(data: AppTheme.lightTheme, child: const FavoritosPage()),
          ),
          GoRoute(
            path: '/profile',
            builder: (context, state) =>
                Theme(data: AppTheme.lightTheme, child: const ProfilePage()),
          ),
          GoRoute(
            path: '/settings',
            builder: (context, state) =>
                Theme(data: AppTheme.lightTheme, child: const SettingsPage()),
          ),
        ],
      ),
    ],
  );
}
