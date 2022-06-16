import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'brand.g.dart';

@JsonSerializable()
class Brand extends Equatable {
  const Brand({this.Id, this.name, this.url});

  final String? Id;
  final String? name;
  final String? url;

  factory Brand.fromJson(Map<String, dynamic> json) => _$BrandFromJson(json);

  Map<String, dynamic> toJson() => _$BrandToJson(this);

  @override
  List<Object?> get props => [
        Id,
        name,
        url,
      ];

  Brand copyWith({
    String? Id,
    String? name,
    String? url,
  }) {
    return Brand(
      Id: Id ?? this.Id,
      name: name ?? this.name,
      url: url ?? this.url,
    );
  }
}
