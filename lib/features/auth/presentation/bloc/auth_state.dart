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
