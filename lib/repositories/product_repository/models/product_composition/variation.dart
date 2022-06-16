import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'variation.g.dart';

@JsonSerializable()
class Variation extends Equatable {
  const Variation(this.value, this.Id);

  final String Id;
  final String value;

  factory Variation.fromJson(Map<String, dynamic> json) =>
      _$VariationFromJson(json);

  Map<String, dynamic> toJson() => _$VariationToJson(this);

  @override
  List<Object?> get props => [Id, value];

}