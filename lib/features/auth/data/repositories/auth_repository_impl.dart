// Package imports:
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';

// Project imports:
import 'package:scr_vendor_ui/core/utils/error_handler.dart';
import 'package:scr_vendor_ui/core/utils/logger.dart';
import 'package:scr_vendor_ui/features/auth/data/datasources/auth_remote_data_source.dart';

import 'package:scr_vendor_ui/features/auth/domain/repositories/auth_repository.dart'; // Import AppLogger

class AuthRepositoryImpl extends AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AppLogger _logger = AppLogger(); // Add AppLogger instance

  AuthRepositoryImpl({required this.remoteDataSource});

  @override
  Future<void> signIn(String mobileNumber) async {
    try {
      _logger.info(
          'AuthRepositoryImpl: Attempting to sign in with mobile number: $mobileNumber');
      return await remoteDataSource.signIn(mobileNumber);
    } on UserNotFoundException {
      rethrow;
    } on NotAuthorizedServiceException {
      rethrow;
    } catch (e) {
      _logger.error(
          'AuthRepositoryImpl: Sign-in failed for mobile number $mobileNumber: ${e.toString()}');
      ErrorHandler.handleException(e);
      rethrow;
    }
  }

  @override
  Future<void> signUp(String mobileNumber) async {
    try {
      _logger.info(
          'AuthRepositoryImpl: Attempting to sign up with mobile number: $mobileNumber');
      return await remoteDataSource.signUp(mobileNumber);
    } catch (e) {
      _logger.error(
          'AuthRepositoryImpl: Sign-up failed for mobile number $mobileNumber: ${e.toString()}');
      ErrorHandler.handleException(e);
      rethrow;
    }
  }

  @override
  Future<bool> verifyOtp(String otp) async {
    try {
      _logger.info('AuthRepositoryImpl: Attempting to verify OTP: $otp');
      return await remoteDataSource.verifyOtp(otp);
    } on NotAuthorizedServiceException {
      rethrow;
    } catch (e) {
      _logger.error(
          'AuthRepositoryImpl: OTP verification failed for OTP $otp: ${e.toString()}');
      ErrorHandler.handleException(e);
      rethrow;
    }
  }

  @override
  Future<void> signOut() async {
    try {
      _logger.info('AuthRepositoryImpl: Attempting to sign out');
      return await remoteDataSource.signOut();
    } catch (e) {
      _logger.error('AuthRepositoryImpl: Sign-out failed: ${e.toString()}');
      ErrorHandler.handleException(e);
      rethrow;
    }
  }

  @override
  Future<bool> checkUserLoggedIn() async {
    try {
      _logger.info('AuthRepositoryImpl: Checking if user is logged in');
      return await remoteDataSource.checkUserLoggedIn();
    } catch (e) {
      _logger.error(
          'AuthRepositoryImpl: Error checking if user is logged in: ${e.toString()}');
      ErrorHandler.handleException(e);
      rethrow;
    }
  }
}
