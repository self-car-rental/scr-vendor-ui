// Flutter imports:
import 'package:flutter/foundation.dart' show immutable;

// Project imports:
import 'package:scr_vendor_ui/core/network/api_result.dart';
import 'package:scr_vendor_ui/core/usecase/usecase_helper.dart';
import 'package:scr_vendor_ui/features/user/data/models/user.dart';
import 'package:scr_vendor_ui/features/user/domain/repositories/user_repository.dart';

@immutable
class CreateUserUseCase implements UseCase<bool, CreateUserParams> {
  final UserRepository userRepository;

  const CreateUserUseCase(this.userRepository);

  @override
  Future<ApiResult<bool>> call(CreateUserParams params) async {
    return await userRepository.createUser(params.user);
  }
}

@immutable
class CreateUserParams {
  final User user;

  const CreateUserParams(this.user);
}
