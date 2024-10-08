// Package imports:
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';

// Project imports:
import 'package:scr_vendor_ui/core/bloc/connectivity/connectivity_bloc.dart';
import 'package:scr_vendor_ui/core/bloc/error/error_bloc.dart';
import 'package:scr_vendor_ui/core/services/auth_preference_service.dart';
import 'package:scr_vendor_ui/core/services/language_preference_service.dart';
import 'package:scr_vendor_ui/core/services/theme_preference_service.dart';
import 'package:scr_vendor_ui/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:scr_vendor_ui/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:scr_vendor_ui/features/auth/domain/repositories/auth_repository.dart';
import 'package:scr_vendor_ui/features/auth/domain/usecases/check_user_logged_in_usecase.dart';
import 'package:scr_vendor_ui/features/auth/domain/usecases/sign_in_usecase.dart';
import 'package:scr_vendor_ui/features/auth/domain/usecases/sign_out_usecase.dart';
import 'package:scr_vendor_ui/features/auth/domain/usecases/sign_up_usecase.dart';
import 'package:scr_vendor_ui/features/auth/domain/usecases/verify_otp_usecase.dart';
import 'package:scr_vendor_ui/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:scr_vendor_ui/features/user/data/datasources/user_remote_data_source.dart';
import 'package:scr_vendor_ui/features/user/data/repositories/user_repository_impl.dart';
import 'package:scr_vendor_ui/features/user/domain/repositories/user_repository.dart';
import 'package:scr_vendor_ui/features/user/domain/usecases/create_user_usecase.dart';
import 'package:scr_vendor_ui/features/user/domain/usecases/delete_user_usecase.dart';
import 'package:scr_vendor_ui/features/user/domain/usecases/get_users_usecase.dart';
import 'package:scr_vendor_ui/features/user/domain/usecases/update_user_usecase.dart';
import 'package:scr_vendor_ui/features/user/presentation/bloc/user_bloc.dart';

final serviceLocator = GetIt.instance;

Future<void> initServiceLocator() async {
  // error handling
  _registerErrorHandler();

  // Connectivity handling
  _registerConnectivity();

  // Localization handling
  _registerLocalization();

  // Theme handling
  _registerTheme();

  // Auth Features
  _registerAuthFeatures();

  // User Features
  _registerUserFeatures();
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
      checkUserLoggedInUseCase: serviceLocator(),
      signUpUseCase: serviceLocator(),
      signInUseCase: serviceLocator(),
      verifyOtpUseCase: serviceLocator(),
      signOutUseCase: serviceLocator(),
    ),
  );

  // Use Cases
  serviceLocator
      .registerLazySingleton(() => CheckUserLoggedInUseCase(serviceLocator()));
  serviceLocator.registerLazySingleton(() => SignUpUseCase(serviceLocator()));
  serviceLocator.registerLazySingleton(() => SignInUseCase(serviceLocator()));
  serviceLocator
      .registerLazySingleton(() => VerifyOtpUseCase(serviceLocator()));
  serviceLocator.registerLazySingleton(() => SignOutUseCase(serviceLocator()));

  // Repository
  serviceLocator.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(remoteDataSource: serviceLocator()),
  );

  // Data Sources
  serviceLocator.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(),
  );

  // Preference Service
  serviceLocator.registerLazySingleton(() => AuthPreferenceService());
}

void _registerConnectivity() {
  serviceLocator.registerLazySingleton(() => Connectivity());
  serviceLocator
      .registerLazySingleton(() => ConnectivityBloc(serviceLocator()));
}

void _registerLocalization() {
  serviceLocator.registerLazySingleton(() => LanguagePreferenceService());
}

void _registerTheme() {
  serviceLocator.registerLazySingleton(() => ThemePreferenceService());
}

void _registerErrorHandler() {
  serviceLocator.registerLazySingleton(() => ErrorBloc());
}
