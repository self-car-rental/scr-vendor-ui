// Package imports:
// Project imports:
import 'package:scr_vendor/common/network/api_result.dart';

mixin RepositoryHelper<T> {
  Future<ApiResult<List<T>>> checkItemsFailOrSuccess(
      Future<List<T>> apiCallback) async {
    try {
      final List<T> items = await apiCallback;
      return ApiResult.success(items);
    } on Exception catch (e) {
      return ApiResult.failure(e.toString());
    }
  }

  Future<ApiResult<bool>> checkItemFailOrSuccess(
      Future<bool> apiCallback) async {
    try {
      await apiCallback;
      return const ApiResult.success(true);
    } on Exception catch (e) {
      return ApiResult.failure(e.toString());
    }
  }
}
