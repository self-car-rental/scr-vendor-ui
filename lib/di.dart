// Package imports:
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

// Project imports:
import 'package:scr_vendor/common/network/dio_client.dart';
import 'package:scr_vendor/features/user/data/datasources/user_remote_data_source.dart';
import 'package:scr_vendor/features/user/data/repositories/user_repository_impl.dart';
import 'package:scr_vendor/features/user/domain/repositories/user_repository.dart';
import 'package:scr_vendor/features/user/domain/usecases/create_user_usecase.dart';
import 'package:scr_vendor/features/user/domain/usecases/delete_user_usecase.dart';
import 'package:scr_vendor/features/user/domain/usecases/get_users_usecase.dart';
import 'package:scr_vendor/features/user/domain/usecases/update_user_usecase.dart';
import 'package:scr_vendor/features/user/presentation/bloc/user_bloc.dart';

final locator = GetIt.instance;

Future<void> initLocator() async {
  //UserBloc
  locator.registerFactory(
    () => UserBloc(
      getUsersUseCase: locator<GetUsersUseCase>(),
      createUserUseCase: locator<CreateUserUseCase>(),
      updateUserUseCase: locator<UpdateUserUseCase>(),
      deleteUserUseCase: locator<DeleteUserUseCase>(),
    ),
  );

  // User Use cases
  locator
      .registerLazySingleton(() => GetUsersUseCase(locator<UserRepository>()));
  locator.registerLazySingleton(
      () => CreateUserUseCase(locator<UserRepository>()));
  locator.registerLazySingleton(
      () => UpdateUserUseCase(locator<UserRepository>()));
  locator.registerLazySingleton(
      () => DeleteUserUseCase(locator<UserRepository>()));

  // User repository
  locator.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(remoteDataSource: locator()),
  );

  // User remote data sources
  locator.registerLazySingleton<UserRemoteDataSource>(
      () => UserRemoteDataSourceImpl());

  //Dio
  locator.registerLazySingleton<DioClient>(() => DioClient(locator<Dio>()));
  locator.registerLazySingleton<Dio>(() => Dio());
}
