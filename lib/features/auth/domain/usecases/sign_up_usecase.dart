// Flutter imports:
import 'package:flutter/foundation.dart' show immutable;

// Project imports:
import 'package:scr_vendor/features/auth/domain/repositories/auth_repository.dart';

/// This class encapsulates the business logic for signing up a user into
/// the system. It acts as an intermediary between the presentation layer
/// and the data layer, represented by the [AuthRepository].

@immutable
class SignUpUseCase {
  final AuthRepository _repository;

  const SignUpUseCase(this._repository);

  Future<void> execute(SignUpParams params) async {
    return await _repository.signUp(params.mobileNumber);
  }
}

/// This class holds the data required to execute the sign-up use case.

@immutable
class SignUpParams {
  final String mobileNumber;

  const SignUpParams(this.mobileNumber);
}
