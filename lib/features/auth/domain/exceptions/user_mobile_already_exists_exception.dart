/// This exception is thrown during the user registration process when the provided mobile number is already associated with an existing user account.
class UserMobileAlreadyExistsException implements Exception {
  /// The message describing the exception.
  final String message;

  UserMobileAlreadyExistsException(this.message);

  @override
  String toString() => message;
}
