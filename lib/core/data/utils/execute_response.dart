import 'package:dio/dio.dart';

import '../../utils/network/data_state.dart';
import '../../utils/network/network_handler_error.dart';

Future<DataState<T>> executeResponse<T, R>({
  required Future<R> Function() networkCall,
  required T Function(R response) action,
}) async {
  try {
    final response = await networkCall();
    return DataState.success(action(response));
  } on DioException catch (exception) {
    return DataState.failed(NetworkHandler(exception).handle());
  }
}
