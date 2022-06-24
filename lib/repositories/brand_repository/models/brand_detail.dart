import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'brand_detail.g.dart';

@JsonSerializable()
class BrandDetail extends Equatable {
  const BrandDetail(this.Id, this.name, this.products);

  final String? Id;
  // final String? description;
  final String? name;
  final List? products;

  factory BrandDetail.fromJson(Map<String, dynamic> json) =>
      _$BrandDetailFromJson(json);

  Map<String, dynamic> toJson() => _$BrandDetailToJson(this);

  @override
  List<Object?> get props => [Id, name, products];
}
