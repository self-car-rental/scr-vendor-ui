// This file contains the implementation of the AuthRepository interface, providing concrete methods for authentication operations.

// Project imports:
import 'package:scr_vendor/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:scr_vendor/features/auth/data/models/user_cognito_model.dart';
import 'package:scr_vendor/features/auth/domain/repositories/auth_repository.dart';

/// Implementation of [AuthRepository] interface.
///
/// This class communicates with the remote data source to perform authentication operations.
class AuthRepositoryImpl extends AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  /// Constructs an instance of [AuthRepositoryImpl] with the given [remoteDataSource].
  AuthRepositoryImpl({required this.remoteDataSource});

  /// Signs up a user using Cognito authentication.
  ///
  /// Takes a [UserCognitoModel] and delegates the sign-up operation to the remote data source.
  @override
  Future<void> signUp(UserCognitoModel user) async {
    // Additional error handling or processing can be added here if needed.
    return await remoteDataSource.signUp(user);
  }
}
