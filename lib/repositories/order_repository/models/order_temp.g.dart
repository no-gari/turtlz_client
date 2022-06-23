// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_temp.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderTemp _$OrderTempFromJson(Map<String, dynamic> json) => OrderTemp(
      products: (json['products'] as List<dynamic>?)
          ?.map((e) => OrderItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      address: json['address'] == null
          ? null
          : Address.fromJson(json['address'] as Map<String, dynamic>),
      request: json['request'] == null
          ? null
          : CustomerRequests.fromJson(json['request'] as Map<String, dynamic>),
      coupon: json['coupon'] == null
          ? null
          : Coupon.fromJson(json['coupon'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$OrderTempToJson(OrderTemp instance) => <String, dynamic>{
      'products': instance.products,
      'address': instance.address,
      'request': instance.request,
      'coupon': instance.coupon,
    };
