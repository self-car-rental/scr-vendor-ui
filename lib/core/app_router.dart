// Package imports:
import 'package:go_router/go_router.dart';

// Project imports:
import 'package:scr_vendor/core/app_route_constants.dart';
import 'package:scr_vendor/features/home/presentation/screens/home_screen.dart';
import 'package:scr_vendor/features/login/presentation/screens/login_screen.dart';
import 'package:scr_vendor/features/user/presentation/screens/user_list_screen.dart';

class AppRouter {
  static GoRouter get router => _goRouter;

  static final _goRouter = GoRouter(
    initialLocation: AppPage.home.path,
    routes: [
      GoRoute(
        path: AppPage.home.path,
        name: AppPage.home.name,
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: AppPage.login.path,
        name: AppPage.login.name,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: AppPage.user.path,
        name: AppPage.user.name,
        builder: (context, state) => const UserListScreen(),
      ),
    ],
  );
}
