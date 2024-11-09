import 'package:base_flutter_bloc/core/domain/usecase/auth/register_use_case.dart';
import 'package:base_flutter_bloc/core/domain/usecase/auth/user_update_use_case.dart';

import '../../../utils/di/injector.dart';
import '../../usecase/auth/forgot_password_use_case.dart';
import '../../usecase/auth/get_access_token_use_case.dart';
import '../../usecase/auth/get_refresh_token_use_case.dart';
import '../../usecase/auth/get_user_use_case.dart';
import '../../usecase/auth/login_use_case.dart';
import '../../usecase/auth/get_list_user_use_case.dart';
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

  injector.registerLazySingleton<GetListUserUseCase>(
    () => GetListUserUseCase(
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

  injector.registerLazySingleton<ForgotPasswordUseCase>(
    () => ForgotPasswordUseCase(
      injector(),
    ),
  );

  injector.registerLazySingleton<RegisterUseCase>(
    () => RegisterUseCase(
      injector(),
    ),
  );

  injector.registerLazySingleton<UserUpdateUseCase>(
    () => UserUpdateUseCase(
      injector(),
    ),
  );
}
