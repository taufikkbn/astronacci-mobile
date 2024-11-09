part of 'forgot_bloc.dart';

@freezed
class ForgotState with _$ForgotState {
  const factory ForgotState({
    @Default(false) bool isLoading,
    ForgotPasswordModel? data,
    Failure? userError,
  }) = _ForgotState;

  factory ForgotState.initial() => const ForgotState(isLoading: false);

  factory ForgotState.userDataLoading() => const ForgotState(isLoading: true);

  factory ForgotState.userDataSuccess(ForgotPasswordModel data) => ForgotState(
    isLoading: false,
    data: data,
  );

  factory ForgotState.userDataFailed(Failure error) => ForgotState(
    isLoading: false,
    userError: error,
  );

}
