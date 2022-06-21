import 'package:turtlz/repositories/coupon_repository/models/coupon.dart';
import 'package:turtlz/modules/store/coupon/cubit/coupon_cubit.dart';
import 'package:turtlz/support/style/format_unit.dart';
import 'package:turtlz/support/style/theme.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';

Widget couponTile(CouponCubit couponCubit, Coupon coupon, bool isSelected,
    widgetIsMypage, context) {
  return Column(children: [
    Card(
        color: Colors.transparent,
        shadowColor: Colors.transparent,
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          if (widgetIsMypage == false)
            Flexible(
                child: isSelected
                    ? Icon(Icons.radio_button_checked,
                        color: theme.primaryColor)
                    : Icon(Icons.radio_button_off, color: theme.primaryColor)),
          // 브랜드 정보
          Flexible(
              flex: 15,
              child: Container(
                  padding: const EdgeInsets.all(20),
                  margin: const EdgeInsets.only(left: 15),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: theme.primaryColor),
                      borderRadius: BorderRadius.circular(15)),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                  "${currencyFromString(coupon.discount.toString())} 할인",
                                  style: theme.textTheme.headline4!
                                      .copyWith(color: theme.primaryColor)),
                              SvgPicture.asset("assets/images/turtlz.svg",
                                  width: 90)
                            ]),
                        const SizedBox(height: 10),
                        Text("${coupon.name}",
                            style: theme.textTheme.headline5),
                        const SizedBox(height: 10),
                        SizedBox(
                            width: maxWidth(context),
                            child: Wrap(runSpacing: 10, children: [
                              Text(
                                "${coupon.description}",
                                style: theme.textTheme.headline6,
                              )
                            ]))
                      ])))
        ]))
  ]);
}
