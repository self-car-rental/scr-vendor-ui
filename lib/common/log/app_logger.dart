// Package imports:
import 'package:logger/logger.dart';

class AppLogger {
  static final AppLogger _instance = AppLogger._internal();
  final Logger _logger;

  AppLogger._internal()
      : _logger = Logger(
          level: Level.all,
          printer: PrettyPrinter(
            methodCount: 0, // Number of method calls to be displayed
            errorMethodCount: 8, // Number of method calls if an error is logged
            lineLength: 120, // Width of the log print
            colors: true, // Colorful log messages
            printEmojis: true, // Print an emoji for each log message
            printTime: true, // Include a timestamp in each log message
          ),
        );

  factory AppLogger() => _instance;

  void trace(dynamic message) => _logger.v(message);
  void debug(dynamic message) => _logger.d(message);
  void info(dynamic message) => _logger.i(message);
  void warning(dynamic message) => _logger.w(message);
  void error(dynamic message, [Object? error, StackTrace? stackTrace]) {
    _logger.e(message, error: error, stackTrace: stackTrace);
  }
}
