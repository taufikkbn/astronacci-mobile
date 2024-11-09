part of 'forgot_bloc.dart';

@freezed
class ForgotEvent with _$ForgotEvent {
  const factory ForgotEvent.started() = _Started;
  const factory ForgotEvent.sendEmail(String email) = _SendEmail;
}
