// Package imports:
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';

// Project imports:
import 'package:scr_vendor/common/log/log.dart';
import 'package:scr_vendor/features/auth/domain/exceptions/user_mobile_already_exists_exception.dart';

/// Abstract definition for the authentication remote data source.
abstract class AuthRemoteDataSource {
  Future<void> signUp(String mobileNumber);
  Future<void> signIn(String mobileNumber);
}

/// Implementation of the authentication remote data source using AWS Amplify.
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final log = Log();

  /// Signs up a new user with provided [user] details.
  @override
  Future<void> signUp(String mobileNumber) async {
    try {
      log.i('Attempting signup for user: $mobileNumber');
      SignUpResult res = await Amplify.Auth.signUp(
        username: mobileNumber,
        password: 'Notebook@12', // TODO: Handle password securely
      );
      log.i('Signup successful, result: $res');
    } on UsernameExistsException catch (e) {
      log.e('Signup failed - Username already exists: $e');
      throw UserMobileAlreadyExistsException(e.message);
    } on AuthException catch (e) {
      log.e('Signup failed - AuthException: $e');
      rethrow; // Rethrows the exception for higher-level handling
    }
  }

  // @override
  @override
  Future<void> signIn(String mobileNumber) async {
    try {
      log.i('Attempting sign-in for user: $mobileNumber');
      SignInResult res = await Amplify.Auth.signIn(
        username: mobileNumber,
      );
      log.i('Sign-in successful, result: $res');
    } on UserNotFoundException catch (e) {
      log.e('Sign-in failed - User not found: $e');
      throw UserNotFoundException(e.message);
    } on AuthException catch (e) {
      log.e('Sign-in failed - AuthException: $e');
      rethrow; // Rethrows the exception for higher-level handling
    }
  }
}
