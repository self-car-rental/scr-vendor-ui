// Package imports:
import 'package:go_router/go_router.dart';
// Project imports:
import 'package:scr_vendor/core/app_route_constants.dart';
import 'package:scr_vendor/features/auth/presentation/screens/sign_in_screen.dart';
import 'package:scr_vendor/features/auth/presentation/screens/sign_up_screen.dart';
import 'package:scr_vendor/features/auth/presentation/screens/verify_otp_screen.dart';
import 'package:scr_vendor/features/home/presentation/screens/home_screen.dart';
import 'package:scr_vendor/features/user/presentation/screens/user_list_screen.dart';

class AppRouter {
  static GoRouter get router => _goRouter;

  static final _goRouter = GoRouter(
    initialLocation: AppPage.signin.path,
    routes: [
      GoRoute(
        path: AppPage.home.path,
        name: AppPage.home.name,
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: AppPage.signin.path,
        name: AppPage.signin.name,
        builder: (context, state) => SignInScreen(),
      ),
      GoRoute(
        path: AppPage.signup.path,
        name: AppPage.signup.name,
        builder: (context, state) => SignUpScreen(),
      ),
      GoRoute(
        path: AppPage.verifyOtp.path,
        name: AppPage.verifyOtp.name,
        builder: (context, state) => VerifyOtpScreen(),
      ),
      GoRoute(
        path: AppPage.user.path,
        name: AppPage.user.name,
        builder: (context, state) => const UserListScreen(),
      ),
    ],
  );
}
