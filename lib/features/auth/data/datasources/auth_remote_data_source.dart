// Package imports:
import 'package:amplify_flutter/amplify_flutter.dart';

// Project imports:
import 'package:scr_vendor/core/utils/logger.dart';

// Project imports:

/// Abstract definition for the authentication remote data source.
abstract class AuthRemoteDataSource {
  Future<void> signUp(String mobileNumber);
  Future<void> signIn(String mobileNumber);
  Future<bool> verifyOtp(String otp);
  Future<void> signOut();
  Future<bool> checkUserLoggedIn();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final AppLogger _logger = AppLogger();

  @override
  Future<void> signUp(String mobileNumber) async {
    try {
      _logger.info(
          'AuthRemoteDataSourceImpl: Attempting signup for user: $mobileNumber');
      SignUpResult signUpResult = await Amplify.Auth.signUp(
        username: mobileNumber,
        password: 'Notebook@12', // TODO: Handle password securely
      );
      _logger.info(
          'AuthRemoteDataSourceImpl: Signup successful, result: $signUpResult');
    } catch (e) {
      _logger
          .error('AuthRemoteDataSourceImpl: Signup failed - AuthException: $e');
      rethrow;
    }
  }

  @override
  Future<void> signIn(String mobileNumber) async {
    try {
      _logger.info(
          'AuthRemoteDataSourceImpl: Attempting sign-in for user: $mobileNumber');
      SignInResult signInResult = await Amplify.Auth.signIn(
        username: mobileNumber,
      );
      _logger.info(
          'AuthRemoteDataSourceImpl: Sign-in successful, result: $signInResult');
    } catch (e) {
      _logger.error(
          'AuthRemoteDataSourceImpl: Sign-in failed - AuthException: $e');
      rethrow;
    }
  }

  @override
  Future<bool> verifyOtp(String otp) async {
    try {
      _logger
          .info('AuthRemoteDataSourceImpl: Attempting OTP verification: $otp');
      final SignInResult signInResult = await Amplify.Auth.confirmSignIn(
        confirmationValue: otp,
      );
      return signInResult.isSignedIn;
    } catch (e) {
      _logger.error(
          'AuthRemoteDataSourceImpl: OTP verification failed - AuthException: $e');
      rethrow; // Propagates the exception for higher-level handling
    }
  }

  @override
  Future<void> signOut() async {
    try {
      _logger.info('AuthRemoteDataSourceImpl: Attempting user sign out');
      await Amplify.Auth.signOut();
      _logger.info('AuthRemoteDataSourceImpl: User signed out successfully');
    } catch (e) {
      _logger.error(
          'AuthRemoteDataSourceImpl: Sign out failed - AuthException: $e');
      rethrow;
    }
  }

  @override
  Future<bool> checkUserLoggedIn() async {
    try {
      final authSession = await Amplify.Auth.fetchAuthSession(
          options: const FetchAuthSessionOptions(forceRefresh: true));
      _logger.info(
          'AuthRemoteDataSourceImpl: Successfully fetched auth session: ${authSession.isSignedIn}');
      return authSession.isSignedIn;
    } catch (e) {
      _logger.error(
          'AuthRemoteDataSourceImpl: Unexpected error occurred: ${e.toString()}');
      return false;
    }
  }
}
