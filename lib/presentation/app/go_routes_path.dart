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
}
