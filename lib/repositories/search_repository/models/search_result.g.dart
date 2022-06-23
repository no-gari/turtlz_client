// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchResult _$SearchResultFromJson(Map<String, dynamic> json) => SearchResult(
      json['keyword'] as String?,
      json['brands'] as List<dynamic>?,
      json['products'] as List<dynamic>?,
    );

Map<String, dynamic> _$SearchResultToJson(SearchResult instance) =>
    <String, dynamic>{
      'keyword': instance.keyword,
      'products': instance.products,
      'brands': instance.brands,
    };
