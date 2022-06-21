import 'package:turtlz/repositories/coupon_repository/models/coupon.dart';
import 'package:turtlz/modules/store/coupon/cubit/coupon_cubit.dart';
import 'package:turtlz/modules/store/coupon/view/coupon_screen.dart';
import 'package:turtlz/modules/store/order/cubit/order_cubit.dart';
import 'package:turtlz/support/style/theme.dart';
import 'package:flutter/material.dart';

Widget orderCoupon(BuildContext context, Coupon? coupon,
    CouponCubit couponCubit, OrderCubit orderCubit) {
  return Column(
    children: [
      const SizedBox(height: 10),
      Wrap(runSpacing: 15, children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text("쿠폰 할인가", style: Theme.of(context).textTheme.headline5),
          RichText(
              text: TextSpan(
                  style: theme.textTheme.headline5!
                      .copyWith(color: theme.primaryColor),
                  children: [
                TextSpan(
                    text: "${coupon!.discount == null ? 0 : coupon.discount}"),
                const TextSpan(text: "원")
              ]))
        ]),
        Row(children: [
          Expanded(
            child: Container(
              height: 30,
              alignment: Alignment.center,
              margin: const EdgeInsets.only(right: 15),
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                          width: 2, color: Theme.of(context).primaryColor))),
              child: Text("${coupon.name == null ? "" : coupon.name}"),
            ),
          ),
          GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, CouponScreen.routeName)
                    .then((onValue) async {
                  orderCubit.getCoupon(onValue);
                });
              },
              child: Container(
                  height: 30,
                  width: 100,
                  decoration: BoxDecoration(
                      border: Border.all(color: theme.primaryColor),
                      borderRadius: BorderRadius.circular(20)),
                  alignment: Alignment.center,
                  child: Text("쿠폰 선택",
                      style: theme.textTheme.headline5!
                          .copyWith(color: theme.primaryColor))))
        ])
      ]),
      const Padding(
          padding: EdgeInsets.symmetric(vertical: 20), child: Divider())
    ],
  );
}
