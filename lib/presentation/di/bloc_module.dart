import 'package:base_flutter_bloc/presentation/screens/detail_user/bloc/detail_bloc.dart';
import 'package:base_flutter_bloc/presentation/screens/forgot_password/bloc/forgot_bloc.dart';
import 'package:base_flutter_bloc/presentation/screens/home/bloc/home_bloc.dart';
import 'package:base_flutter_bloc/presentation/screens/login/bloc/login_bloc.dart';
import 'package:base_flutter_bloc/presentation/screens/register/bloc/register_bloc.dart';

import '../../core/utils/di/injector.dart';

Future<void> initializeBlocDependencies() async {
  injector.registerFactory<LoginBloc>(
    () => LoginBloc(
      loginUseCase: injector(),
      getAccessTokenUseCase: injector(),
    ),
  );

  injector.registerFactory(
    () => HomeBloc(
      getListUserUseCase: injector(),
      setAccessTokenUseCase: injector(),
    ),
  );

  injector.registerFactory<RegisterBloc>(
    () => RegisterBloc(
      registerUseCase: injector(),
    ),
  );

  injector.registerFactory<ForgotBloc>(
    () => ForgotBloc(
      forgotPasswordUseCase: injector(),
    ),
  );

  injector.registerFactory<DetailBloc>(
    () => DetailBloc(
      getUserUseCase: injector(),
      userUpdateUseCase: injector(),
    ),
  );

}
