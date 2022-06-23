// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer_requests.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CustomerRequests _$CustomerRequestsFromJson(Map<String, dynamic> json) =>
    CustomerRequests(
      shippingRequest: (json['shippingRequest'] as List<dynamic>?)
          ?.map((e) => ShippingRequest.fromJson(e as Map<String, dynamic>))
          .toList(),
      additionalRequest: json['additionalRequest'] as String?,
    );

Map<String, dynamic> _$CustomerRequestsToJson(CustomerRequests instance) =>
    <String, dynamic>{
      'shippingRequest': instance.shippingRequest,
      'additionalRequest': instance.additionalRequest,
    };
