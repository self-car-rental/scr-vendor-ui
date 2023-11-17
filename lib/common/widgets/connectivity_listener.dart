// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:scr_vendor/core/bloc/connectivity/connectivity_bloc.dart';

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
          duration: const Duration(seconds: 1),
        );

        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);
      },
      child: child,
    );
  }
}
