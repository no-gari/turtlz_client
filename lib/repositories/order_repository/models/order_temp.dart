import 'package:turtlz/repositories/address_repository/models/address.dart';
import 'package:turtlz/repositories/coupon_repository/models/coupon.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'models.dart';

part 'order_temp.g.dart';

@JsonSerializable()
class OrderTemp extends Equatable {
  const OrderTemp({
    this.products,
    this.address,
    this.request,
    this.coupon,
  });

  final List<OrderItem>? products;
  final Address? address;
  final CustomerRequests? request;
  final Coupon? coupon;

  factory OrderTemp.fromJson(Map<String, dynamic> json) =>
      _$OrderTempFromJson(json);

  Map<String, dynamic> toJson() => _$OrderTempToJson(this);

  OrderTemp copyWith({
    List<OrderItem>? products,
    Address? address,
    CustomerRequests? request,
    Coupon? coupon,
  }) {
    return OrderTemp(
      products: products ?? this.products,
      address: address ?? this.address,
      request: request ?? this.request,
      coupon: coupon ?? this.coupon,
    );
  }

  @override
  List<Object?> get props => [
        products,
        address,
        request,
        coupon,
      ];
}
