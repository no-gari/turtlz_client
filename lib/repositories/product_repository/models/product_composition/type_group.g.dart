// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'type_group.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TypeGroup _$TypeGroupFromJson(Map<String, dynamic> json) => TypeGroup(
      option: json['option'] == null
          ? null
          : Option.fromJson(json['option'] as Map<String, dynamic>),
      variation: json['variation'] == null
          ? null
          : Variation.fromJson(json['variation'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TypeGroupToJson(TypeGroup instance) => <String, dynamic>{
      'option': instance.option,
      'variation': instance.variation,
    };
