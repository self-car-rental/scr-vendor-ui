// Project imports:
import 'package:scr_vendor_ui/core/network/api_result.dart';
import 'package:scr_vendor_ui/features/user/data/models/user.dart';
import 'package:scr_vendor_ui/features/user/domain/entities/user_entity.dart';

abstract class UserRepository {
  Future<ApiResult<List<User>>> getUsers({Gender? gender, UserStatus? status});

  Future<ApiResult<bool>> createUser(User user);

  Future<ApiResult<bool>> updateUser(User user);

  Future<ApiResult<bool>> deleteUser(User user);
}
