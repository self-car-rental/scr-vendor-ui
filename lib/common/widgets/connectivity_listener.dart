// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

// Project imports:
import 'package:scr_vendor_ui/core/bloc/connectivity/connectivity_bloc.dart';

class ConnectivityStatusListener extends StatelessWidget {
  final Widget child;

  const ConnectivityStatusListener({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return BlocListener<ConnectivityBloc, ConnectivityState>(
      listener: (context, state) {
        _showConnectivityStatusToast(context, state);
      },
      child: child,
    );
  }

  void _showConnectivityStatusToast(
      BuildContext context, ConnectivityState state) {
    Fluttertoast.showToast(
      msg: state == ConnectivityState.connected
          ? 'Connected to the Internet'
          : 'No Internet Connection',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 2,
      backgroundColor:
          state == ConnectivityState.connected ? Colors.green : Colors.red,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
}
