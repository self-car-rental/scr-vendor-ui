// Flutter imports:
import 'package:flutter/foundation.dart' show immutable;

// Project imports:
import 'package:scr_vendor/features/auth/data/models/user_cognito_model.dart';
import 'package:scr_vendor/features/auth/domain/repositories/auth_repository.dart';

/// This class encapsulates the business logic for signing up a user into
/// the system. It acts as an intermediary between the presentation layer
/// and the data layer, represented by the [AuthRepository].
@immutable
class SignUpUseCase {
  final AuthRepository repository;

  /// Constructs a [SignUpUseCase] with the given [repository].
  const SignUpUseCase(this.repository);

  Future<void> call(SignupUserParams params) async {
    return await repository.signUp(params.user);
  }
}

/// Parameters required for the sign-up use case.
///
/// This class holds the data required to execute the sign-up use case.

@immutable
class SignupUserParams {
  final UserCognitoModel user;

  const SignupUserParams(this.user);
}
