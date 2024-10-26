import 'package:json_annotation/json_annotation.dart';

part 'sample_model.g.dart';

@JsonSerializable()
class SampleModel {
  // TODO: use freezed

  @JsonKey(name: 'userId')
  int? userId;
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'title')
  String? title;
  @JsonKey(name: 'body')
  String? body;

  SampleModel({
    this.userId,
    this.id,
    this.title,
    this.body,
  });

  factory SampleModel.fromJson(Map<String, dynamic> json) =>
      _$SampleModelFromJson(json);

  Map<String, dynamic> toJson() => _$SampleModelToJson(this);
}
