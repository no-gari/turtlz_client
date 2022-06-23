// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Order _$OrderFromJson(Map<String, dynamic> json) => Order(
      merchantUid: json['merchantUid'] as String?,
      name: json['name'] as String?,
      amount: json['amount'] as int?,
      currency: json['currency'] as String?,
      buyerName: json['buyerName'] as String?,
      buyerTel: json['buyerTel'] as String?,
      buyerEmail: json['buyerEmail'] as String?,
    );

Map<String, dynamic> _$OrderToJson(Order instance) => <String, dynamic>{
      'merchantUid': instance.merchantUid,
      'name': instance.name,
      'amount': instance.amount,
      'currency': instance.currency,
      'buyerName': instance.buyerName,
      'buyerTel': instance.buyerTel,
      'buyerEmail': instance.buyerEmail,
    };
