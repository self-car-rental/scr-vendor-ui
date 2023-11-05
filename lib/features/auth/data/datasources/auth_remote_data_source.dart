// Package imports:
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';

// Project imports:
import 'package:scr_vendor/common/log/log.dart';
import 'package:scr_vendor/features/auth/data/models/user_cognito_model.dart';
import 'package:scr_vendor/features/auth/domain/exceptions/user_mobile_already_exists_exception.dart';

/// Abstract definition for the authentication remote data source.
abstract class AuthRemoteDataSource {
  Future<void> signUp(UserCognitoModel user);
}

/// Implementation of the authentication remote data source using AWS Amplify.
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final log = Log();

  /// Signs up a new user with provided [user] details.
  @override
  Future<void> signUp(UserCognitoModel user) async {
    try {
      log.i('Attempting signup for user: $user');
      SignUpResult res = await Amplify.Auth.signUp(
        username: user.mobile,
        password: 'Notebook@12', // TODO: Handle password securely
        options: SignUpOptions(
          userAttributes: <AuthUserAttributeKey, String>{
            AuthUserAttributeKey.name: user.name,
            AuthUserAttributeKey.email: user.email,
          },
        ),
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
}
