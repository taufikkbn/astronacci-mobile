import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:synchronized/synchronized.dart';

import '../domain/usecase/auth/get_access_token_use_case.dart';
import '../domain/usecase/auth/refresh_token_use_case.dart';
import '../domain/usecase/auth/set_access_token_use_case.dart';
import '../domain/usecase/auth/set_refresh_token_use_case.dart';
import '../utils/di/injector.dart';

class DioInterceptorsWrapper extends InterceptorsWrapper {
  final Dio dio;
  final _lock = Lock();

  DioInterceptorsWrapper({required this.dio});

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final accessToken = await injector<GetAccessTokenUseCase>().call();

    options.baseUrl = "https://dummyjson.com/";
    options.headers = {
      'Accept': 'application/json',
      'Device-Type': '1',
      'Content-Type': options.data is FormData ? 'multipart/form-data' : 'application/json',
      'Accept-Language': 'en',
      'Version-Name': '1.0.0',
      'Authorization': 'Bearer $accessToken',
    };

    return handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // handling response here
    return handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    final statusCode = err.response?.statusCode ?? 0;
    final path = err.requestOptions.path;

    switch (statusCode) {
      case 401:
        // if (path == '/auth/login') return handler.next(err);

        final refreshTokenUseCase = injector<RefreshTokenUseCase>();
        final setAccessTokenUseCase = injector<SetAccessTokenUseCase>();
        final setRefreshTokenUseCase = injector<SetRefreshTokenUseCase>();
        String accessToken = await injector<GetAccessTokenUseCase>().call();

        try {
          await _lock.synchronized(() async {
            if (err.requestOptions.headers['Authorization'] != 'Bearer $accessToken') {
              // Token has already been refreshed by another request
              log("ALREADY REFRESHED TOKEN: $accessToken");
              err.requestOptions.headers['Authorization'] = 'Bearer $accessToken';
              return handler.resolve(await dio.fetch(err.requestOptions));
            }

            final x = await refreshTokenUseCase(1);

            // Perform token refresh
            x.when(
              success: (data) {
                setAccessTokenUseCase(data.accessToken!);
                setRefreshTokenUseCase(data.refreshToken!);
                log("REFRESHED TOKEN: $accessToken");
              },
              failed: (error) {
                log("FAILED TO GET REFRESH TOKEN: ${error.message}");
                // If refresh fails, propagate the error
                return handler.next(err);
              },
            );

            // Retry the original request with the new token
            log("RETRY REFRESH TOKEN: $accessToken");
            err.requestOptions.headers['Authorization'] = 'Bearer $accessToken';
            return handler.resolve(await dio.fetch(err.requestOptions));
          });
        } catch (e) {
          log("FAILED RETRY REFRESH TOKEN: $e");
          // If refresh fails, propagate the error
          return handler.next(err);
        }
        break;
      default:
        return handler.next(err);
    }
  }
}
