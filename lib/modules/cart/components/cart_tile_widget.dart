import 'package:turtlz/repositories/cart_repository/models/cart.dart';
import 'package:turtlz/modules/cart/cubit/cart_cubit.dart';
import 'package:turtlz/support/style/format_unit.dart';
import 'package:turtlz/support/style/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

Widget cartTile(CartCubit cartCubit, Cart cart) {
  return Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
    Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      // Flexible(
      //     child:
      //         CircleAvatar(radius: 5, backgroundImage: NetworkImage('${cart.}'),)
      //         GestureDetector(
      //             onTap: () {
      //               cartCubit.selectedCart(cart);
      //             },
      //             child: cart.isChecked!
      //                 ? Icon(Icons.check_box_rounded)
      //                 : Icon(Icons.check_box_outline_blank_rounded))),
      // 브랜드 정보
      Flexible(
          flex: 8,
          child: Wrap(runSpacing: 10, children: [
            // Row(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       Text("${cart.brand}",
            //           style: TextStyle(
            //               fontWeight: FontWeight.bold, fontSize: 15)),
            //       GestureDetector(
            //           onTap: () {
            //             cartCubit.deleteCart([cart]);
            //           },
            //           child: Icon(Icons.clear))
            //     ]),
            // 상품 정보
            Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.network("${cart.productThumbnail}",
                          height: 110, width: 110, fit: BoxFit.cover)),
                  const SizedBox(width: 10),
                  Flexible(
                      child: Container(
                          height: 110,
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("${cart.brand}",
                                          style: theme.textTheme.headline6!
                                              .copyWith(fontSize: 13)),
                                      GestureDetector(
                                          onTap: () =>
                                              cartCubit.deleteCart([cart]),
                                          child:
                                              const Icon(Icons.clear, size: 20))
                                    ]),
                                Text(
                                  "${cart.productName}",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: theme.textTheme.headline5,
                                ),
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
                                              style: theme.textTheme.headline5),
                                          Text(
                                              "${currencyFromString((cart.salePrice! * cart.quantity!).toString())}",
                                              style: theme.textTheme.headline5!
                                                  .copyWith(
                                                      color:
                                                          theme.primaryColor))
                                        ]))
                              ])))
                ])
          ]))
    ]),
    const SizedBox(height: 15),
  ]);
}
