// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:equatable/equatable.dart';

/// Enum representing the various states of error bloc.
enum ErrorBlocStatus {
  nothing,
  unexpectedFailure,
  connectivityFailure,
  serviceFailure,
}

/// Extension on ErrorBlocStatus to easily check if the status represents an error.
extension ErrorBlocStatusExtension on ErrorBlocStatus {
  bool get isError => this != ErrorBlocStatus.nothing;
}

/// Immutable state class for error handling in the application.
@immutable
class ErrorState extends Equatable {
  final ErrorBlocStatus status;
  final String? message;

  const ErrorState({
    this.status = ErrorBlocStatus.nothing,
    this.message = '',
  });

  /// Creates a copy of this state with given fields updated.
  ErrorState copyWith({
    ErrorBlocStatus? status,
    String? message,
  }) {
    return ErrorState(
      status: status ?? this.status,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [status, message];
}
