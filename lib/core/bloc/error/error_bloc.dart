// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:scr_vendor/core/bloc/error/error_event.dart';
import 'package:scr_vendor/core/bloc/error/error_state.dart';
import 'package:scr_vendor/core/services/auth_preference_service.dart';
import 'package:scr_vendor/service_locator.dart';

class ErrorBloc extends Bloc<ErrorEvent, ErrorState> {
  ErrorBloc() : super(const ErrorState()) {
    on<UnexpectedErrorEvent>(_handleUnexpectedError);
    on<ServiceErrorEvent>(_handleServiceError);
    on<ConnectivityErrorEvent>(_handleConnectivityError);
    on<SessionExpiredErrorEvent>(_handleSessionExpiredError);
    on<ErrorHandledEvent>(_resetErrorState);
  }

  Future<void> _handleUnexpectedError(
    UnexpectedErrorEvent event,
    Emitter<ErrorState> emit,
  ) async {
    emit(_updatedState(ErrorBlocStatus.unexpectedFailure, event.message));
  }

  Future<void> _handleServiceError(
    ServiceErrorEvent event,
    Emitter<ErrorState> emit,
  ) async {
    emit(_updatedState(ErrorBlocStatus.serviceFailure, event.message));
  }

  Future<void> _handleConnectivityError(
    ConnectivityErrorEvent event,
    Emitter<ErrorState> emit,
  ) async {
    emit(_updatedState(ErrorBlocStatus.connectivityFailure, event.message));
  }

  Future<void> _handleSessionExpiredError(
    SessionExpiredErrorEvent event,
    Emitter<ErrorState> emit,
  ) async {
    final AuthPreferenceService authPreferenceService =
        _getAuthPreferenceService();
    await authPreferenceService.setLoggedIn(false);
    emit(_updatedState(ErrorBlocStatus.sessionFailure, event.message));
  }

  Future<void> _resetErrorState(
    ErrorHandledEvent event,
    Emitter<ErrorState> emit,
  ) async {
    emit(const ErrorState(status: ErrorBlocStatus.nothing));
  }

  ErrorState _updatedState(ErrorBlocStatus status, String message) {
    return state.copyWith(
      status: status,
      message: message,
    );
  }

  AuthPreferenceService _getAuthPreferenceService() {
    return serviceLocator<AuthPreferenceService>();
  }
}
