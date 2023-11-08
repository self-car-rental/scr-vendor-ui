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
  static final GlobalKey<NavigatorState> rootNavigatorKey =
      GlobalKey<NavigatorState>();

  static GoRouter get router => _goRouter;

  static final GoRouter _goRouter = GoRouter(
    initialLocation: AppRoutes.path(AppPage.hubs),
    navigatorKey: rootNavigatorKey,
    routes: _getRoutes(),
    redirect: _redirectLogic,
  );

  static List<RouteBase> _getRoutes() => [
        ShellRoute(
          builder: (context, state, child) => BlocProvider(
            create: (context) => BottomNavigationCubit(),
            child: HomeScreen(screen: child),
          ),
          routes: [
            _buildGoRoute(
                AppPage.hubs, (context, state) => const HubListScreen(), [
              _buildGoRoute(AppPage.hubsCreate,
                  (context, state) => const CreateHubScreen()),
              _buildGoRoute(AppPage.hubsEdit, (context, state) {
                final hubId = state.pathParameters['id'] ?? '';
                return EditHubScreen(hubId: hubId);
              }),
            ]),
            _buildGoRoute(
                AppPage.cars, (context, state) => const CarListScreen()),
            _buildGoRoute(
                AppPage.users, (context, state) => const UserListScreen()),
            _buildGoRoute(
                AppPage.profile, (context, state) => const ProfileScreen()),
          ],
        ),
        _buildGoRoute(AppPage.signin, (context, state) => SignInScreen()),
        _buildGoRoute(AppPage.signup, (context, state) => SignUpScreen()),
        _buildGoRoute(AppPage.verifyOtp, (context, state) => VerifyOtpScreen()),
      ];

  static GoRoute _buildGoRoute(
      AppPage page,
      Widget Function(BuildContext, GoRouterState)
          builder, // Updated parameter type
      [List<GoRoute>? nestedRoutes]) {
    return GoRoute(
      path: AppRoutes.path(page),
      name: AppRoutes.name(page),
      builder: builder, // Use the builder function
      routes: nestedRoutes ?? [],
    );
  }

  static Future<String?> _redirectLogic(
      BuildContext context, GoRouterState state) async {
    final logger = Log();
    final authBloc = context.read<AuthBloc>();
    final userIsLoggedIn = await authBloc.checkUserLoggedInUseCase.execute();

    if (!userIsLoggedIn &&
        state.uri.toString() != AppRoutes.path(AppPage.signin) &&
        state.uri.toString() != AppRoutes.path(AppPage.verifyOtp)) {
      logger.i('User not logged in. Redirecting to Sign-in page.');
      return AppRoutes.path(AppPage.signin);
    }

    logger.i('Proceeding to requested route: ${state.uri.toString()}');
    return null;
  }
}
