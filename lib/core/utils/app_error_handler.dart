// Dart imports:
import 'dart:io';

// Package imports:
import 'package:amplify_flutter/amplify_flutter.dart';

// Project imports:
import 'package:scr_vendor/core/bloc/error/error_bloc.dart';
import 'package:scr_vendor/core/bloc/error/error_event.dart';
import 'package:scr_vendor/service_locator.dart';

class ErrorHandler {
  static void handleException(Object exception) {
    final errorBloc = serviceLocator<ErrorBloc>();

    String errorMessage = _getErrorMessage(exception);
    ErrorEvent errorEvent = _getErrorEvent(exception, errorMessage);

    errorBloc.add(errorEvent);
  }

  static String _getErrorMessage(Object exception) {
    if (exception is SocketException ||
        exception is AWSHttpException ||
        exception is NetworkException) {
      return 'No Internet connection';
    } else if (exception is ApiException) {
      return 'API Service Error';
    } else {
      return 'An unexpected error occurred';
    }
  }

  static ErrorEvent _getErrorEvent(Object exception, String message) {
    if (exception is SocketException ||
        exception is AWSHttpException ||
        exception is NetworkException) {
      return ConnectivityErrorEvent(message);
    } else if (exception is ApiException) {
      return ServiceErrorEvent(message);
    } else {
      return UnexpectedErrorEvent(message);
    }
  }
}
