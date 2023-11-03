// Package imports:
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

// Project imports:
import 'package:scr_vendor/common/amplify/amplify_client.dart';
import 'package:scr_vendor/common/network/dio_client.dart';
import 'package:scr_vendor/features/user/data/datasources/user_remote_data_source.dart';
import 'package:scr_vendor/features/user/data/repositories/user_repository_impl.dart';
import 'package:scr_vendor/features/user/domain/repositories/user_repository.dart';
import 'package:scr_vendor/features/user/domain/usecases/create_user_usecase.dart';
import 'package:scr_vendor/features/user/domain/usecases/delete_user_usecase.dart';
import 'package:scr_vendor/features/user/domain/usecases/get_users_usecase.dart';
import 'package:scr_vendor/features/user/domain/usecases/update_user_usecase.dart';
import 'package:scr_vendor/features/user/presentation/bloc/user_bloc.dart';

final getIt = GetIt.instance;

Future<void> init() async {
  //Amplify
  getIt.registerLazySingleton<AmplifyClient>(() => AmplifyClient());

  //UserBloc
  getIt.registerFactory(
    () => UserBloc(
      getUsersUseCase: getIt<GetUsersUseCase>(),
      createUserUseCase: getIt<CreateUserUseCase>(),
      updateUserUseCase: getIt<UpdateUserUseCase>(),
      deleteUserUseCase: getIt<DeleteUserUseCase>(),
    ),
  );

  // User Use cases
  getIt.registerLazySingleton(() => GetUsersUseCase(getIt<UserRepository>()));
  getIt.registerLazySingleton(() => CreateUserUseCase(getIt<UserRepository>()));
  getIt.registerLazySingleton(() => UpdateUserUseCase(getIt<UserRepository>()));
  getIt.registerLazySingleton(() => DeleteUserUseCase(getIt<UserRepository>()));

  // User repository
  getIt.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(remoteDataSource: getIt()),
  );

  // User remote data sources
  getIt.registerLazySingleton<UserRemoteDataSource>(
      () => UserRemoteDataSourceImpl());

  //Dio
  getIt.registerLazySingleton<DioClient>(() => DioClient(getIt<Dio>()));
  getIt.registerLazySingleton<Dio>(() => Dio());
}
