import 'dart:convert';

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:scr_vendor/common/log/log.dart';
import 'package:scr_vendor/core/app_extension.dart';

abstract class ApiHelper<T> {
  final logger = Log();

  Future<bool> _executeRestOperation(RestOperation restOperation) async {
    try {
      final response = await restOperation.response;
      if (response.statusCode.success) {
        return true;
      } else {
        String errorMessage =
            'API request failed with status code: ${response.statusCode}';
        logger.e(errorMessage);
        return false;
      }
    } on ApiException catch (e) {
      logger.e('API request error: ${e.message}');
      rethrow;
    } catch (e) {
      logger.e('Unexpected error: $e');
      rethrow;
    }
  }

  Future<bool> createItem(
      {required String path,
      required Map<String, dynamic> body,
      Map<String, String>? queryParameters}) async {
    return _executeRestOperation(Amplify.API.post(path,
        body: HttpPayload.json(body), queryParameters: queryParameters));
  }

  Future<bool> updateItem(
      {required String path,
      required Map<String, dynamic> body,
      Map<String, String>? queryParameters}) async {
    return _executeRestOperation(Amplify.API.put(path,
        body: HttpPayload.json(body), queryParameters: queryParameters));
  }

  Future<bool> deleteItem(
      {required String path,
      Map<String, dynamic>? body,
      Map<String, String>? queryParameters}) async {
    return _executeRestOperation(Amplify.API.delete(path,
        body: HttpPayload.json(body), queryParameters: queryParameters));
  }

  Future<List<T>> fetchItems(
      {required String path,
      required T Function(Map<String, dynamic>) fromJson,
      Map<String, String>? queryParameters}) async {
    return _processGetOperation(
        Amplify.API.get(path, queryParameters: queryParameters), fromJson);
  }

  Future<T> fetchItem(
      {required String path,
      required T Function(Map<String, dynamic>) fromJson,
      Map<String, String>? queryParameters}) async {
    return _processGetOperationForSingleItem(
        Amplify.API.get(path, queryParameters: queryParameters), fromJson);
  }

  Future<List<T>> _processGetOperation(RestOperation restOperation,
      T Function(Map<String, dynamic>) fromJson) async {
    try {
      final response = await restOperation.response;
      final responseData = response.decodeBody();
      logger.i('Received response: $responseData');
      return (json.decode(responseData) as List)
          .map((jsonItem) => fromJson(jsonItem as Map<String, dynamic>))
          .toList();
    } on ApiException catch (e) {
      logger.e('Error processing get operation: $e');
      rethrow;
    } catch (e) {
      logger.e('Error processing get operation: $e');
      rethrow;
    }
  }

  Future<T> _processGetOperationForSingleItem(RestOperation restOperation,
      T Function(Map<String, dynamic>) fromJson) async {
    try {
      final response = await restOperation.response;
      final responseData = response.decodeBody();
      logger.i('Received response: $responseData');
      return fromJson(json.decode(responseData));
    } on ApiException catch (e) {
      logger.e('Error processing get operation for single item: $e');
      rethrow;
    } catch (e) {
      logger.e('Error processing get operation for single item: $e');
      rethrow;
    }
  }
}
