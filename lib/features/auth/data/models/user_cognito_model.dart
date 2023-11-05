// Package imports:
import 'package:freezed_annotation/freezed_annotation.dart';

// Project imports:
import 'package:scr_vendor/features/auth/domain/entities/user_cognito_entity.dart';

// This file is part of the UserCognitoModel class which is used for JSON serialization
// and represents a user entity for Cognito authentication.
part 'user_cognito_model.g.dart';

/// Model class that extends [UserCognitoEntity] and provides JSON serialization capabilities.
@immutable
@JsonSerializable()
class UserCognitoModel extends UserCognitoEntity {
  const UserCognitoModel({
    required super.name,
    required super.email,
    required super.mobile,
  });

  /// Factory constructor for creating a new [UserCognitoModel] instance from a JSON map.
  factory UserCognitoModel.fromJson(Map<String, dynamic> json) =>
      _$UserCognitoModelFromJson(json);

  /// Method to convert [UserCognitoModel] instance to a JSON map.
  Map<String, dynamic> toJson() => _$UserCognitoModelToJson(this);

  @override
  String toString() {
    // Return a string representation of the instance
    return 'UserCognitoModel(name: $name, email: $email, mobile: $mobile)';
  }
}
