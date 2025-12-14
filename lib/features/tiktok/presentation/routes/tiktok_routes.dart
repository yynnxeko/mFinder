import 'package:go_router/go_router.dart';
import '../screens/tiktok_screen.dart';

class TikTokRoutes {
  static const String tiktok = '/tiktok';
  
  static List<RouteBase> routes = [
    GoRoute(
      path: tiktok,
      name: 'tiktok', 
      builder: (context, state) => const TikTokScreen(),
    ),
  ];
}