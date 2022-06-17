import 'package:turtlz/modules/authentication/bloc/authentication_bloc.dart';
import 'package:turtlz/repositories/cart_repository/cart_repository.dart';
import 'package:turtlz/modules/cart/cubit/cart_cubit.dart';
import 'package:turtlz/modules/cart/view/cart_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class CartScreen extends StatefulWidget {
  static String routeName = '/cart_screen';

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => CartScreen());
  }

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
        value: BlocProvider.of<AuthenticationBloc>(context),
        child: MultiBlocProvider(providers: [
          BlocProvider<CartCubit>(
              create: (_) =>
                  CartCubit(RepositoryProvider.of<CartRepository>(context))),
        ], child: CartPage()));
  }
}
