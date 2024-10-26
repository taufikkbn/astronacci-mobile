part of 'home_bloc.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState.initial() = _HomeStateInitial;

  const factory HomeState.userDataLoading() = _UserDataLoading;

  const factory HomeState.userDataSuccess(UserModel data) = _UserDataSuccess;

  const factory HomeState.userDataFailed(Failure error) = _UserDataFailed;

}