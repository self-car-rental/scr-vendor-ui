// Flutter imports:
import 'package:flutter/foundation.dart';

// Project imports:
import 'package:scr_vendor/features/auth/domain/repositories/auth_repository.dart';

@immutable
class VerifyOtpUseCase {
  final AuthRepository _repository;

  const VerifyOtpUseCase(this._repository);

  Future<void> execute(VerifyOtpParams params) async {
    try {
      await _repository.verifyOtp(params.otp);
    } catch (e) {
      // Handle other exceptions
      rethrow;
    }
  }
}

@immutable
class VerifyOtpParams {
  final String otp;

  const VerifyOtpParams(this.otp);
}
