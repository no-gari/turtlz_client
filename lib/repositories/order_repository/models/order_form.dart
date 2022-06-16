import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'order_item.dart';

part 'order_form.g.dart';

@JsonSerializable()
class OrderForm extends Equatable {
  const OrderForm({
    this.Id,
    this.addressInfo,
    this.customerInfo,
    this.itemsInfo,
    this.orderDate,
    this.paymentInfo,
  });

  final String? Id;
  final String? orderDate;
  final Map? addressInfo;
  final Map? customerInfo;
  final List<OrderItem>? itemsInfo;
  final Map? paymentInfo;

  factory OrderForm.fromJson(Map<String, dynamic> json) =>
      _$OrderFormFromJson(json);

  Map<String, dynamic> toJson() => _$OrderFormToJson(this);

  OrderForm copyWith(
      {String? Id,
      String? orderDate,
      Map? addressInfo,
      Map? customerInfo,
      List<OrderItem>? itemsInfo,
      Map? paymentInfo}) {
    return OrderForm(
      Id: Id ?? this.Id,
      orderDate: orderDate ?? this.orderDate,
      addressInfo: addressInfo ?? this.addressInfo,
      customerInfo: customerInfo ?? this.customerInfo,
      itemsInfo: itemsInfo ?? this.itemsInfo,
      paymentInfo: paymentInfo ?? this.paymentInfo,
    );
  }

  @override
  List<Object?> get props => [
        Id,
        orderDate,
        addressInfo,
        customerInfo,
        itemsInfo,
        paymentInfo,
      ];
}
