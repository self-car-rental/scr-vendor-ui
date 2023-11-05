// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:scr_vendor/features/auth/domain/exceptions/user_mobile_already_exists_exception.dart';
import 'package:scr_vendor/features/auth/domain/usecases/sign_in_usecase.dart';
import 'package:scr_vendor/features/auth/domain/usecases/sign_up_usecase.dart';
import 'package:scr_vendor/features/auth/presentation/bloc/auth_event.dart';
import 'package:scr_vendor/features/auth/presentation/bloc/auth_state.dart';

/// A BLoC (Business Logic Component) for handling authentication-related operations.
///
/// emitting [AuthState]s.
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignUpUseCase signUpUseCase;
  final SignInUseCase signInUseCase;

  AuthBloc({required this.signUpUseCase, required this.signInUseCase})
      : super(AuthInitial()) {
    on<SignUpRequested>(_onSignUpRequested);
    on<SignInRequested>(_onSignInRequested);
  }

  /// This function is triggered when a [SignUpRequested] event is added.
  Future<void> _onSignUpRequested(
      SignUpRequested event, Emitter<AuthState> emit) async {
    emit(SignUpLoading());
    try {
      await signUpUseCase.execute(SignUpParams(event.user.mobile));
      emit(SignUpSuccess());
    } on UserMobileAlreadyExistsException {
      emit(UserMobileAlreadyExists());
    } on Exception catch (e) {
      emit(SignUpFailure(e.toString()));
    }
  }

  Future<void> _onSignInRequested(
      SignInRequested event, Emitter<AuthState> emit) async {
    emit(SignInLoading());
    try {
      await signInUseCase.execute(SignInParams(event.mobileNumber));
      emit(SignInSuccess());
    } on Exception catch (e) {
      emit(SignInFailure(e.toString()));
    }
  }
}
