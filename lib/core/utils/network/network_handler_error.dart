import 'dart:io';

import 'package:base_flutter_bloc/core/utils/common/helper.dart';
import 'package:base_flutter_bloc/core/utils/network/network_handler_enum.dart';
import 'package:dio/dio.dart';

class NetworkHandler {
  final DioException dioException;

  const NetworkHandler(this.dioException);

  Failure handle() {
    Object? error = dioException.error;
    Response? response = dioException.response;
    int statusCode = response?.statusCode ?? 0;
    String message = response?.statusMessage ?? dioException.message ?? error.toString();
    String path = dioException.requestOptions.path;
    NetworkStatus status = NetworkStatus.unknown;

    switch (dioException.type) {
      case DioExceptionType.badResponse:
        // TODO: adjust this to base response error model

        /* response from json */
        final dynamic data = response?.data;
        final int codeResponse = data['statusCode'] ?? statusCode;
        final String messageResponse = data['message'] ?? message;

        statusCode = codeResponse;
        message = messageResponse;
        status = NetworkStatus.setStatusFromCode(statusCode);
        break;
      case DioExceptionType.connectionTimeout:
        statusCode = NetworkStatus.connectionTimeout.value;
        status = NetworkStatus.connectionTimeout;
        break;
      case DioExceptionType.sendTimeout:
        statusCode = NetworkStatus.sendTimeout.value;
        status = NetworkStatus.sendTimeout;
        break;
      case DioExceptionType.receiveTimeout:
        statusCode = NetworkStatus.receiveTimeout.value;
        status = NetworkStatus.receiveTimeout;
        break;
      case DioExceptionType.badCertificate:
        statusCode = NetworkStatus.badCertificate.value;
        status = NetworkStatus.badCertificate;
        break;
      case DioExceptionType.cancel:
        statusCode = NetworkStatus.cancel.value;
        status = NetworkStatus.cancel;
        break;
      case DioExceptionType.connectionError:
        statusCode = NetworkStatus.connectionError.value;
        status = NetworkStatus.connectionError;
        break;
      case DioExceptionType.unknown:
        statusCode = NetworkStatus.unknown.value;
        status = NetworkStatus.unknown;
        break;
      default:
        statusCode = NetworkStatus.others.value;
        status = NetworkStatus.others;
        break;
    }

    if (error is SocketException) {
      statusCode = NetworkStatus.socketException.value;
      status = NetworkStatus.socketException;
      message = error.message;
    }

    return Failure(
      statusCode: statusCode,
      status: status,
      message: message,
      path: path,
    );
  }
}
