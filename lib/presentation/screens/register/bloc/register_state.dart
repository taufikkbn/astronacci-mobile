part of 'register_bloc.dart';

@freezed
class RegisterState with _$RegisterState {
  const factory RegisterState({
    @Default(false) bool isLoading,
    UserModel? userData,
    Failure? userError,
  }) = _RegisterState;

  factory RegisterState.initial() => const RegisterState(isLoading: false);

  factory RegisterState.userDataLoading() => const RegisterState(isLoading: true);

  factory RegisterState.userDataSuccess(UserModel data) => RegisterState(
    isLoading: false,
    userData: data,
  );

  factory RegisterState.userDataFailed(Failure error) => RegisterState(
    isLoading: false,
    userError: error,
  );
}
