import '../../../core/utils/common/helper.dart';

//
// class StateResource<T> {
//   T? _data;
//   Failure? _error;
//   bool _isLoading = false;
//
//   T? get data => _data;
//
//   Failure? get error => _error;
//
//   bool get isLoading => _isLoading;
//
//   void setData(T? value) {
//     _data = value;
//   }
//
//   void setError(Failure value) {
//     _error = value;
//   }
//
//   void setLoading(bool value) {
//     _isLoading = value;
//   }
// }

class StateResource<T> {
  final T? data;
  final Failure? error;

  const StateResource._({
    this.data,
    this.error,
  });

  // Factory constructors for convenience
  factory StateResource.initial() => const StateResource._();

  factory StateResource.loading() => const StateResource._();

  factory StateResource.success(T data) => StateResource._(data: data);

  factory StateResource.failure(Failure error) => StateResource._(error: error);

  // Copy with method for immutability and updates
  StateResource<T> copyWith({
    T? data,
    Failure? error,
    bool? isLoading,
  }) {
    return StateResource._(
      data: data ?? this.data,
      error: error ?? this.error,
    );
  }

  @override
  String toString() => 'StateResource(data: $data, error: $error)';
}
