import 'package:turtlz/repositories/product_repository/models/product_composition/type_group.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

part 'variants.g.dart';

@JsonSerializable()
class Variants extends Equatable {
  const Variants({
    this.Id,
    this.variantName,
    this.originalPrice,
    this.discountPrice,
    this.discountRate,
    this.available,
    this.thumbnail,
    this.types,
  });

  final String? Id;
  final String? variantName;
  final int? originalPrice;
  final int? discountPrice;
  final int? discountRate;
  final bool? available;
  final String? thumbnail;
  final List<TypeGroup>? types;

  factory Variants.fromJson(Map<String, dynamic> json) =>
      _$VariantsFromJson(json);
  Map<String, dynamic> toJson() => _$VariantsToJson(this);

  @override
  List<Object?> get props => [
        Id,
        variantName,
        originalPrice,
        discountPrice,
        discountRate,
        available,
        thumbnail,
        types,
      ];
}
