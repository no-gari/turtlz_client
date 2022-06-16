import 'package:turtlz/orderForm/view/components/orderFormListTile.dart';
import 'package:flutter/material.dart';
import 'orderForm_base_component.dart';

Widget orderFormAddressWidget(Map addressInfo) {
  return orderFormBaseComponent(title: "배송지 정보", children: [
    OrderFormListTile(
        title: Text("우편번호"), trailing: Text("${addressInfo["postcode"]}")),
    OrderFormListTile(
        title: Text("주소"), trailing: Text("${addressInfo["address"]}"))
  ]);
}
