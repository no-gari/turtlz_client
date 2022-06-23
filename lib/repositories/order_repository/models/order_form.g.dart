// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_form.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderForm _$OrderFormFromJson(Map<String, dynamic> json) => OrderForm(
      Id: json['Id'] as String?,
      addressInfo: json['addressInfo'] as Map<String, dynamic>?,
      customerInfo: json['customerInfo'] as Map<String, dynamic>?,
      itemsInfo: (json['itemsInfo'] as List<dynamic>?)
          ?.map((e) => OrderItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      orderDate: json['orderDate'] as String?,
      paymentInfo: json['paymentInfo'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$OrderFormToJson(OrderForm instance) => <String, dynamic>{
      'Id': instance.Id,
      'orderDate': instance.orderDate,
      'addressInfo': instance.addressInfo,
      'customerInfo': instance.customerInfo,
      'itemsInfo': instance.itemsInfo,
      'paymentInfo': instance.paymentInfo,
    };
