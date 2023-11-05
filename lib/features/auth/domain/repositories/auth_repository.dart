// Project imports:
import 'package:scr_vendor/features/auth/data/models/user_cognito_model.dart';

/// This interface defines methods for managing authentication-related actions
abstract class AuthRepository {
  Future<void> signUp(UserCognitoModel user);
}
