import 'package:json_annotation/json_annotation.dart';

part 'page_response.g.dart';

@JsonSerializable()
class PageResponse {
  PageResponse({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  final List<dynamic>? results;
  final int? count;
  final String? previous;
  final String? next;

  factory PageResponse.fromJson(Map<String, dynamic> json) =>
      _$PageResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PageResponseToJson(this);
}
