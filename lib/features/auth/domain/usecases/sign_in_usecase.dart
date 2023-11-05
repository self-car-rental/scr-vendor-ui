// Flutter imports:
import 'package:flutter/foundation.dart';

// Package imports:
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';

// Project imports:
import 'package:scr_vendor/features/auth/domain/repositories/auth_repository.dart';
import 'package:scr_vendor/features/auth/domain/usecases/sign_up_usecase.dart';

@immutable
class SignInUseCase {
  final AuthRepository _repository;

  const SignInUseCase(this._repository);

  Future<void> execute(SignInParams params) async {
    try {
      await _repository.signOut();
      await _repository.signIn(params.mobileNumber);
    } on UserNotFoundException {
      // If the user is not found, proceed to sign up and then sign in again
      await _handleUserNotFound(params.mobileNumber);
    } catch (e) {
      // Handle other exceptions
      rethrow;
    }
  }

  Future<void> _handleUserNotFound(String mobileNumber) async {
    await SignUpUseCase(_repository).execute(SignUpParams(mobileNumber));
    await _repository.signIn(mobileNumber);
  }
}

@immutable
class SignInParams {
  final String mobileNumber;

  const SignInParams(this.mobileNumber);
}
