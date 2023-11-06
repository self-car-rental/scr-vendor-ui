// Package imports:
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:scr_vendor/common/log/log.dart';
// Project imports:

import 'package:scr_vendor/features/auth/domain/exceptions/invalid_otp_exception.dart';
import 'package:scr_vendor/features/auth/domain/exceptions/user_mobile_already_exists_exception.dart';

/// Abstract definition for the authentication remote data source.
abstract class AuthRemoteDataSource {
  Future<void> signUp(String mobileNumber);
  Future<void> signIn(String mobileNumber);
  Future<void> verifyOtp(String otp);
  Future<void> signOut();
}

/// Implementation of the authentication remote data source using AWS Amplify.
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final logger = Log();

  /// Signs up a new user with provided [user] details.
  @override
  Future<void> signUp(String mobileNumber) async {
    try {
      logger.i('Attempting signup for user: $mobileNumber');
      SignUpResult signUpResult = await Amplify.Auth.signUp(
        username: mobileNumber,
        password: 'Notebook@12', // TODO: Handle password securely
      );
      logger.i('Signup successful, result: $signUpResult');
    } on UsernameExistsException catch (e) {
      logger.e('Signup failed - Username already exists: $e');
      throw UserMobileAlreadyExistsException(e.message);
    } on AuthException catch (e) {
      logger.e('Signup failed - AuthException: $e');
      rethrow; // Rethrows the exception for higher-level handling
    }
  }

  // @override
  @override
  Future<void> signIn(String mobileNumber) async {
    try {
      logger.i('Attempting sign-in for user: $mobileNumber');
      SignInResult signInResult = await Amplify.Auth.signIn(
        username: mobileNumber,
      );
      logger.i('Sign-in successful, result: $signInResult');
    } on UserNotFoundException catch (e) {
      logger.e('Sign-in failed - User not found: $e');
      throw UserNotFoundException(e.message);
    } on AuthException catch (e) {
      logger.e('Sign-in failed - AuthException: $e');
      rethrow; // Rethrows the exception for higher-level handling
    }
  }

  @override
  Future<void> verifyOtp(String otp) async {
    try {
      logger.i('Attempting OTP verification: $otp');
      final SignInResult signInResult = await Amplify.Auth.confirmSignIn(
        confirmationValue: otp,
      );

      if (signInResult.isSignedIn) {
        logger.i(
            'OTP verification successful, user signed in result: $signInResult.');
      } else {
        logger.w('OTP verification successful, but user not signed in.');
        throw InvalidOtpException();
      }
    } on AuthException catch (e) {
      logger.e('OTP verification failed - AuthException: $e');
      rethrow; // Propagates the exception for higher-level handling
    }
  }

  @override
  Future<void> signOut() async {
    try {
      logger.i('Attempting user sign out');
      await Amplify.Auth.signOut();
      logger.i('User signed out successfully');
    } on AuthException catch (e) {
      logger.e('Sign out failed - AuthException: $e');
      rethrow; // Rethrows the exception for higher-level handling
    }
  }
}
