import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
part 'recommended_keyword.g.dart';

@JsonSerializable()
class RecommendedKeyword extends Equatable {
  const RecommendedKeyword(this.keywords, this.order, this.id);

  final int? id;
  final int? order;
  final String? keywords;

  factory RecommendedKeyword.fromJson(Map<String, dynamic> json) =>
      _$RecommendedKeywordFromJson(json);

  Map<String, dynamic> toJson() => _$RecommendedKeywordToJson(this);

  @override
  List<Object?> get props => [keywords, order, id];
}
