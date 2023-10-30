// Flutter imports:
import 'package:flutter/foundation.dart' show immutable;

// Project imports:
import 'package:scr_vendor/common/network/api_result.dart';
import 'package:scr_vendor/common/usecase/usecase.dart';
import 'package:scr_vendor/features/user/data/models/user.dart';
import 'package:scr_vendor/features/user/domain/entities/user_entity.dart';
import 'package:scr_vendor/features/user/domain/repositories/user_repository.dart';

@immutable
class GetUsersUseCase implements UseCase<List<User>, GetUsersParams> {
  final UserRepository userRepository;

  const GetUsersUseCase(this.userRepository);

  @override
  Future<ApiResult<List<User>>> call(GetUsersParams params) async {
    return await userRepository.getUsers(
        status: params.status, gender: params.gender);
  }
}

@immutable
class GetUsersParams {
  final Gender? gender;
  final UserStatus? status;

  const GetUsersParams({this.gender, this.status});
}
