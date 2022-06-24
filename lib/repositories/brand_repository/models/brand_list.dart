import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
part 'brand_list.g.dart';

@JsonSerializable()
class BrandList extends Equatable {
  const BrandList(this.Id, this.name);

  final String? Id;
  final String? name;

  factory BrandList.fromJson(Map<String, dynamic> json) =>
      _$BrandListFromJson(json);

  Map<String, dynamic> toJson() => _$BrandListToJson(this);

  @override
  List<Object?> get props => [Id, name];
}
