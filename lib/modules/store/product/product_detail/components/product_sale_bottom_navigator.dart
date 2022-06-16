import 'package:turtlz/modules/store/product/cubit/product_cubit.dart';
import 'package:turtlz/support/base_component/login_needed.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'product_purchase_sheet.dart';

Widget productSaleBottomNavigator(
    BuildContext context, ProductCubit _productCubit, bool isAuthenticated) {
  return GestureDetector(
      onTap: () {
        if (isAuthenticated == true) {
          showModalBottomSheet(
              context: context,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25))),
              builder: (context) => BlocProvider<ProductCubit>.value(
                  value: _productCubit, child: ProductPurchaseSheet()),
              isScrollControlled: true);
        } else {
          showLoginNeededDialog(context);
        }
      },
      child: Container(
          height: 80,
          width: 300,
          decoration: BoxDecoration(
              color: Colors.black, border: Border.all(color: Colors.black)),
          child: Center(
              child: Text('구매하기',
                  style: Theme.of(context)
                      .textTheme
                      .headline5!
                      .copyWith(color: Colors.white)))));
}
