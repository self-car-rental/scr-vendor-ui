// Project imports:
import 'package:scr_vendor/common/network/api_result.dart';
import 'package:scr_vendor/features/user/data/models/user.dart';
import 'package:scr_vendor/features/user/domain/entities/user_entity.dart';

abstract class UserRepository {
  Future<ApiResult<List<User>>> getUsers({Gender? gender, UserStatus? status});

  Future<ApiResult<bool>> createUser(User user);

  Future<ApiResult<bool>> updateUser(User user);

  Future<ApiResult<bool>> deleteUser(User user);
}
