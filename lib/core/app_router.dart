// Package imports:
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
// Project imports:
import 'package:scr_vendor/core/app_route_constants.dart';
import 'package:scr_vendor/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:scr_vendor/features/auth/presentation/screens/sign_in_screen.dart';
import 'package:scr_vendor/features/auth/presentation/screens/sign_up_screen.dart';
import 'package:scr_vendor/features/auth/presentation/screens/verify_otp_screen.dart';
import 'package:scr_vendor/features/home/presentation/screens/home_screen.dart';
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
    redirect: (BuildContext context, GoRouterState state) async {
      final isLoggedIn =
          await context.read<AuthBloc>().checkUserLoggedInUseCase.execute();

      // Define protected route
      final isProtectedRoute = state.fullPath == AppPage.home.path;

      // Redirect to login if trying to access protected route and not logged in
      if (isProtectedRoute && !isLoggedIn) {
        return AppPage.signin.path;
      }
      return null;
    },
  );
}
