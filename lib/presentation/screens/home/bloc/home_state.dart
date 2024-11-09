part of 'home_bloc.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState({
    @Default(false) bool isLoading,
    @Default([]) List<UserModel> userData,
    Failure? userError,
    String? search,
    @Default(1) int page,
    @Default(false) bool hasReachedMax,
    @Default(true) bool isNewSearch,
  }) = _HomeState;

  factory HomeState.initial() => const HomeState(isLoading: false);

  factory HomeState.userDataLoading() => const HomeState(isLoading: true);

  factory HomeState.userDataSuccess(List<UserModel> data) => HomeState(
        isLoading: false,
        userData: data,
        hasReachedMax: false,
      );

  factory HomeState.userDataFailed(Failure error) => HomeState(
        isLoading: false,
        userError: error,
      );
}
