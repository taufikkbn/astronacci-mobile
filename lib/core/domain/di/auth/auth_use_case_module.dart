import '../../../utils/di/injector.dart';
import '../../usecase/auth/get_access_token_use_case.dart';
import '../../usecase/auth/get_refresh_token_use_case.dart';
import '../../usecase/auth/get_user_use_case.dart';
import '../../usecase/auth/login_use_case.dart';
import '../../usecase/auth/refresh_token_use_case.dart';
import '../../usecase/auth/set_access_token_use_case.dart';
import '../../usecase/auth/set_refresh_token_use_case.dart';

Future<void> initializeAuthUseCaseDependencies() async {
  injector.registerLazySingleton<GetUserUseCase>(
    () => GetUserUseCase(
      injector(),
    ),
  );

  injector.registerLazySingleton<LoginUseCase>(
    () => LoginUseCase(
      injector(),
    ),
  );

  injector.registerLazySingleton<RefreshTokenUseCase>(
    () => RefreshTokenUseCase(
      injector(),
      injector(),
    ),
  );

  injector.registerLazySingleton<GetAccessTokenUseCase>(
    () => GetAccessTokenUseCase(
      injector(),
    ),
  );

  injector.registerLazySingleton<GetRefreshTokenUseCase>(
    () => GetRefreshTokenUseCase(
      injector(),
    ),
  );

  injector.registerLazySingleton<SetAccessTokenUseCase>(
    () => SetAccessTokenUseCase(
      injector(),
    ),
  );

  injector.registerLazySingleton<SetRefreshTokenUseCase>(
    () => SetRefreshTokenUseCase(
      injector(),
    ),
  );
}
