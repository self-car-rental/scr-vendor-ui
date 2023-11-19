// Flutter imports:

// Flutter imports:
import 'package:flutter/foundation.dart' show immutable;

// Project imports:
import 'package:scr_vendor/core/services/auth_preference_service.dart';
import 'package:scr_vendor/core/utils/app_logger.dart';
import 'package:scr_vendor/features/auth/domain/repositories/auth_repository.dart';
import 'package:scr_vendor/service_locator.dart';

@immutable
class CheckUserLoggedInUseCase {
  final AuthRepository _repository;
  final AppLogger _logger = AppLogger(); // Add AppLogger instance

  CheckUserLoggedInUseCase(this._repository);

  Future<bool> execute() async {
    try {
      _logger.info('CheckUserLoggedInUseCase: Checking if user is logged in');
      bool isLoggedIn = await _repository.checkUserLoggedIn();

      if (!isLoggedIn) {
        final authPreferenceService = serviceLocator<AuthPreferenceService>();
        await authPreferenceService.setLoggedIn(false);
        _logger.info(
            'CheckUserLoggedInUseCase: User not logged in, status set to false');
      }

      return isLoggedIn;
    } catch (e) {
      _logger.error(
          'CheckUserLoggedInUseCase: Error checking user login status: ${e.toString()}');
      return false;
    }
  }
}
