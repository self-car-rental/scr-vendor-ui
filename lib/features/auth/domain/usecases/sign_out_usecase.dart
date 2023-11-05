// Flutter imports:

// Flutter imports:
import 'package:flutter/foundation.dart' show immutable;

// Project imports:
import 'package:scr_vendor/features/auth/domain/repositories/auth_repository.dart';

@immutable
class SignOutUseCase {
  final AuthRepository _repository;

  const SignOutUseCase(this._repository);

  Future<void> execute() async {
    try {
      await _repository.signOut();
    } catch (e) {
      // Handle other exceptions
      rethrow;
    }
  }
}
