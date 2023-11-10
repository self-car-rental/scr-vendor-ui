// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:scr_vendor/common/bloc/bloc_helper.dart';
import 'package:scr_vendor/common/bloc/bloc_state.dart';
import 'package:scr_vendor/features/user/data/models/user.dart';
import 'package:scr_vendor/features/user/domain/usecases/create_user_usecase.dart';
import 'package:scr_vendor/features/user/domain/usecases/delete_user_usecase.dart';
import 'package:scr_vendor/features/user/domain/usecases/get_users_usecase.dart';
import 'package:scr_vendor/features/user/domain/usecases/update_user_usecase.dart';
import 'package:scr_vendor/features/user/presentation/bloc/user_event.dart';

typedef Emit = Emitter<BlocState<User>>;

class UserBloc extends Bloc<UserEvent, BlocState<User>> with BlocHelper<User> {
  UserBloc({
    required this.getUsersUseCase,
    required this.createUserUseCase,
    required this.updateUserUseCase,
    required this.deleteUserUseCase,
  }) : super(BlocState.loading()) {
    on<UsersFetched>(getUserList);
    on<UserCreated>(createUser);
    on<UserUpdated>(updateUser);
    on<UserDeleted>(deleteUser);
  }

  final GetUsersUseCase getUsersUseCase;
  final CreateUserUseCase createUserUseCase;
  final UpdateUserUseCase updateUserUseCase;
  final DeleteUserUseCase deleteUserUseCase;

  Future<void> getUserList(UsersFetched event, Emit emit) async {
    await getItems(
        getUsersUseCase
            .call(GetUsersParams(status: event.status, gender: event.gender)),
        emit);
  }

  Future<void> createUser(UserCreated event, Emit emit) async {
    await createItem(
        createUserUseCase.call(CreateUserParams(event.user)), emit);
  }

  Future<void> updateUser(UserUpdated event, Emit emit) async {
    await updateItem(
        updateUserUseCase.call(UpdateUserParams(event.user)), emit);
  }

  Future<void> deleteUser(UserDeleted event, Emit emit) async {
    await deleteItem(
        deleteUserUseCase.call(DeleteUserParams(event.user)), emit);
  }
}
