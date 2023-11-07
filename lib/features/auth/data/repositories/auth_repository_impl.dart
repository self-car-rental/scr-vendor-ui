// This file contains the implementation of the AuthRepository interface, providing concrete methods for authentication operations.

// Project imports:
import 'package:scr_vendor/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:scr_vendor/features/auth/domain/repositories/auth_repository.dart';

/// Implementation of [AuthRepository] interface.
///
/// This class communicates with the remote data source to perform authentication operations.
class AuthRepositoryImpl extends AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl({required this.remoteDataSource});

  @override
  Future<void> signIn(String mobileNumber) async {
    return await remoteDataSource.signIn(mobileNumber);
  }

  @override
  Future<void> signUp(String mobileNumber) async {
    return await remoteDataSource.signUp(mobileNumber);
  }

  @override
  Future<void> verifyOtp(String otp) async {
    return await remoteDataSource.verifyOtp(otp);
  }

  @override
  Future<void> signOut() async {
    return await remoteDataSource.signOut();
  }

  @override
  Future<bool> checkUserLoggedIn() async {
    return await remoteDataSource.checkUserLoggedIn();
  }
}
