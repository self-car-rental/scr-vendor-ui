// Package imports:
import 'package:logger/logger.dart';

class Log {
  static final Log _instance = Log._internal();
  late Logger _logger;

  Log._internal()
      : _logger = Logger(
          level: Level.all,
          // Logger now directly takes an instance of LogPrinter.
          printer: PrettyPrinter(
            methodCount: 0, // number of method calls to be displayed
            errorMethodCount: 8, // number of method calls if an error is logged
            lineLength: 120, // width of the log print
            colors: true, // Colorful log messages
            printEmojis: true, // Print an emoji for each log message
            printTime: true, // Should each log print contain a timestamp
          ),
        );

  factory Log() => _instance;

  void t(dynamic message) => _logger.t(message);
  void d(dynamic message) => _logger.d(message);
  void i(dynamic message) => _logger.i(message);
  void w(dynamic message) => _logger.w(message);
  void e(dynamic message, [Object? error, StackTrace? stackTrace]) {
    _logger.e(message, error: error, stackTrace: stackTrace);
  }
}
