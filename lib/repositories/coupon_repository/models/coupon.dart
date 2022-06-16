import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'coupon.g.dart';

@JsonSerializable()
class Coupon extends Equatable {
  const Coupon(
      {this.Id,
      this.name,
      this.description,
      this.minPrice,
      this.discount,
      this.expiresAt});

  final String? Id;
  final String? name;
  final String? description;
  final int? minPrice;
  final int? discount;
  final String? expiresAt;

  factory Coupon.fromJson(Map<String, dynamic> json) => _$CouponFromJson(json);
  Map<String, dynamic> toJson() => _$CouponToJson(this);

  @override
  List<Object?> get props =>
      [Id, name, description, minPrice, discount, expiresAt];
}
