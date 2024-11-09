import 'package:freezed_annotation/freezed_annotation.dart';

part 'register_request.g.dart';

@JsonSerializable()
class RegisterRequest {
  String name;
  String email;
  String password;
  String confirmPassword;

  RegisterRequest({
    required this.name,
    required this.email,
    required this.password,
    required this.confirmPassword,
  });

  factory RegisterRequest.fromJson(Map<String, dynamic> json) =>
      _$RegisterRequestFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterRequestToJson(this);
}