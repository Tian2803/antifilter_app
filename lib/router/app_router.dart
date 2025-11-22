import 'package:antifilter_app/shared/widgets/navigator_bar/main_scaffold.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/onboard/presentation/pages/onboard_page.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../features/history/presentation/pages/history_page.dart';
import '../features/favorites/presentation/pages/favorites_page.dart';
import '../../features/profile/presentation/pages/profile_page.dart';
import '../../features/settings/presentation/pages/settings_page.dart';
import '../../features/photo_editor/presentation/pages/photo_editor_page.dart';
import '../../shared/widgets/photo_grid/photo_detail_page.dart';
import '../../shared/themes/app_theme.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/onboard',
    routes: [
      GoRoute(
        path: '/onboard',
        builder: (context, state) =>
            Theme(data: AppTheme.darkTheme, child: const OnboardPage()),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) =>
            Theme(data: AppTheme.darkTheme, child: const LoginPage()),
      ),
      ShellRoute(
        builder: (context, state, child) => MainScaffold(child: child),
        routes: [
          GoRoute(path: '/home', builder: (context, state) => const HomePage()),
          GoRoute(
            path: '/history',
            builder: (context, state) => const HistoryPage(),
          ),
          GoRoute(
            path: '/favorites',
            builder: (context, state) => const FavoritesPage(),
          ),
          GoRoute(
            path: '/profile',
            builder: (context, state) => const ProfilePage(),
          ),
          GoRoute(
            path: '/settings',
            builder: (context, state) => const SettingsPage(),
          ),
          GoRoute(
            path: '/photo-detail',
            builder: (context, state) {
              final params = state.extra as Map<String, dynamic>;
              return PhotoDetailPage(
                photoUrl: params['photoUrl'] as String,
                createdAt: params['createdAt'] as DateTime,
              );
            },
          ),
          GoRoute(
            path: '/photo-editor',
            builder: (context, state) {
              final imageFile = state.extra as File;
              return PhotoEditorPage(imageFile: imageFile);
            },
          ),
        ],
      ),
    ],
  );
}
