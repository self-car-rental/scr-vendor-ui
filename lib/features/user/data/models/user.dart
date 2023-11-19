// Flutter imports:
import 'package:flutter/foundation.dart' show immutable;

// Package imports:
import 'package:json_annotation/json_annotation.dart';

// Project imports:
import 'package:scr_vendor_ui/features/user/domain/entities/user_entity.dart';

part 'user.g.dart';

@immutable
@JsonSerializable()
class User extends UserEntity {
  const User({
    super.id,
    required super.name,
    required super.email,
    required super.gender,
    @JsonKey(name: 'status') required super.status,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
