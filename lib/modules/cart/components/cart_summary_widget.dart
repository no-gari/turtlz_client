import 'package:turtlz/repositories/cart_repository/models/cart.dart';
import 'package:turtlz/support/style/format_unit.dart';
import 'package:turtlz/support/style/theme.dart';
import 'package:flutter/material.dart';

Widget cartSummary(List<Cart> carts, context) {
  List<Cart> checkedCart = carts
      .fold(<Cart>[], (pre, cart) => cart.isChecked! ? pre + [cart] : pre + []);
  final num totalPrice = checkedCart.fold(
      0, (pre, cart) => pre + (cart.quantity! * cart.salePrice!));

  return Container(
      width: maxWidth(context),
      color: Colors.white,
      child: Column(children: [
        Divider(color: theme.primaryColor, thickness: 2),
        summaryOutline(
            title: "총 상품 금액",
            content: currencyFromString(totalPrice.toString()),
            titleStyle: const TextStyle(
                height: 1.6, fontWeight: FontWeight.w500, fontSize: 15),
            contentStyle: const TextStyle(
                fontWeight: FontWeight.w700, fontSize: 15, letterSpacing: -1)),
        summaryOutline(
            title: "총 배송비",
            content: "전 상품 무료배송",
            titleStyle: const TextStyle(
                height: 1.6, fontWeight: FontWeight.w500, fontSize: 15),
            contentStyle: const TextStyle(
                fontWeight: FontWeight.w700, fontSize: 15, letterSpacing: -1)),
        Divider(color: theme.primaryColor, thickness: 2),
        summaryOutline(
            title: "총 결제 예정 금액",
            content: currencyFromString(totalPrice.toString()),
            titleStyle:
                theme.textTheme.headline5!.copyWith(color: theme.primaryColor),
            contentStyle: TextStyle(
                fontWeight: FontWeight.w700,
                color: theme.accentColor,
                fontSize: 18,
                letterSpacing: -1))
      ]));
}

Widget summaryOutline({
  required String title,
  required String content,
  TextStyle? titleStyle,
  TextStyle? contentStyle,
}) {
  return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
    Text("$title", style: titleStyle),
    Text("$content", style: contentStyle)
  ]);
}
