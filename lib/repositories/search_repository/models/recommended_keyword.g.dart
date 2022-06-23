// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recommended_keyword.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecommendedKeyword _$RecommendedKeywordFromJson(Map<String, dynamic> json) =>
    RecommendedKeyword(
      json['keywords'] as String?,
      json['order'] as int?,
      json['id'] as int?,
    );

Map<String, dynamic> _$RecommendedKeywordToJson(RecommendedKeyword instance) =>
    <String, dynamic>{
      'id': instance.id,
      'order': instance.order,
      'keywords': instance.keywords,
    };
