import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'mypage.g.dart';

@JsonSerializable()
class Mypage extends Equatable {
  const Mypage(this.user, this.orderDone, this.orderReviews, this.magReviews);

  final int? orderDone;
  final int? magReviews;
  final int? orderReviews;
  final Map<String, dynamic>? user;

  factory Mypage.fromJson(Map<String, dynamic> json) => _$MypageFromJson(json);
  Map<String, dynamic> toJson() => _$MypageToJson(this);

  @override
  List<Object?> get props => [orderDone, magReviews, orderReviews, user];
}
