// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:scr_vendor/core/bloc/bloc_helpers/app_bloc_state.dart';
import 'package:scr_vendor/core/network/api_result.dart';

typedef Emit<T> = Emitter<BlocState<T>>;

enum ApiOperation { select, create, update, delete }

mixin BlocHelper<T> {
  ApiOperation operation = ApiOperation.select;

  void _checkFailureOrSuccess(ApiResult failureOrSuccess, Emit<T> emit) {
    failureOrSuccess.when(
      failure: (String failure) {
        emit(BlocState.failure(failure));
      },
      success: (_) {
        emit(BlocState.success(null));
      },
    );
  }

  Future<void> _apiOperationTemplate(
      Future<ApiResult> apiCallback, Emit<T> emit) async {
    emit(BlocState.loading());
    final ApiResult failureOrSuccess = await apiCallback;
    _checkFailureOrSuccess(failureOrSuccess, emit);
  }

  Future<void> getItems(
      Future<ApiResult<List<T>>> apiCallback, Emit<T> emit) async {
    operation = ApiOperation.select;
    emit(BlocState.loading());
    final ApiResult<List<T>> failureOrSuccess = await apiCallback;

    failureOrSuccess.when(
      failure: (String failure) async {
        emit(BlocState.failure(failure));
      },
      success: (List<T> items) async {
        emit(items.isEmpty ? BlocState.empty() : BlocState.success(items));
      },
    );
  }

  Future<void> createItem(Future<ApiResult> apiCallback, Emit<T> emit) async {
    operation = ApiOperation.create;
    await _apiOperationTemplate(apiCallback, emit);
  }

  Future<void> updateItem(Future<ApiResult> apiCallback, Emit<T> emit) async {
    operation = ApiOperation.update;
    await _apiOperationTemplate(apiCallback, emit);
  }

  Future<void> deleteItem(Future<ApiResult> apiCallback, Emit<T> emit) async {
    operation = ApiOperation.delete;
    await _apiOperationTemplate(apiCallback, emit);
  }
}
