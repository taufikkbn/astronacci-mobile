part of 'home_bloc.dart';

@freezed
class HomeEvent with _$HomeEvent {
  const factory HomeEvent.fetchUser({String? search, @Default(1) int page, @Default(true) bool isNewSearch}) = _FetchUser;
  const factory HomeEvent.logout() = _Logout;
}
