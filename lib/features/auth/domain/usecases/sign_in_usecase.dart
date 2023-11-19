// Flutter imports:

// Flutter imports:
import 'package:flutter/foundation.dart';

// Package imports:
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';

// Project imports:
import 'package:scr_vendor/core/utils/app_logger.dart';
import 'package:scr_vendor/features/auth/domain/repositories/auth_repository.dart';
import 'package:scr_vendor/features/auth/domain/usecases/sign_up_usecase.dart';

@immutable
class SignInUseCase {
  final AuthRepository _repository;
  final AppLogger _logger = AppLogger(); // Add AppLogger

  SignInUseCase(this._repository);

  Future<void> execute(SignInParams params) async {
    try {
      _logger.info(
          'SignInUseCase: Attempting to sign in with mobile number: ${params.mobileNumber}');
      await _repository.signIn(params.mobileNumber);
    } on UserNotFoundException {
      _logger.warning(
          'SignInUseCase: User not found, proceeding to sign up: ${params.mobileNumber}');
      // If the user is not found, proceed to sign up and then sign in again
      await _handleUserNotFound(params.mobileNumber);
    } catch (e) {
      _logger.error('SignInUseCase: Error during sign in: ${e.toString()}');
      rethrow;
    }
  }

  Future<void> _handleUserNotFound(String mobileNumber) async {
    try {
      _logger.info('SignInUseCase: Handling user not found: $mobileNumber');
      await SignUpUseCase(_repository).execute(SignUpParams(mobileNumber));
      await _repository.signIn(mobileNumber);
    } catch (e) {
      _logger.error(
          'SignInUseCase: Error during handling user not found: ${e.toString()}');
      rethrow;
    }
  }
}

@immutable
class SignInParams {
  final String mobileNumber;

  const SignInParams(this.mobileNumber);
}
