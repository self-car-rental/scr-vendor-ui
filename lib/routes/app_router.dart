import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:scr_vendor/common/bottom_navigation/bottom_navigation_cubit.dart';
import 'package:scr_vendor/common/log/log.dart';
import 'package:scr_vendor/constants/app_route_constants.dart';
import 'package:scr_vendor/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:scr_vendor/features/auth/presentation/screens/sign_in_screen.dart';
import 'package:scr_vendor/features/auth/presentation/screens/sign_up_screen.dart';
import 'package:scr_vendor/features/auth/presentation/screens/verify_otp_screen.dart';
import 'package:scr_vendor/features/car/presentation/screens/car_list_screen.dart';
import 'package:scr_vendor/features/home/presentation/screens/home_screen.dart';
import 'package:scr_vendor/features/hub/presentation/screens/create_hub_screen.dart';
import 'package:scr_vendor/features/hub/presentation/screens/edit_hub_screen.dart';
import 'package:scr_vendor/features/hub/presentation/screens/hub_list_screen.dart';
import 'package:scr_vendor/features/profile/presentation/screens/profile_screen.dart';
import 'package:scr_vendor/features/user/presentation/screens/user_list_screen.dart';

/// Manages the routing for the entire application.
class AppRouter {
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  static final _shellNavigatorKey = GlobalKey<NavigatorState>();

  static GoRouter get router => _goRouter;

  static final _goRouter = GoRouter(
    initialLocation: AppPage.hubs.path,
    navigatorKey: _rootNavigatorKey,
    routes: [
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) => BlocProvider(
          create: (context) => BottomNavigationCubit(),
          child: HomeScreen(screen: child),
        ),
        routes: [
          GoRoute(
            path: AppPage.hubs.path,
            name: AppPage.hubs.name,
            builder: (context, state) => const HubListScreen(),
            routes: [
              GoRoute(
                path: AppPage.create.path,
                name: AppPage.create.name,
                builder: (context, state) => const CreateHubScreen(),
              ),
              GoRoute(
                path: AppPage.edit.path,
                name: AppPage.edit.name,
                builder: (context, state) {
                  final hubId = state.pathParameters['id'];
                  if (hubId == null) {
                    // Handle the null case, maybe by showing an error or redirecting
                    return const EditHubScreen(hubId: '');
// TODO: create Error screen
                    // return const ErrorScreen(
                    //     message:
                    //         'Car ID is missing'); // Or any other appropriate handling
                  }
                  return EditHubScreen(hubId: hubId);
                },
              ),
              // Similar route for DeleteCarScreen
            ],
          ),
          GoRoute(
            path: AppPage.cars.path,
            name: AppPage.cars.name,
            builder: (context, state) => const CarListScreen(),
          ),
          GoRoute(
            path: AppPage.user.path,
            name: AppPage.user.name,
            builder: (context, state) => const UserListScreen(),
          ),
          GoRoute(
            path: AppPage.profile.path,
            name: AppPage.profile.name,
            builder: (context, state) => const ProfileScreen(),
          ),
        ],
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
    ],
    redirect: (BuildContext context, GoRouterState state) async {
      final logger = Log();
      final userIsLoggedIn =
          await context.read<AuthBloc>().checkUserLoggedInUseCase.execute();

      if (!userIsLoggedIn &&
          state.fullPath != AppPage.signin.path &&
          state.fullPath != AppPage.verifyOtp.path) {
        logger.i('User not logged in. Redirecting to Sign-in page.');
        return AppPage.signin.path;
      }

      logger.i('Proceeding to requested route: ${state.fullPath}');
      return null;
    },
  );
}
