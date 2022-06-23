// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Address _$AddressFromJson(Map<String, dynamic> json) => Address(
      id: json['id'] as int?,
      name: json['name'] as String?,
      bigAddress: json['bigAddress'] as String?,
      smallAddress: json['smallAddress'] as String?,
      postalCode: json['postalCode'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      isDefault: json['isDefault'] as bool? ?? false,
    );

Map<String, dynamic> _$AddressToJson(Address instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'bigAddress': instance.bigAddress,
      'smallAddress': instance.smallAddress,
      'postalCode': instance.postalCode,
      'phoneNumber': instance.phoneNumber,
      'isDefault': instance.isDefault,
    };
