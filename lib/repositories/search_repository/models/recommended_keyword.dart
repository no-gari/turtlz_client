import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
part 'recommended_keyword.g.dart';

@JsonSerializable()
class RecommendedKeyword extends Equatable {
  const RecommendedKeyword(this.keyword, this.id);

  final int? id;
  final int? keyword;

  factory RecommendedKeyword.fromJson(Map<String, dynamic> json) =>
      _$RecommendedKeywordFromJson(json);

  Map<String, dynamic> toJson() => _$RecommendedKeywordToJson(this);

  @override
  List<Object?> get props => [keyword, id];
}
