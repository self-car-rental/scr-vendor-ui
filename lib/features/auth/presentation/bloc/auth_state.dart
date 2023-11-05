// Flutter imports:
import 'package:flutter/foundation.dart' show immutable;

@immutable
abstract class AuthState {}

/// The initial state of the authentication process.
///
/// Represents the state before any authentication action has been taken.
class AuthInitial extends AuthState {}

class SignUpLoading extends AuthState {}

class SignUpSuccess extends AuthState {}

class SignUpFailure extends AuthState {
  final String error;
  SignUpFailure(this.error);
}

class UserMobileAlreadyExists extends AuthState {}

class SignInLoading extends AuthState {}

class SignInSuccess extends AuthState {}

class SignInFailure extends AuthState {
  final String error;
  SignInFailure(this.error);
}

class VerifyOtpLoading extends AuthState {}

class VerifyOtpSuccess extends AuthState {}

class VerifyOtpInvalid extends AuthState {}

class VerifyOtpFailure extends AuthState {
  final String error;
  VerifyOtpFailure(this.error);
}

class SignOutLoading extends AuthState {}

class SignOutSuccess extends AuthState {}

class SignOutFailure extends AuthState {
  final String error;
  SignOutFailure(this.error);
}
