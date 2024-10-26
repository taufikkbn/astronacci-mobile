import 'package:base_flutter_bloc/presentation/screens/sample/view/sample_screen.dart';
import 'package:chucker_flutter/chucker_flutter.dart';
import 'package:go_router/go_router.dart';

import '../screens/home/view/home_screen.dart';
import '../screens/login/view/login_screen.dart';

part 'go_routes_path.dart';

final router = GoRouter(
  initialLocation: Routes.splashRoute,
  observers: [ChuckerFlutter.navigatorObserver],
  redirect: (context, state) {
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
  ],
);
