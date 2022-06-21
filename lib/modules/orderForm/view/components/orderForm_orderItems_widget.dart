import 'package:turtlz/repositories/order_repository/models/order_item.dart';
import 'package:turtlz/support/style/format_unit.dart';
import 'package:turtlz/support/style/theme.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:flutter/material.dart';
import 'orderForm_base_component.dart';

Widget orderFormOrderItemsWidget(List<OrderItem> orderItems) {
  return orderFormBaseComponent(
      title: "주문 상품",
      isExpansion: true,
      children: List.generate(
          orderItems.length,
          (index) => Container(
                margin: EdgeInsets.only(bottom: 5),
                child: Row(children: [
                  Container(
                      width: 85,
                      height: 85,
                      margin: EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(
                                  "${orderItems[index].productThumbnail}")))),
                  Flexible(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                        Text("${orderItems.first.productName}",
                            style: theme.textTheme.headline5),
                        Text("${orderItems[index].variantName}"),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("수량 : ${orderItems[index].quantity}개"),
                              Text(
                                  "${currencyFromString(orderItems[index].salePrice.toString())}",
                                  style: theme.textTheme.headline5)
                            ])
                      ]))
                ]),
              )));
}
