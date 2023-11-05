// Package imports:
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

// Project imports:
import 'package:scr_vendor/common/network/dio_client.dart';
import 'package:scr_vendor/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:scr_vendor/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:scr_vendor/features/auth/domain/repositories/auth_repository.dart';
import 'package:scr_vendor/features/auth/domain/usecases/sign_in_usecase.dart';
import 'package:scr_vendor/features/auth/domain/usecases/sign_up_usecase.dart';
import 'package:scr_vendor/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:scr_vendor/features/user/data/datasources/user_remote_data_source.dart';
import 'package:scr_vendor/features/user/data/repositories/user_repository_impl.dart';
import 'package:scr_vendor/features/user/domain/repositories/user_repository.dart';
import 'package:scr_vendor/features/user/domain/usecases/create_user_usecase.dart';
import 'package:scr_vendor/features/user/domain/usecases/delete_user_usecase.dart';
import 'package:scr_vendor/features/user/domain/usecases/get_users_usecase.dart';
import 'package:scr_vendor/features/user/domain/usecases/update_user_usecase.dart';
import 'package:scr_vendor/features/user/presentation/bloc/user_bloc.dart';

final serviceLocator = GetIt.instance;

Future<void> initServiceLocator() async {
  // Dio
  serviceLocator.registerLazySingleton<Dio>(() => Dio());
  serviceLocator
      .registerLazySingleton<DioClient>(() => DioClient(serviceLocator()));

  // User Features
  _registerUserFeatures();

  // Auth Features
  _registerAuthFeatures();
}

void _registerUserFeatures() {
  // Bloc
  serviceLocator.registerFactory(
    () => UserBloc(
      getUsersUseCase: serviceLocator(),
      createUserUseCase: serviceLocator(),
      updateUserUseCase: serviceLocator(),
      deleteUserUseCase: serviceLocator(),
    ),
  );

  // Use Cases
  serviceLocator.registerLazySingleton(() => GetUsersUseCase(serviceLocator()));
  serviceLocator
      .registerLazySingleton(() => CreateUserUseCase(serviceLocator()));
  serviceLocator
      .registerLazySingleton(() => UpdateUserUseCase(serviceLocator()));
  serviceLocator
      .registerLazySingleton(() => DeleteUserUseCase(serviceLocator()));

  // Repository
  serviceLocator.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(remoteDataSource: serviceLocator()),
  );

  // Data Sources
  serviceLocator.registerLazySingleton<UserRemoteDataSource>(
    () => UserRemoteDataSourceImpl(),
  );
}

void _registerAuthFeatures() {
  // Bloc
  serviceLocator.registerFactory(
    () => AuthBloc(
      signUpUseCase: serviceLocator(),
      signInUseCase: serviceLocator(),
    ),
  );

  // Use Cases
  serviceLocator.registerLazySingleton(() => SignUpUseCase(serviceLocator()));
  serviceLocator.registerLazySingleton(() => SignInUseCase(serviceLocator()));

  // Repository
  serviceLocator.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(remoteDataSource: serviceLocator()),
  );

  // Data Sources
  serviceLocator.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(),
  );
}
