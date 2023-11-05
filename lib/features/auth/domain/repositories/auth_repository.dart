// Project imports:

/// This interface defines methods for managing authentication-related actions
abstract class AuthRepository {
  Future<void> signUp(String mobileNumber);
  Future<void> signIn(String mobileNumber);
  Future<void> verifyOtp(String otp);
  Future<void> signOut();
}
