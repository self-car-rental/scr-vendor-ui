// Flutter imports:
import 'package:flutter/foundation.dart' show immutable;

/// A representation of a user in the context of Cognito authentication.
///
/// This class holds the basic attributes necessary for identifying and managing a user in the Cognito authentication system.
@immutable
class UserCognitoEntity {
  const UserCognitoEntity({
    required this.name,
    required this.email,
    required this.mobile,
  });

  final String name;
  final String email;
  final String mobile;
}
