// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_cognito_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserCognitoModel _$UserCognitoModelFromJson(Map<String, dynamic> json) =>
    UserCognitoModel(
      name: json['name'] as String,
      email: json['email'] as String,
      mobile: json['mobile'] as String,
    );

Map<String, dynamic> _$UserCognitoModelToJson(UserCognitoModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'email': instance.email,
      'mobile': instance.mobile,
    };
