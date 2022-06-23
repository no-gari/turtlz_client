// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Notification _$NotificationFromJson(Map<String, dynamic> json) => Notification(
      json['id'] as int?,
      json['title'] as String?,
      json['subTitle'] as String?,
      json['url'] as String?,
      json['hits'] as int?,
    );

Map<String, dynamic> _$NotificationToJson(Notification instance) =>
    <String, dynamic>{
      'id': instance.id,
      'hits': instance.hits,
      'title': instance.title,
      'subTitle': instance.subTitle,
      'url': instance.url,
    };
