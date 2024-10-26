part of 'login_bloc.dart';

@freezed
class LoginState with _$LoginState {
  const factory LoginState({
    @Default(false) bool isLoading,
    UserModel? userData,
    Failure? userError,
  }) = _LoginState;

  factory LoginState.initial() => const LoginState(isLoading: false);

  factory LoginState.loading() => const LoginState(isLoading: true);

  factory LoginState.success(UserModel data) => LoginState(
        isLoading: false,
        userData: data,
      );

  factory LoginState.failed(Failure error) => LoginState(
        isLoading: false,
        userError: error,
      );
}
