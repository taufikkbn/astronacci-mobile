import 'package:freezed_annotation/freezed_annotation.dart';

part 'base_paging_response.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class BasePagingResponse<T> {
  int? total;
  String? page;
  String? limit;
  int? totalPages;
  List<T>? data;

  BasePagingResponse({
    this.total,
    this.page,
    this.limit,
    this.data,
  });

  factory BasePagingResponse.fromJson(
      Map<String, dynamic> json, T Function(Object? json) fromJsonT) =>
      _$BasePagingResponseFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(Object? Function(T value) toJsonT) =>
      _$BasePagingResponseToJson(this, toJsonT);
}