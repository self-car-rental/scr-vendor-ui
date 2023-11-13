// Flutter imports:
import 'package:flutter/foundation.dart' show immutable;

// Project imports:
import 'package:scr_vendor/core/network/api_result.dart';
import 'package:scr_vendor/core/usecase/usecase_helper.dart';
import 'package:scr_vendor/features/user/data/models/user.dart';
import 'package:scr_vendor/features/user/domain/repositories/user_repository.dart';

@immutable
class UpdateUserUseCase implements UseCase<bool, UpdateUserParams> {
  final UserRepository userRepository;

  const UpdateUserUseCase(this.userRepository);

  @override
  Future<ApiResult<bool>> call(UpdateUserParams params) async {
    return await userRepository.updateUser(params.user);
  }
}

@immutable
class UpdateUserParams {
  final User user;

  const UpdateUserParams(this.user);
}
