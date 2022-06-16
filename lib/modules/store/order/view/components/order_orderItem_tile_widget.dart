import 'package:turtlz/repositories/order_repository/models/order_item.dart';
import 'package:turtlz/modules/store/order/cubit/order_cubit.dart';
import 'package:turtlz/support/style/format_unit.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:turtlz/support/style/theme.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter/material.dart';

Widget orderItemTile(OrderCubit orderCubit, OrderItem orderItem) {
  return Column(children: [
    Card(
        color: Colors.transparent,
        shadowColor: Colors.transparent,
        child: Wrap(runSpacing: Adaptive.h(1), children: [
          Text("${orderItem.brand}",
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: Adaptive.dp(12))),
          // 상품 정보
          Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    margin: EdgeInsets.only(right: 5, bottom: 5),
                    child: Image.network("${orderItem.productThumbnail}",
                        height: 100, width: 100, fit: BoxFit.cover)),
                Flexible(
                    child: Container(
                        height: 100,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("${orderItem.productName}",
                                  maxLines: 1, overflow: TextOverflow.ellipsis),
                              Text("${orderItem.variantName}",
                                  maxLines: 1, overflow: TextOverflow.ellipsis),
                              Container(
                                  alignment: Alignment.bottomRight,
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "수량 : ${orderItem.quantity}개",
                                          style: theme.textTheme.subtitle2,
                                        ),
                                        Text(
                                            "${currencyFromString((orderItem.salePrice! * orderItem.quantity!).toString())}",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: Adaptive.sp(14)))
                                      ]))
                            ])))
              ])
        ]))
  ]);
}
