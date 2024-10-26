part of 'home_bloc.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState({
    @Default(false) bool isLoading,
    UserModel? userData,
    Failure? userError,
  }) = _HomeState;

  factory HomeState.initial() => const HomeState(isLoading: false);

  factory HomeState.userDataLoading() => const HomeState(isLoading: true);

  factory HomeState.userDataSuccess(UserModel data) => HomeState(
        isLoading: false,
        userData: data,
      );

  factory HomeState.userDataFailed(Failure error) => HomeState(
        isLoading: false,
        userError: error,
      );
}
