import 'dart:developer';

import 'package:base_flutter_bloc/core/network/dio_interceptor.dart';
import 'package:chucker_flutter/chucker_flutter.dart';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioClient with DioMixin implements Dio {
  late DioInterceptorsWrapper dioInterceptorsWrapper;
  late PrettyDioLogger prettyDioLogger;
  late ChuckerDioInterceptor chuckerDioInterceptor;

  DioClient() {
    dioInterceptorsWrapper = DioInterceptorsWrapper(dio: this);

    chuckerDioInterceptor = ChuckerDioInterceptor();

    prettyDioLogger = PrettyDioLogger(
      request: true,
      requestHeader: true,
      requestBody: true,
      responseHeader: true,
      responseBody: true,
      error: true,
      compact: true,
      maxWidth: 120,
      logPrint: (e) => log(e.toString()),
    );

    options = BaseOptions(
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      sendTimeout: const Duration(seconds: 30),
      followRedirects: false,
    );

    interceptors.addAll([
      dioInterceptorsWrapper,
      chuckerDioInterceptor,
      prettyDioLogger,
    ]);

    httpClientAdapter = HttpClientAdapter();
  }
}
