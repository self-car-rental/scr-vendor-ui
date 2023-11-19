// Package imports:
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:scr_vendor_ui/features/auth/domain/exceptions/invalid_otp_exception.dart';
import 'package:scr_vendor_ui/features/auth/domain/exceptions/user_mobile_already_exists_exception.dart';
import 'package:scr_vendor_ui/features/auth/domain/usecases/check_user_logged_in_usecase.dart';
import 'package:scr_vendor_ui/features/auth/domain/usecases/sign_in_usecase.dart';
import 'package:scr_vendor_ui/features/auth/domain/usecases/sign_out_usecase.dart';
import 'package:scr_vendor_ui/features/auth/domain/usecases/sign_up_usecase.dart';
import 'package:scr_vendor_ui/features/auth/domain/usecases/verify_otp_usecase.dart';
import 'package:scr_vendor_ui/features/auth/presentation/bloc/auth_event.dart';
import 'package:scr_vendor_ui/features/auth/presentation/bloc/auth_state.dart';

/// A BLoC (Business Logic Component) for handling authentication-related operations.
///
/// emitting [AuthState]s.
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignUpUseCase signUpUseCase;
  final SignInUseCase signInUseCase;
  final VerifyOtpUseCase verifyOtpUseCase;
  final SignOutUseCase signOutUseCase;
  final CheckUserLoggedInUseCase checkUserLoggedInUseCase;

  AuthBloc({
    required this.signUpUseCase,
    required this.signInUseCase,
    required this.verifyOtpUseCase,
    required this.signOutUseCase,
    required this.checkUserLoggedInUseCase,
  }) : super(AuthInitial()) {
    on<CheckUserLoggedInRequested>(_onCheckUserLoggedInRequested);
    on<SignUpRequested>(_onSignUpRequested);
    on<SignInRequested>(_onSignInRequested);
    on<VerifyOtpRequested>(_onVerifyOtpRequested);
    on<SignOutRequested>(_onSignOutRequested);
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
    } catch (e) {
      emit(SignUpFailure(e.toString()));
    }
  }

  Future<void> _onSignInRequested(
      SignInRequested event, Emitter<AuthState> emit) async {
    emit(SignInLoading());
    try {
      await signInUseCase.execute(SignInParams(event.mobileNumber));
      emit(SignInSuccess());
    } on NotAuthorizedServiceException catch (exception) {
      emit(SignInFailure(exception.message));
    } catch (e) {
      emit(SignInFailure(e.toString()));
    }
  }

  Future<void> _onVerifyOtpRequested(
      VerifyOtpRequested event, Emitter<AuthState> emit) async {
    emit(VerifyOtpLoading());
    try {
      await verifyOtpUseCase.execute(VerifyOtpParams(event.otp));
      emit(VerifyOtpSuccess());
    } on InvalidOtpException {
      emit(VerifyOtpInvalid());
    } on NotAuthorizedServiceException {
      emit(VerifyOtpFailedThrice());
    } catch (e) {
      emit(VerifyOtpFailure(e.toString()));
    }
  }

  Future<void> _onSignOutRequested(
      SignOutRequested event, Emitter<AuthState> emit) async {
    emit(SignOutLoading());
    try {
      await signOutUseCase.execute();
      emit(SignOutSuccess());
    } catch (e) {
      emit(SignOutFailure(e.toString()));
    }
  }

  Future<void> _onCheckUserLoggedInRequested(
      CheckUserLoggedInRequested event, Emitter<AuthState> emit) async {
    emit(CheckAuthStatusLoading());
    try {
      final isLoggedIn = await checkUserLoggedInUseCase.execute();
      emit(isLoggedIn
          ? CheckAuthStatusAuthenticated()
          : CheckAuthStatusUnAuthenticated());
    } catch (e) {
      emit(CheckAuthStatusFailure(e.toString()));
    }
  }
}
