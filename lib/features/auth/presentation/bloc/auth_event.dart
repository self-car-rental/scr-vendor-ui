// Project imports:
import 'package:scr_vendor/features/auth/data/models/user_cognito_model.dart';

/// events are handled by the bloc to trigger corresponding state changes.

abstract class AuthEvent {}

/// Event representing a user sign-up request.
///
class SignUpRequested extends AuthEvent {
  final UserCognitoModel user;

  /// Constructs a [SignUpRequested] event with the provided [user] information.
  SignUpRequested(this.user);
}

class SignInRequested extends AuthEvent {
  final String mobileNumber;

  SignInRequested(this.mobileNumber);
}

class VerifyOtpRequested extends AuthEvent {
  final String otp;

  VerifyOtpRequested(this.otp);
}

class SignOutRequested extends AuthEvent {
  SignOutRequested();
}

class CheckUserLoggedInRequested extends AuthEvent {
  CheckUserLoggedInRequested();
}
