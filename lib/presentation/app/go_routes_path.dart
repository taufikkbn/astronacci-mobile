part of 'go_routes.dart';

class Routes {
  static final Routes _instance = Routes._internal();

  Routes._internal();

  factory Routes() => _instance;

  // Static constant route names
  static const String splash = "splash";
  static const String splashRoute = "/";

  static const String login = "login";
  static const String loginRoute = "/login";

  static const String home = "home";
  static const String homeRoute = "/home";

  static const String detail = "detail";
  static const String detailRoute = "/detail";

  static const String register = "register";
  static const String registerRoute = "/register";

  static const String forgot = "forgot";
  static const String forgotRoute = "/forgot";
}
