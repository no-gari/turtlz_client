import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'shipping_request.g.dart';

@JsonSerializable()
class ShippingRequest extends Equatable {
  const ShippingRequest(
    this.id,
    this.content,
  );

  final int id;
  final String content;

  factory ShippingRequest.fromJson(Map<String, dynamic> json) =>
      _$ShippingRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ShippingRequestToJson(this);

  @override
  List<Object> get props => [id, content];
}
