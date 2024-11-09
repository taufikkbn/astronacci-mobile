part of 'detail_bloc.dart';

@freezed
class DetailState with _$DetailState {
  const factory DetailState({
    @Default(false) bool isLoading,
    UserModel? userData,
    Failure? userError,
    XFile? pickedFile,
    CroppedFile? croppedFile,
    @Default(false) bool isSuccessUpdateUser,
    Failure? errorUpdateUser,
  }) = _DetailState;

  factory DetailState.initial() => const DetailState(isLoading: false);

  factory DetailState.userDataLoading() => const DetailState(isLoading: true);

  factory DetailState.userDataSuccess(UserModel data) => DetailState(
    isLoading: false,
    userData: data,
  );

  factory DetailState.userDataFailed(Failure error) => DetailState(
    isLoading: false,
    userError: error,
  );
}
