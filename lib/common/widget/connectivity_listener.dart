// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:scr_vendor/common/bloc/connectivity/connectivity_bloc.dart';
import 'package:scr_vendor/global_keys.dart';

class ConnectivityListener extends StatelessWidget {
  final Widget child;

  const ConnectivityListener({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return BlocListener<ConnectivityBloc, ConnectivityState>(
      listener: (context, state) {
        final snackBar = SnackBar(
          content: Text(state == ConnectivityState.connected
              ? 'Connected to the Internet'
              : 'No Internet Connection'),
          duration: const Duration(seconds: 3),
        );

        // Using rootScaffoldKey defined in global_keys.dart
        ScaffoldMessenger.of(rootScaffoldKey.currentContext!)
            .showSnackBar(snackBar);
      },
      child: child,
    );
  }
}
