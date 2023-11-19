// Flutter imports:
import 'package:flutter/foundation.dart' show immutable;

// Project imports:
import 'package:scr_vendor/core/utils/app_logger.dart';
import 'package:scr_vendor/features/auth/domain/repositories/auth_repository.dart';

/// This class encapsulates the business logic for signing up a user into
/// the system. It acts as an intermediary between the presentation layer
/// and the data layer, represented by the [AuthRepository].

@immutable
class SignUpUseCase {
  final AuthRepository _repository;
  final AppLogger _logger = AppLogger(); // Add AppLogger instance

  SignUpUseCase(this._repository);

  Future<void> execute(SignUpParams params) async {
    try {
      _logger.info(
          'SignUpUseCase: Attempting to sign up with mobile number: ${params.mobileNumber}');
      return await _repository.signUp(params.mobileNumber);
    } catch (e) {
      _logger.error('SignUpUseCase: Error during sign up: ${e.toString()}');
      rethrow;
    }
  }
}

/// This class holds the data required to execute the sign-up use case.
@immutable
class SignUpParams {
  final String mobileNumber;

  const SignUpParams(this.mobileNumber);
}
