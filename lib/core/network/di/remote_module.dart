import 'package:dio/dio.dart';

import '../../utils/di/injector.dart';
import '../dio_client.dart';
import '../remote/auth/auth_remote_source.dart';

Future<void> initializeRemoteDependencies() async {
  /// Dio Client
  injector.registerLazySingleton<Dio>(
    () => DioClient(),
  );

  /// AuthRemoteSource
  injector.registerLazySingleton<AuthRemoteSource>(
    () => AuthRemoteSource(
      injector(),
    ),
  );
}
