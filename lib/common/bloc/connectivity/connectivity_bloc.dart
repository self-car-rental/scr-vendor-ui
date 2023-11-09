// Dart imports:
import 'dart:async';

// Package imports:
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum ConnectivityState { connected, disconnected }

class ConnectivityBloc extends Bloc<ConnectivityState, ConnectivityState> {
  final Connectivity _connectivity;
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  ConnectivityBloc(this._connectivity) : super(ConnectivityState.disconnected) {
    on<ConnectivityState>((event, emit) => emit(event));

    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen((result) {
      if (result == ConnectivityResult.wifi ||
          result == ConnectivityResult.mobile ||
          result == ConnectivityResult.ethernet ||
          result == ConnectivityResult.vpn) {
        add(ConnectivityState.connected);
      } else {
        add(ConnectivityState.disconnected);
      }
    });
  }

  @override
  Future<void> close() {
    _connectivitySubscription.cancel();
    return super.close();
  }
}
