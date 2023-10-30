// Package imports:
import 'package:dio/dio.dart' show Dio, ResponseType;

// Project imports:
import 'package:scr_vendor/common/network/api_config.dart';
import 'package:scr_vendor/common/network/dio_interceptor.dart';

class DioClient {
  final Dio dio;

  DioClient(this.dio) {
    dio
      ..options.baseUrl = ApiConfig.baseUrl
      ..options.headers = ApiConfig.header
      ..options.connectTimeout = ApiConfig.connectionTimeout
      ..options.receiveTimeout = ApiConfig.receiveTimeout
      ..options.responseType = ResponseType.json
      ..interceptors.add(DioInterceptor());
  }
}
