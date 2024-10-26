part of 'login_bloc.dart';

@freezed
class LoginState with _$LoginState {
  const factory LoginState.initial() = _LoginStateInitial;

  const factory LoginState.userDataLoading() = _UserDataLoading;
  const factory LoginState.userDataSuccess(UserModel data) = _UserDataResource;
  const factory LoginState.userDataFailed(Failure error) = _UserDataFailed;
}
