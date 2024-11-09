import 'package:json_annotation/json_annotation.dart';

part 'user_update_request.g.dart';

@JsonSerializable()
class UserUpdateRequest {
  String? id;
  String? name;
  String? email;
  String? password;
  String? confirmPassword;
  String? imagePath;

  UserUpdateRequest({
    this.id,
    this.name,
    this.email,
    this.password,
    this.confirmPassword,
    this.imagePath,
  });

  factory UserUpdateRequest.fromJson(Map<String, dynamic> json) =>
      _$UserUpdateRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UserUpdateRequestToJson(this);
}