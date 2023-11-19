/// Base class for error events.
abstract class ErrorEvent {
  const ErrorEvent();
}

/// Event to handle unexpected errors.
class UnexpectedErrorEvent extends ErrorEvent {
  final String message;
  const UnexpectedErrorEvent(this.message);
}

/// Event to handle connectivity errors.
class ConnectivityErrorEvent extends ErrorEvent {
  final String message;
  const ConnectivityErrorEvent(this.message);
}

/// Event to handle service-related errors.
class ServiceErrorEvent extends ErrorEvent {
  final String message;
  const ServiceErrorEvent(this.message);
}

class SessionExpiredErrorEvent extends ErrorEvent {
  final String message;
  const SessionExpiredErrorEvent(this.message);
}

/// Event to reset the error state.
class ErrorHandledEvent extends ErrorEvent {
  const ErrorHandledEvent();
}
