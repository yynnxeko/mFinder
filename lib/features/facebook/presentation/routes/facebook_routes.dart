import 'package:go_router/go_router.dart';
import '../screens/facebook_screen.dart';

class FacebookRoutes {
  static const String facebook = '/facebook';
  
  static List<RouteBase> routes = [
    GoRoute(
      path: facebook,
      name: 'facebook',
      builder: (context, state) => const FacebookScreen(),
    ),
  ];
}
