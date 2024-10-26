import 'package:base_flutter_bloc/core/utils/network/network_handler_enum.dart';

import '../network/data_state.dart';

typedef DataResult<T> = Future<DataState<T>>;

abstract class UseCase<T> {
  DataResult<T> call();
}

class Failure {
  final int statusCode;
  final NetworkStatus status;
  final String message;
  final String path;

  Failure({
    required this.statusCode,
    required this.status,
    required this.message,
    required this.path,
  });

  Map<String, dynamic> toJson() {
    return {
      'statusCode': statusCode,
      'status': status,
      'message': message,
      'path': path,
    };
  }
}
