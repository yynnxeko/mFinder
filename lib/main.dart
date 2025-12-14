import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/routes/app_routes.dart';

void main() {
  runApp(const ProviderScope(child: MFinderApp()));
}


class MFinderApp extends StatelessWidget {
  const MFinderApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'mFinder',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        fontFamily: 'Inter',
        useMaterial3: true,
      ),
      routerConfig: AppRoutes.router,
      debugShowCheckedModeBanner: false,
    );
  }
}