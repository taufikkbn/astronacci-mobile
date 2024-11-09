part of 'login_bloc.dart';

@freezed
class LoginEvent with _$LoginEvent {
  const factory LoginEvent.initial() = _Initial;
  const factory LoginEvent.login(String username, String password) = _Login;
}
