import 'package:turtlz/repositories/product_repository/models/product_composition/variation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

part 'option.g.dart';

@JsonSerializable()
class Option extends Equatable {
  const Option({this.Id, this.name, this.variations});

  final String? Id;
  final String? name;
  final List<Variation>? variations;

  factory Option.fromJson(Map<String, dynamic> json) => _$OptionFromJson(json);

  Map<String, dynamic> toJson() => _$OptionToJson(this);

  @override
  List<Object?> get props => [
        Id,
        name,
        variations,
      ];
}
