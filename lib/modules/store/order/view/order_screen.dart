import 'package:turtlz/repositories/address_repository/src/address_repository.dart';
import 'package:turtlz/repositories/order_repository/src/order_repository.dart';
import 'package:turtlz/repositories/coupon_repository/coupon_repository.dart';
import 'package:turtlz/modules/mypage/address/cubit/address_cubit.dart';
import 'package:turtlz/repositories/cart_repository/models/cart.dart';
import 'package:turtlz/modules/store/coupon/cubit/coupon_cubit.dart';
import 'package:turtlz/modules/store/order/cubit/order_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

import 'order_page.dart';

class OrderScreen extends StatefulWidget {
  OrderScreen(this.carts);

  final List<Cart> carts;

  @override
  State<StatefulWidget> createState() => _OrderScreen();
}

class _OrderScreen extends State<OrderScreen>
    with SingleTickerProviderStateMixin {
  List<Cart> get carts => this.widget.carts;

  late OrderCubit _orderCubit;
  late AddressCubit _addressCubit;
  late CouponCubit _couponCubit;

  @override
  void initState() {
    super.initState();
    _orderCubit = OrderCubit(RepositoryProvider.of<OrderRepository>(context));
    _addressCubit =
        AddressCubit(RepositoryProvider.of<AddressRepository>(context));
    _couponCubit =
        CouponCubit(RepositoryProvider.of<CouponRepository>(context));

    _orderCubit.createOrder(carts);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(automaticallyImplyLeading: true),
        body: MultiBlocProvider(providers: [
          BlocProvider.value(value: _orderCubit),
          BlocProvider.value(value: _addressCubit),
          BlocProvider.value(value: _couponCubit),
        ], child: OrderPage()));
  }
}
