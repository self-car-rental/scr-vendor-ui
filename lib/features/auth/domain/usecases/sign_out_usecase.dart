// Flutter imports:

// Flutter imports:
import 'package:flutter/foundation.dart' show immutable;

// Project imports:
import 'package:scr_vendor/core/services/auth_preference_service.dart';
import 'package:scr_vendor/core/utils/logger.dart';
import 'package:scr_vendor/features/auth/domain/repositories/auth_repository.dart';
import 'package:scr_vendor/service_locator.dart';

@immutable
class SignOutUseCase {
  final AuthRepository _repository;
  final AppLogger _logger = AppLogger(); // Add AppLogger instance

  SignOutUseCase(this._repository);

  Future<void> execute() async {
    try {
      _logger.info('SignOutUseCase: Attempting to sign out');
      await _repository.signOut();
      final authPreferenceService = serviceLocator<AuthPreferenceService>();
      await authPreferenceService.setLoggedIn(false);
      _logger.info(
          'SignOutUseCase: User signed out and local login status updated');
    } catch (e) {
      _logger.error('SignOutUseCase: Error during sign out: ${e.toString()}');
      rethrow;
    }
  }
}
