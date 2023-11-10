// Flutter imports:
import 'package:flutter/foundation.dart' show immutable;

enum Status { empty, loading, failure, success }

@immutable
class BlocState<T> {
  final List<T>? data;
  final String? error;
  final Status status;

  const BlocState({this.data, this.error, required this.status});

  factory BlocState.empty() => const BlocState(status: Status.empty);

  factory BlocState.loading() => const BlocState(status: Status.loading);

  factory BlocState.failure(String error) =>
      BlocState(error: error, status: Status.failure);

  factory BlocState.success(List<T>? data) =>
      BlocState(data: data, status: Status.success);
}
