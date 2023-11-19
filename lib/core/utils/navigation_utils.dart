// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:go_router/go_router.dart';

// Project imports:
import 'package:scr_vendor/constants/app_route_constants.dart';

class NavigationUtils {
  /// Navigates to a specified page based on the given [pageName].
  ///
  /// [context] is the BuildContext from which navigation is triggered.
  static void _navigateTo(BuildContext context, String pageName) {
    context.goNamed(pageName);
  }

  static void navigateToSignIn(BuildContext context) {
    _navigateTo(context, AppPage.signin.name);
  }

  static void navigateToVerifyOtp(BuildContext context) {
    _navigateTo(context, AppPage.verifyOtp.name);
  }

  static void navigateToHubs(BuildContext context) {
    _navigateTo(context, AppPage.hubs.name);
  }

  static void navigateToCreateHub(BuildContext context) {
    _navigateTo(context, AppPage.hubsCreate.name);
  }

  static void navigateToEditHub(BuildContext context, String id) {
    context
        .goNamed(AppRoutes.name(AppPage.hubsEdit), pathParameters: {'id': id});
  }
}
