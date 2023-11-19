// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:scr_vendor/common/dialogs/create_dialog.dart';
import 'package:scr_vendor/common/dialogs/delete_dialog.dart';
import 'package:scr_vendor/common/dialogs/progress_dialog.dart';
import 'package:scr_vendor/common/dialogs/retry_dialog.dart';
import 'package:scr_vendor/common/widgets/empty_widget.dart';
import 'package:scr_vendor/common/widgets/popup_menu.dart';
import 'package:scr_vendor/common/widgets/spinkit_indicator.dart';
import 'package:scr_vendor/core/bloc/bloc_helpers/app_bloc_state.dart';
import 'package:scr_vendor/core/bloc/bloc_helpers/bloc_api_helper.dart';
import 'package:scr_vendor/core/utils/extension.dart';
import 'package:scr_vendor/features/user/data/models/user.dart';
import 'package:scr_vendor/features/user/domain/entities/user_entity.dart';
import 'package:scr_vendor/features/user/presentation/bloc/user_bloc.dart';
import 'package:scr_vendor/features/user/presentation/bloc/user_event.dart';
import 'package:scr_vendor/features/user/presentation/widgets/status_container.dart';

enum Operation { edit, delete }

class UserListScreen extends StatefulWidget {
  const UserListScreen({super.key});

  @override
  State<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  PreferredSizeWidget get _appBar {
    return AppBar(
      leading: IconButton(
        onPressed: () => context.read<UserBloc>().add(UsersFetched()),
        icon: const Icon(Icons.refresh),
      ),
      actions: [
        PopupMenu<UserStatus>(
          icon: Icons.filter_list_outlined,
          items: UserStatus.values,
          onChanged: (UserStatus value) {
            context.read<UserBloc>().add(UsersFetched(status: value));
          },
        ),
        PopupMenu<Gender>(
          icon: Icons.filter_alt_outlined,
          items: Gender.values,
          onChanged: (Gender value) {
            context.read<UserBloc>().add(UsersFetched(gender: value));
          },
        )
      ],
      title: Text(
        context.tr.usersPageTitle,
        style: Theme.of(context).textTheme.displayMedium,
      ),
    );
  }

  Widget get floatingActionButton {
    return FloatingActionButton(
      onPressed: () async {
        late User user;
        bool isCreate = await createDialog(
          context: context,
          userData: (User userValue) => user = userValue,
        );

        if (isCreate) {
          if (!mounted) return;
          context.read<UserBloc>().add(UserCreated(user));
          showDialog(
            context: context,
            builder: (_) {
              return BlocBuilder<UserBloc, BlocState<User>>(
                builder: (BuildContext context, BlocState<User> state) {
                  switch (state.status) {
                    case Status.empty:
                      return const SizedBox();
                    case Status.loading:
                      return ProgressDialog(
                        title: context.tr.usersProgressCreating,
                        isProgressed: true,
                      );
                    case Status.failure:
                      return RetryDialog(
                        title: state.error ?? 'Error',
                        onRetryPressed: () =>
                            context.read<UserBloc>().add(UserCreated(user)),
                      );
                    case Status.success:
                      return ProgressDialog(
                        title: context.tr.usersSuccessfullyCreated,
                        onPressed: () {
                          context.read<UserBloc>().add(UsersFetched());
                          Navigator.of(context, rootNavigator: true).pop();
                        },
                        isProgressed: false,
                      );
                  }
                },
              );
            },
          );
        }
      },
      child: const Icon(Icons.add),
    );
  }

