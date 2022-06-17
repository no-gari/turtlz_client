import 'package:turtlz/modules/orderForm/view/components/orderFormListTile.dart';
import 'package:turtlz/support/style/format_unit.dart';
import 'package:flutter/material.dart';
import 'orderForm_base_component.dart';

Widget orderFormPaymentsWidget(Map paymentInfo) {
  return orderFormBaseComponent(title: "결제 정보", children: [
    OrderFormListTile(
        title: Text("상품 금액"),
        trailing: Text(
            "${currencyFromString(paymentInfo["totalOriginalPrice"].toString())}")),
    OrderFormListTile(
        title: Text("총 할인 금액"),
        trailing: Text(
            "${currencyFromString(paymentInfo["totalDiscountedPrice"].toString())}")),
    OrderFormListTile(
        title: Text("총 구매 금액"),
        trailing: Text(
            "${currencyFromString(paymentInfo["totalSalePrice"].toString())}"))
  ]);
}
