// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mypage.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Mypage _$MypageFromJson(Map<String, dynamic> json) => Mypage(
      json['user'] as Map<String, dynamic>?,
      json['orderDone'] as int?,
      json['orderReviews'] as int?,
      json['magReviews'] as int?,
    );

Map<String, dynamic> _$MypageToJson(Mypage instance) => <String, dynamic>{
      'orderDone': instance.orderDone,
      'magReviews': instance.magReviews,
      'orderReviews': instance.orderReviews,
      'user': instance.user,
    };
