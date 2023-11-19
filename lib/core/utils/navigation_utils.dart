// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:go_router/go_router.dart';

// Project imports:
import 'package:scr_vendor_ui/constants/app_route_constants.dart';
import 'package:scr_vendor_ui/core/utils/logger.dart';

class NavigationUtils {
  static final AppLogger _logger = AppLogger();

  /// Navigates to a specified page based on the given [pageName].
  ///
  /// [context] is the BuildContext from which navigation is triggered.
  static void _navigateTo(BuildContext context, String pageName) {
    try {
      context.goNamed(pageName);
    } catch (e) {
      _logger.error(
          'NavigationUtils: Failed to navigate to $pageName: ${e.toString()}');
      rethrow; // Rethrow the exception to preserve the stack trace
    }
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
