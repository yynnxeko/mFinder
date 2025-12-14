import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/facebook/presentation/screens/facebook_screen.dart';
import '../../features/tiktok/presentation/screens/tiktok_screen.dart';
import '../presentation/screens/home_screen.dart';

class AppRoutes {
  static const String home = '/';
  static const String facebook = '/facebook';
  static const String tiktok = '/tiktok';  static final GoRouter router = GoRouter(
    initialLocation: home,
    routes: [
      GoRoute(
        path: home,
        name: 'home',
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: facebook,
        name: 'facebook',
        builder: (context, state) => const FacebookScreen(),
      ),
      GoRoute(
        path: tiktok,
        name: 'tiktok',
        builder: (context, state) => const TikTokScreen(),
      ),
    ],errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Text('Page not found: ${state.uri}'),
      ),
    ),
  );
}
