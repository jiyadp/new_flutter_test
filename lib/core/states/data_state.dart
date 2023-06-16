import 'package:equatable/equatable.dart';

class DataState<T> extends Equatable {
  final bool isInitial;
  final bool isInProgress;
  final bool isFailure;
  final bool isSuccess;
  final bool isEmpty;
  final T? data;
  final String? error;

  const DataState({
    this.isInitial = false,
    this.isInProgress = false,
    this.isFailure = false,
    this.isSuccess = false,
    this.isEmpty = false,
    this.data,
    this.error,
  });

  factory DataState.initial() => const DataState(isInitial: true);

  factory DataState.inProgress() => const DataState(isInProgress: true);

  factory DataState.failure(String? error) => DataState(isFailure: true, error: error);

  factory DataState.empty() => const DataState(isEmpty: true);

  factory DataState.success(T data) => DataState(isSuccess: true, data: data);

  @override
  List<Object?> get props => [
        isInitial,
        isInProgress,
        isFailure,
        isEmpty,
        isFailure,
        data,
        error,
      ];
}
