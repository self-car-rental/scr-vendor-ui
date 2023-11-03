// Package imports:
import 'package:dio/dio.dart';

// Project imports:
import 'package:scr_vendor/common/log/log.dart';

class DioInterceptor extends Interceptor {
  final log = Log();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    log.i('===== HTTP Request Start =====');
    log.d('Method: ${options.method}');
    log.d('URL: ${options.uri}');
    log.d('Headers: ${options.headers}');
    if (options.data != null) {
      log.d('Body: ${options.data}');
    }
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final options = err.requestOptions;
    log.e('HTTP Error - Method: ${options.method}, URL: ${options.uri}');
    log.e(
        'Error Type: ${err.type}, Error: ${err.error}, Message: ${err.message}');
    handler.next(err);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    log.i('===== HTTP Response =====');
    log.d('Status Code: ${response.statusCode}');
    log.d('Data: ${response.data}');
    handler.next(response);
  }
}
