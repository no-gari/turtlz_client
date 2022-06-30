import 'package:turtlz/repositories/authentication_repository/authentication_repository.dart';
import 'package:turtlz/modules/authentication/bloc/authentication_bloc.dart';
import 'package:turtlz/modules/cart/components/cart_summary_widget.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart' as Svg;
import 'package:turtlz/modules/cart/components/cart_tile_widget.dart';
import 'package:turtlz/repositories/cart_repository/models/cart.dart';
import 'package:turtlz/modules/store/order/view/order_screen.dart';
import 'package:turtlz/support/base_component/login_needed.dart';
import 'package:turtlz/modules/cart/cubit/cart_cubit.dart';
import 'package:turtlz/support/style/format_unit.dart';
import 'package:turtlz/support/style/theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:vrouter/vrouter.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  late CartCubit _cartCubit;

  @override
  void initState() {
    super.initState();
    _cartCubit = BlocProvider.of<CartCubit>(context);
    _cartCubit.getCartList();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
      return Scaffold(
          body: SafeArea(
              child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('cart.',
                              style: Theme.of(context).textTheme.headline3),
                          IconButton(
                              onPressed: () {},
                              icon: ImageIcon(Svg.Svg("assets/icons/noti.svg"),
                                  color: Colors.white))
                        ]),
                    BlocBuilder<CartCubit, CartState>(
                        builder: (context, state) {
                      if (state.isLoaded) {
                        return BlocSelector<CartCubit, CartState, List<Cart>?>(
                            selector: (state) => state.carts,
                            builder: (context, carts) {
                              if (carts != null && carts.isNotEmpty) {

                                return Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                                'your products! (${state.carts!.length})',
                                                style:
                                                    theme.textTheme.headline5),
                                            const SizedBox(height: 15),
                                            Column(
                                                children: List.generate(
                                                    carts.length,
                                                    (index) => cartTile(
                                                        _cartCubit,
                                                        carts[index])))
                                          ]),
                                      cartSummary(carts, context),
                                      const SizedBox(height: 20),
                                      GestureDetector(
                                          onTap: () {
                                            List<Cart> checkedCart = carts.fold(
                                                <Cart>[],
                                                (pre, cart) => cart.isChecked!
                                                    ? pre + [cart]
                                                    : pre + []);
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        OrderScreen(
                                                            checkedCart)));
                                          },
                                          child: Container(
                                              width: maxWidth(context),
                                              height: 60,
                                              decoration: BoxDecoration(
                                                  color: theme.primaryColor,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
                                              child: Center(
                                                  child: Text("주문하기",
                                                      style: theme
                                                          .textTheme.headline5!
                                                          .copyWith(
                                                              color: Colors
                                                                  .white)))))
                                    ]);
                              } else {
                                return Padding(
                                  padding: EdgeInsets.only(
                                      top: MediaQuery.of(context).size.height *
                                          0.35),
                                  child: Center(
                                      child: Text("no contents :(",
                                          style: theme.textTheme.headline3!)),
                                );
                              }
                            });
                      } else {
                        return Padding(
                          padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.35),
                          child: Center(
                              child: Image.asset('assets/images/indicator.gif',
                                  width: 100, height: 100)),
                        );
                      }
                    })
                  ]))));
    });
  }
}
