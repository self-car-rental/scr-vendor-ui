// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

// Project imports:
import 'package:scr_vendor/constants/app_route_constants.dart';
import 'package:scr_vendor/core/bottom_navigation/bottom_navigation_cubit.dart';
import 'package:scr_vendor/core/services/auth_preference_service.dart';
import 'package:scr_vendor/core/utils/app_logger.dart';
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
            //hubs
            _buildGoRoute(
                AppPage.hubs, (context, state) => const HubListScreen(), [
              _buildGoRoute(AppPage.hubsCreate,
                  (context, state) => const CreateHubScreen()),
              _buildGoRoute(AppPage.hubsEdit, (context, state) {
                final hubId = state.pathParameters['id'] ?? '';
                return EditHubScreen(hubId: hubId);
              }),
            ]),
            //cars
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

  /// Redirects to the appropriate page based on the user's login status.
  ///
  /// This function first checks the local preference for login status. If true,
  /// it then confirms the user's session with AWS Cognito using Amplify. This
  /// approach addresses an issue where fetching the auth session directly
  /// from AWS Cognito could lead to errors on the first launch.
  ///
  /// If the user is not logged in, they are redirected to the sign-in page.
  /// Otherwise, they proceed to the requested route.
  ///
  /// [context]: The BuildContext for widget tree access.
  /// [state]: The current GoRouterState.
  ///
  /// Returns a string URI to redirect to, or null for no redirection.
  static Future<String?> _redirectLogic(
      BuildContext context, GoRouterState state) async {
    final AppLogger logger = AppLogger();
    final authBloc = context.read<AuthBloc>();
    final authPreferenceService = AuthPreferenceService();

    // Check local preference for logged in status
    final bool isPreferenceLoggedIn = await authPreferenceService.isLoggedIn();

    // Determine if user is logged in based on local preference and AWS Cognito session
    final bool userIsLoggedIn = isPreferenceLoggedIn
        ? await authBloc.checkUserLoggedInUseCase.execute()
        : false;

    // Define paths that don't require login
    final String currentPath = state.uri.toString();
    final String signInPath = AppRoutes.path(AppPage.signin);
    final String verifyOtpPath = AppRoutes.path(AppPage.verifyOtp);

    // Redirect to sign-in if user is not logged in and trying to access restricted paths
    if (!userIsLoggedIn &&
        currentPath != signInPath &&
        currentPath != verifyOtpPath) {
      logger.info('User not logged in. Redirecting to Sign-in page.');
      return signInPath;
    }

    // Log and allow access to the requested route
    logger.info('Proceeding to requested route: $currentPath');
    return null;
  }
}
