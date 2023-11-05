// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:scr_vendor/features/auth/domain/exceptions/user_mobile_already_exists_exception.dart';
import 'package:scr_vendor/features/auth/domain/usecases/sign_up_usecase.dart';
import 'package:scr_vendor/features/auth/presentation/bloc/auth_event.dart';
import 'package:scr_vendor/features/auth/presentation/bloc/auth_state.dart';

/// A BLoC (Business Logic Component) for handling authentication-related operations.
///
/// emitting [AuthState]s.
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignUpUseCase signUpUseCase;

  /// Constructs an [AuthBloc] with the necessary [signUpUseCase].
  AuthBloc({required this.signUpUseCase}) : super(AuthInitial()) {
    on<SignUpRequested>(_onSignUpRequested);
  }

  /// This function is triggered when a [SignUpRequested] event is added.
  Future<void> _onSignUpRequested(
      SignUpRequested event, Emitter<AuthState> emit) async {
    emit(SignUpLoading());
    try {
      await signUpUseCase.call(SignupUserParams(event.user));
      emit(SignUpSuccess());
    } on UserMobileAlreadyExistsException {
      emit(UserMobileAlreadyExists());
    } on Exception catch (e) {
      emit(SignUpFailure(e.toString()));
    }
  }
}
