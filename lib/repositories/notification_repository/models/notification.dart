import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

part 'notification.g.dart';

@JsonSerializable()
class Notification extends Equatable {
  const Notification(this.id, this.title, this.subTitle, this.url, this.hits);

  final int? id;
  final int? hits;
  final String? title;
  final String? subTitle;
  final String? url;

  factory Notification.fromJson(Map<String, dynamic> json) =>
      _$NotificationFromJson(json);
  Map<String, dynamic> toJson() => _$NotificationToJson(this);

  @override
  List<Object?> get props => [id, title, subTitle, url, hits];
}
