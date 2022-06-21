import 'package:turtlz/repositories/address_repository/models/address.dart';
import 'package:turtlz/modules/mypage/address/view/address_screen.dart';
import 'package:turtlz/modules/store/order/cubit/order_cubit.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:turtlz/support/style/format_unit.dart';
import 'package:turtlz/support/style/theme.dart';
import 'package:flutter/material.dart';

Widget orderAddress(
    BuildContext context, Address address, OrderCubit orderCubit) {
  return Wrap(runSpacing: 15, children: [
    GestureDetector(
      onTap: () {
        Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => AddressScreen(isOrdering: true)))
            .then((updateAddress) => orderCubit.updateAddress(updateAddress));
      },
      child: Container(
          width: maxWidth(context),
          alignment: Alignment.centerRight,
          child: Text("변경/추가")),
    ),
    address != Address.empty
        ? RichText(
            text: TextSpan(style: theme.textTheme.bodyText1, children: [
              TextSpan(
                text: "${address.name} ${address.phoneNumber}\n",
              ),
              TextSpan(text: "${address.bigAddress} ${address.smallAddress}"),
            ]),
          )
        : Container(alignment: Alignment.center, child: Text("배송지가 없습니다.")),
    Padding(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Divider(),
    )
  ]);
}
