import '../common/helper.dart';

abstract class DataState<T> {
  const DataState();

  bool get isSuccess => this is Success<T>;

  bool get isFailed => this is Error<T>;

  const factory DataState.success(T data) = Success<T>;

  const factory DataState.failed(Failure error) = Error<T>;

  R when<R>({
    required R Function(T data) success,
    required R Function(Failure message) failed,
  }) {
    if (this is Success<T>) return success((this as Success<T>).data);
    if (this is Error<T>) return failed((this as Error<T>).failure);
    throw Exception('Unhandled state: $this');
  }
}

class Success<T> extends DataState<T> {
  final T data;

  const Success(this.data);
}

class Error<T> extends DataState<T> {
  final Failure failure;

  const Error(this.failure);
}

extension DataStateExtension<T> on DataState<T> {
  DataState<T> success(void Function(T data) block) {
    if (this is Success<T>) {
      block((this as Success<T>).data);
    }
    return this;
  }

  DataState<T> failed(void Function(Failure failure) block) {
    if (this is Error<T>) {
      block((this as Error<T>).failure);
    }
    return this;
  }
}
