// Flutter imports:
import 'package:flutter/foundation.dart';

// Project imports:
import 'package:scr_vendor_ui/core/services/auth_preference_service.dart';
import 'package:scr_vendor_ui/core/utils/logger.dart';
import 'package:scr_vendor_ui/features/auth/domain/exceptions/invalid_otp_exception.dart';
import 'package:scr_vendor_ui/features/auth/domain/repositories/auth_repository.dart';
import 'package:scr_vendor_ui/service_locator.dart';

@immutable
class VerifyOtpUseCase {
  final AuthRepository _repository;
  final AppLogger _logger = AppLogger(); // Add AppLogger instance

  VerifyOtpUseCase(this._repository);

  Future<bool> execute(VerifyOtpParams params) async {
    try {
      _logger.info('VerifyOtpUseCase: Attempting to verify OTP: ${params.otp}');
      bool isLoggedIn = await _repository.verifyOtp(params.otp);

      if (!isLoggedIn) {
        _logger.warning('VerifyOtpUseCase: Invalid OTP provided.');
        throw InvalidOtpException();
      }

      await _setLoggedInStatus(true);
      return true;
    } catch (e) {
      _logger.error(
          'VerifyOtpUseCase: Error during OTP verification: ${e.toString()}');
      rethrow;
    }
  }

  Future<void> _setLoggedInStatus(bool status) async {
    final AuthPreferenceService authPreferenceService =
        serviceLocator<AuthPreferenceService>();
    await authPreferenceService.setLoggedIn(status);
    _logger.info('VerifyOtpUseCase: User login status set to $status');
  }
}

/// This class holds the data required to execute the OTP verification use case.
@immutable
class VerifyOtpParams {
  final String otp;

  const VerifyOtpParams(this.otp);
}
