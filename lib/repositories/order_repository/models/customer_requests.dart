import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'shipping_request.dart';

part 'customer_requests.g.dart';

@JsonSerializable()
class CustomerRequests extends Equatable {
  const CustomerRequests({
    this.shippingRequest,
    this.additionalRequest,
  });

  final List<ShippingRequest>? shippingRequest;
  final String? additionalRequest;

  factory CustomerRequests.fromJson(Map<String, dynamic> json) =>
      _$CustomerRequestsFromJson(json);

  Map<String, dynamic> toJson() => _$CustomerRequestsToJson(this);

  @override
  List<Object?> get props => [shippingRequest, additionalRequest];

  CustomerRequests copyWith({
    List<ShippingRequest>? shippingRequest,
    String? additionalRequest,
  }) {
    return CustomerRequests(
      shippingRequest: shippingRequest ?? this.shippingRequest,
      additionalRequest: additionalRequest ?? this.additionalRequest,
    );
  }
}
