import 'package:turtlz/repositories/coupon_repository/models/coupon.dart';
import 'package:turtlz/modules/store/coupon/cubit/coupon_cubit.dart';
import 'package:turtlz/modules/store/coupon/view/coupon_screen.dart';
import 'package:turtlz/modules/store/order/cubit/order_cubit.dart';
import 'package:turtlz/support/style/theme.dart';
import 'package:flutter/material.dart';

Widget orderCoupon(BuildContext context, Coupon? coupon,
    CouponCubit couponCubit, OrderCubit orderCubit) {
  return Wrap(runSpacing: 15, children: [
    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text("쿠폰 할인가"),
      RichText(
          text: TextSpan(style: theme.textTheme.bodyText1, children: [
        TextSpan(
            text: "${coupon!.discount == null ? 0 : coupon.discount}",
            style: TextStyle(
                color: theme.accentColor, fontWeight: FontWeight.w700)),
        TextSpan(text: "원")
      ]))
    ]),
    Row(children: [
      Container(
        height: 30,
        width: 250,
        alignment: Alignment.center,
        margin: EdgeInsets.only(right: 15),
        decoration: BoxDecoration(border: Border.all(color: Colors.black)),
        child: Text("${coupon.name == null ? "" : coupon.name}"),
      ),
      Expanded(
          child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, CouponScreen.routeName)
                    .then((onValue) async {
                  print("쿠폰 선택해라");
                  orderCubit.getCoupon(onValue);
                });
              },
              child: Container(
                  height: 30,
                  color: Colors.black,
                  alignment: Alignment.center,
                  child:
                      Text("쿠폰 선택하기", style: TextStyle(color: Colors.white)))))
    ])
  ]);
}
