// Flutter imports:

// Flutter imports:
import 'package:flutter/foundation.dart' show immutable;

// Project imports:
import 'package:scr_vendor/features/auth/domain/repositories/auth_repository.dart';

@immutable
class CheckUserLoggedInUseCase {
  final AuthRepository _repository;

  const CheckUserLoggedInUseCase(this._repository);

  Future<bool> execute() => _repository.checkUserLoggedIn();
}
