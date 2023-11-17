// Package imports:
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';

// Project imports:
import 'package:scr_vendor/core/utils/app_error_handler.dart';
import 'package:scr_vendor/core/utils/app_logger.dart';
import 'package:scr_vendor/features/auth/domain/exceptions/invalid_otp_exception.dart';
import 'package:scr_vendor/features/auth/domain/exceptions/user_mobile_already_exists_exception.dart';

// Project imports:

/// Abstract definition for the authentication remote data source.
abstract class AuthRemoteDataSource {
  Future<void> signUp(String mobileNumber);
  Future<void> signIn(String mobileNumber);
  Future<void> verifyOtp(String otp);
  Future<void> signOut();
  Future<bool> checkUserLoggedIn();
}

/// Implementation of the authentication remote data source using AWS Amplify.
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final AppLogger _logger = AppLogger();

  /// Signs up a new user with provided [user] details.
  @override
  Future<void> signUp(String mobileNumber) async {
    try {
      _logger.info('Attempting signup for user: $mobileNumber');
      SignUpResult signUpResult = await Amplify.Auth.signUp(
        username: mobileNumber,
        password: 'Notebook@12', // TODO: Handle password securely
      );
      _logger.info('Signup successful, result: $signUpResult');
    } on UsernameExistsException catch (e) {
      _logger.error('Signup failed - Username already exists: $e');
      throw UserMobileAlreadyExistsException(e.message);
    } on AuthException catch (e) {
      ErrorHandler.handleException(e);
      _logger.error('Signup failed - AuthException: $e');
      rethrow; // Rethrows the exception for higher-level handling
    }
  }

  // @override
  @override
  Future<void> signIn(String mobileNumber) async {
    try {
      _logger.info('Attempting sign-in for user: $mobileNumber');
      SignInResult signInResult = await Amplify.Auth.signIn(
        username: mobileNumber,
      );
      _logger.info('Sign-in successful, result: $signInResult');
    } on UserNotFoundException catch (e) {
      _logger.error('Sign-in failed - User not found: $e');
      throw UserNotFoundException(e.message);
    } on AuthException catch (e) {
      ErrorHandler.handleException(e);
      _logger.error('Sign-in failed - AuthException: $e');
      rethrow; // Rethrows the exception for higher-level handling
    }
  }

  @override
  Future<void> verifyOtp(String otp) async {
    try {
      _logger.info('Attempting OTP verification: $otp');
      final SignInResult signInResult = await Amplify.Auth.confirmSignIn(
        confirmationValue: otp,
      );

      if (signInResult.isSignedIn) {
        _logger.info(
            'OTP verification successful, user signed in result: $signInResult.');
      } else {
        _logger.warning('OTP verification successful, but user not signed in.');
        throw InvalidOtpException();
      }
    } on AuthException catch (e) {
      ErrorHandler.handleException(e);
      _logger.error('OTP verification failed - AuthException: $e');
      rethrow; // Propagates the exception for higher-level handling
    }
  }

  @override
  Future<void> signOut() async {
    try {
      _logger.info('Attempting user sign out');
      await Amplify.Auth.signOut();
      _logger.info('User signed out successfully');
    } on AuthException catch (e) {
      ErrorHandler.handleException(e);
      _logger.error('Sign out failed - AuthException: $e');
      rethrow; // Rethrows the exception for higher-level handling
    }
  }

  @override
  Future<bool> checkUserLoggedIn() async {
    try {
      final authSession = await Amplify.Auth.fetchAuthSession();
      _logger.info(
          'Successfully fetched auth session : ${authSession.isSignedIn}');
      return authSession.isSignedIn;
    } on AuthException catch (authException) {
      _logger.error('AuthException caught: ${authException.message}');
      return false;
    } catch (e) {
      ErrorHandler.handleException(e);
      _logger.error('Unexpected error occurred: ${e.toString()}');
      return false;
    }
  }
}
