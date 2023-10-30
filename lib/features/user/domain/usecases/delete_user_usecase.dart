// Flutter imports:
import 'package:flutter/foundation.dart' show immutable;

// Project imports:
import 'package:scr_vendor/common/network/api_result.dart';
import 'package:scr_vendor/common/usecase/usecase.dart';
import 'package:scr_vendor/features/user/data/models/user.dart';
import 'package:scr_vendor/features/user/domain/repositories/user_repository.dart';

@immutable
class DeleteUserUseCase implements UseCase<bool, DeleteUserParams> {
  final UserRepository userRepository;

  const DeleteUserUseCase(this.userRepository);

  @override
  Future<ApiResult<bool>> call(DeleteUserParams params) async {
    return await userRepository.deleteUser(params.user);
  }
}

@immutable
class DeleteUserParams {
  final User user;

  const DeleteUserParams(this.user);
}
