// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

// Project imports:
import 'package:scr_vendor_ui/core/bloc/error/error_bloc.dart';
import 'package:scr_vendor_ui/core/bloc/error/error_event.dart';
import 'package:scr_vendor_ui/core/bloc/error/error_state.dart';

class ErrorDisplay extends StatelessWidget {
  final Widget child;

  const ErrorDisplay({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return BlocListener<ErrorBloc, ErrorState>(
      listener: (context, state) {
        // Check for any state other than 'nothing'
        if (state.status != ErrorBlocStatus.nothing) {
          _showErrorToast(context, state.message);
          _resetErrorState(context);

          // Additional action specifically for session failure
          if (state.status == ErrorBlocStatus.sessionFailure) {
            // Navigate or perform other actions specific to session failure
            // Example: Navigation.navigateToSignIn(context);
          }
        }
      },
      child: child,
    );
  }

  void _showErrorToast(BuildContext context, String? message) {
    Fluttertoast.showToast(
      msg: message ?? 'An unexpected error occurred',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 10,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  void _resetErrorState(BuildContext context) {
    context.read<ErrorBloc>().add(const ErrorHandledEvent());
  }
}