  Widget userListItem(User user) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Card(
        color: Theme.of(context).canvasColor,
        child: Row(
          children: [
            Image.asset(user.gender.name.getGenderWidget, scale: 3),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user.name,
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    user.email,
                    style: Theme.of(context).textTheme.headlineSmall,
                  )
                ],
              ),
            ),
            const SizedBox(width: 15),
            StatusContainer(status: user.status),
            PopupMenu<Operation>(
              items: Operation.values,
              onChanged: (Operation value) async {
                switch (value) {
                  case Operation.delete:
                    deleteUser(user);
                    break;
                  case Operation.edit:
                    editUser(user);
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  void deleteUser(User user) async {
    bool isAccepted = await deleteDialog(context);
    if (isAccepted) {
      if (!mounted) return;
      context.read<UserBloc>().add(UserDeleted(user));
      showDialog(
        context: context,
        builder: (_) {
          return BlocBuilder<UserBloc, BlocState<User>>(
            builder: (BuildContext context, BlocState<User> state) {
              switch (state.status) {
                case Status.empty:
                  return const SizedBox();
                case Status.loading:
                  return ProgressDialog(
                    title: context.tr.usersProgressDeleting,
                    isProgressed: true,
                  );
                case Status.failure:
                  return RetryDialog(
                    title: state.error ?? 'Error',
                    onRetryPressed: () =>
                        context.read<UserBloc>().add(UserDeleted(user)),
                  );
                case Status.success:
                  return ProgressDialog(
                    title: context.tr.usersSuccessfullyDeleted,
                    onPressed: () {
                      context.read<UserBloc>().add(UsersFetched());
                      Navigator.of(context, rootNavigator: true).pop();
                    },
                    isProgressed: false,
                  );
              }
            },
          );
        },
      );
    }
  }

  void editUser(User user) async {
    late User userObj;
    bool isUpdate = await createDialog(
      user: user,
      type: Type.update,
      context: context,
      userData: (User userValue) {
        userObj = userValue;
      },
    );

    if (isUpdate) {
      if (!mounted) return;
      context.read<UserBloc>().add(UserUpdated(userObj));
      showDialog(
        context: context,
        builder: (_) {
          return BlocBuilder<UserBloc, BlocState<User>>(
            builder: (BuildContext context, BlocState<User> state) {
              switch (state.status) {
                case Status.empty:
                  return const SizedBox();
                case Status.loading:
                  return ProgressDialog(
                    title: context.tr.usersProgressUpdating,
                    isProgressed: true,
                  );
                case Status.failure:
                  return RetryDialog(
                    title: state.error ?? 'Error',
                    onRetryPressed: () =>
                        context.read<UserBloc>().add(UserUpdated(userObj)),
                  );
                case Status.success:
                  return ProgressDialog(
                    title: context.tr.usersSuccessfullyUpdated,
                    onPressed: () {
                      context.read<UserBloc>().add(UsersFetched());
                      Navigator.pop(context);
                    },
                    isProgressed: false,
                  );
              }
            },
          );
        },
      );
    }
  }

  void navigateTo(Widget screen) {
    if (!mounted) return;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => screen,
      ),
    );
  }

  @override
  void initState() {
    BlocProvider.of<UserBloc>(context).add(UsersFetched());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: floatingActionButton,
      appBar: _appBar,
      body: BlocBuilder<UserBloc, BlocState<User>>(
        buildWhen: (prevState, curState) {
          return context.read<UserBloc>().operation == ApiOperation.select
              ? true
              : false;
        },
        builder: (BuildContext context, BlocState<User> state) {
          switch (state.status) {
            case Status.empty:
              return EmptyWidget(message: context.tr.usersNoUserMessage);
            case Status.loading:
              return const SpinKitIndicator(type: SpinKitType.circle);
            case Status.failure:
              return RetryDialog(
                  title: state.error ?? 'Error',
                  onRetryPressed: () =>
                      context.read<UserBloc>().add(UsersFetched()));
            case Status.success:
              return ListView.builder(
                shrinkWrap: true,
                itemCount: state.data?.length ?? 0,
                itemBuilder: (_, index) {
                  User user = state.data![index];
                  return userListItem(user);
                },
              );
          }
        },
      ),
    );
  }
}
