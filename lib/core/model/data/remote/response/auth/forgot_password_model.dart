import 'package:freezed_annotation/freezed_annotation.dart';

part 'forgot_password_model.g.dart';
part 'forgot_password_model.freezed.dart';

@freezed
class ForgotPasswordModel with _$ForgotPasswordModel {
  const factory ForgotPasswordModel({
    @JsonKey(name: 'message') String? message,
  }) = _ForgotPasswordModel;

  factory ForgotPasswordModel.fromJson(Map<String, dynamic> json) =>
      _$ForgotPasswordModelFromJson(json);
}