import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:turtlz/modules/store/product/cubit/product_cubit.dart';
import 'package:turtlz/support/base_component/login_needed.dart';
import 'package:turtlz/support/style/format_unit.dart';
import 'product_purchase_sheet.dart';

Widget productSaleBottomNavigator(
    BuildContext context, ProductCubit _productCubit, bool isAuthenticated) {
  return GestureDetector(
      onTap: () {
        if (isAuthenticated == true) {
          showModalBottomSheet(
              context: context,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25))),
              builder: (context) => BlocProvider<ProductCubit>.value(
                  value: _productCubit, child: ProductPurchaseSheet()),
              isScrollControlled: true);
        } else {
          showSocialLoginNeededDialog(context);
        }
      },
      child: Container(
          height: 70,
          width: maxWidth(context),
          decoration: BoxDecoration(
              border: Border(
                  top: BorderSide(color: Theme.of(context).primaryColor))),
          child: Center(
              child: Text('구매하기',
                  style: Theme.of(context)
                      .textTheme
                      .headline5!
                      .copyWith(color: Theme.of(context).primaryColor)))));
}
