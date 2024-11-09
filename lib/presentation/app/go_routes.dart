import 'package:base_flutter_bloc/presentation/screens/forgot_password/view/forgot_password_screen.dart';
import 'package:base_flutter_bloc/presentation/screens/sample/view/sample_screen.dart';
import 'package:chucker_flutter/chucker_flutter.dart';
import 'package:go_router/go_router.dart';

import '../../core/domain/usecase/auth/get_access_token_use_case.dart';
import '../../core/utils/di/injector.dart';
import '../screens/detail_user/view/detail_screen.dart';
import '../screens/home/view/home_screen.dart';
import '../screens/login/view/login_screen.dart';
import '../screens/register/view/register_screen.dart';

part 'go_routes_path.dart';

final router = GoRouter(
  initialLocation: Routes.splashRoute,
  observers: [ChuckerFlutter.navigatorObserver],
  redirect: (context, state) async {

    if (state.uri.path == Routes.loginRoute) {
      final token = await injector<GetAccessTokenUseCase>().call();

      if (token.isNotEmpty) return Routes.homeRoute;
    }

    return null;
  },
  routes: [
    GoRoute(
      name: Routes.splash,
      path: Routes.splashRoute,
      builder: SampleScreen.screen,
    ),
    GoRoute(
      name: Routes.login,
      path: Routes.loginRoute,
      builder: LoginScreen.screen,
    ),
    GoRoute(
      name: Routes.home,
      path: Routes.homeRoute,
      builder: HomeScreen.screen,
    ),
    GoRoute(
      name: Routes.detail,
      path: Routes.detailRoute,
      builder: DetailScreen.screen,
    ),
    GoRoute(
      name: Routes.register,
      path: Routes.registerRoute,
      builder: RegisterScreen.screen,
    ),
    GoRoute(
      name: Routes.forgot,
      path: Routes.forgotRoute,
      builder: ForgotPasswordScreen.screen,
    ),
  ],
);
