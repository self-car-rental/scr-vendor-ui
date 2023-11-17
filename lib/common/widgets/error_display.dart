// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:scr_vendor/core/bloc/error/error_bloc.dart';
import 'package:scr_vendor/core/bloc/error/error_event.dart';
import 'package:scr_vendor/core/bloc/error/error_state.dart';

class ErrorDisplay extends StatelessWidget {
  final Widget child;

  const ErrorDisplay({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return BlocListener<ErrorBloc, ErrorState>(
      listener: (context, state) {
        if (state.status != ErrorBlocStatus.nothing) {
          _showErrorSnackbar(context, state.message);
          _resetErrorState(context);
        }
      },
      child: child,
    );
  }

  void _showErrorSnackbar(BuildContext context, String? message) {
    final snackBar = SnackBar(
      content: Text(message ?? 'An unexpected error occurred'),
      duration: const Duration(seconds: 1),
    );
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  void _resetErrorState(BuildContext context) {
    context.read<ErrorBloc>().add(const ErrorHandledEvent());
  }
}
