import 'package:turtlz/repositories/cart_repository/models/cart.dart';
import 'package:turtlz/modules/cart/cubit/cart_cubit.dart';
import 'package:turtlz/support/style/format_unit.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:turtlz/support/style/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

Widget cartTile(CartCubit cartCubit, Cart cart) {
  return Column(children: [
    Card(
        color: Colors.transparent,
        shadowColor: Colors.transparent,
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Flexible(
              child: // Icon(Icons.check_box_rounded)
                  GestureDetector(
                      onTap: () {
                        cartCubit.selectedCart(cart);
                      },
                      child: cart.isChecked!
                          ? Icon(Icons.check_box_rounded)
                          : Icon(Icons.check_box_outline_blank_rounded))),
          // 브랜드 정보
          Flexible(
              flex: 8,
              child: Wrap(runSpacing: Adaptive.h(1), children: [
                Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("  ${cart.brand}",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: Adaptive.sp(14))),
                      GestureDetector(
                          onTap: () {
                            cartCubit.deleteCart([cart]);
                          },
                          child: Icon(Icons.clear))
                    ]),
                // 상품 정보
                Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          margin: EdgeInsets.only(
                              right: Adaptive.h(1), bottom: Adaptive.h(1)),
                          child: Image.network("${cart.productThumbnail}",
                              height: 100, width: 100, fit: BoxFit.cover)),
                      Flexible(
                          child: Container(
                              height: 100,
                              child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("${cart.productName}",
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis),
                                    Text("${cart.variantName}",
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis),
                                    Container(
                                        alignment: Alignment.bottomRight,
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text("수량 : ${cart.quantity}개",
                                                  style: theme
                                                      .textTheme.subtitle2),
                                              Text(
                                                  "${currencyFromString((cart.salePrice! * cart.quantity!).toString())}",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize:
                                                          Adaptive.sp(14)))
                                            ]))
                                  ])))
                    ])
              ]))
        ]))
  ]);
}
