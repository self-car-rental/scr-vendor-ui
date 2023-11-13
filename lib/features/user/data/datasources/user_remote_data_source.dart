// Project imports:
import 'package:scr_vendor/core/network/api_endpoints.dart';
import 'package:scr_vendor/core/network/api_helper.dart';
import 'package:scr_vendor/features/user/data/models/user.dart';
import 'package:scr_vendor/features/user/domain/entities/user_entity.dart';

abstract class UserRemoteDataSource {
  Future<List<User>> getUsers({Gender? gender, UserStatus? status});
  Future<bool> createUser(User user);
  Future<bool> updateUser(User user);
  Future<bool> deleteUser(User user);
}

class UserRemoteDataSourceImpl extends ApiHelper<User>
    implements UserRemoteDataSource {
  @override
  Future<List<User>> getUsers({Gender? gender, UserStatus? status}) async {
    var queryParameters = <String, String>{};
    if (gender != null && gender != Gender.all) {
      queryParameters['gender'] = gender.name;
    }
    if (status != null && status != UserStatus.all) {
      queryParameters['status'] = status.name;
    }
    return fetchItems(
        path: ApiEndpoints.users,
        fromJson: User.fromJson,
        queryParameters: queryParameters);
  }

  @override
  Future<bool> createUser(User user) async {
    return createItem(path: ApiEndpoints.users, body: user.toJson());
  }

  @override
  Future<bool> updateUser(User user) async {
    return updateItem(
        path: ApiEndpoints.userById(user.id), body: user.toJson());
  }

  @override
  Future<bool> deleteUser(User user) async {
    return deleteItem(path: ApiEndpoints.userById(user.id));
  }
}
