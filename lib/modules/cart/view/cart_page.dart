import 'package:flutter_svg/flutter_svg.dart';
import 'package:turtlz/modules/cart/components/cart_summary_widget.dart';
import 'package:turtlz/modules/cart/components/cart_tile_widget.dart';
import 'package:turtlz/modules/cart/cubit/cart_cubit.dart';
import 'package:turtlz/modules/store/order/view/order_screen.dart';
import 'package:turtlz/repositories/authentication_repository/authentication_repository.dart';
import 'package:turtlz/modules/authentication/bloc/authentication_bloc.dart';
import 'package:turtlz/repositories/cart_repository/models/cart.dart';
import 'package:turtlz/support/base_component/login_needed.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart' as Svg;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:turtlz/support/style/format_unit.dart';
import 'package:turtlz/support/style/theme.dart';
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
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text('cart.', style: Theme.of(context).textTheme.headline3),
            IconButton(
                onPressed: () =>
                    state.status == AuthenticationStatus.authenticated
                        ? context.vRouter.toNamed('/notification')
                        : showSocialLoginNeededDialog(context),
                icon: const ImageIcon(Svg.Svg("assets/icons/noti.svg")))
          ]),
          BlocBuilder<CartCubit, CartState>(builder: (context, state) {
            if (state.isLoaded) {
              return BlocSelector<CartCubit, CartState, List<Cart>?>(
                  selector: (state) => state.carts,
                  builder: (context, carts) {
                    if (carts != null && carts.isNotEmpty) {
                      // print(carts.map((e) => e.Id));

                      // bool allCheckBox = !(carts
                      //     .map((cart) => cart.isChecked)
                      //     .toList()
                      //     .contains(false));
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('your products! (${state.carts!.length})',
                                    style: theme.textTheme.headline5),
                                const SizedBox(height: 15),
                                // 전체선택 컴포넌트
                                // Column(
                                //   crossAxisAlignment: CrossAxisAlignment.start,
                                //   children: [
                                //     Row(
                                //       mainAxisAlignment:
                                //           MainAxisAlignment.spaceBetween,
                                //       children: [
                                //         Row(
                                //           children: [
                                //             GestureDetector(
                                //                 onTap: () {
                                //                   _cartCubit.allSelectedCart(
                                //                       !allCheckBox);
                                //                 },
                                //                 child: allCheckBox
                                //                     ? Icon(Icons.check_box_rounded)
                                //                     : Icon(Icons
                                //                         .check_box_outline_blank_rounded)),
                                //             Text("전체선택")
                                //           ],
                                //         ),
                                //         InkWell(
                                //           onTap: () {
                                //             List<Cart> deleteCarts = state.carts!
                                //                 .fold(
                                //                     <Cart>[],
                                //                     (pre, cart) => cart.isChecked!
                                //                         ? pre + [cart]
                                //                         : pre + []);
                                //             _cartCubit.deleteCart(deleteCarts);
                                //           },
                                //           child: Text(
                                //             "선택삭제",
                                //             style: TextStyle(
                                //                 decoration:
                                //                     TextDecoration.underline),
                                //           ),
                                //         )
                                //       ],
                                //     ),
                                //   ],
                                // ),
                                Column(
                                    children: List.generate(
                                        carts.length,
                                        (index) =>
                                            cartTile(_cartCubit, carts[index])))
                              ]),
                          cartSummary(carts, context)
                        ],
                      );
                    } else {
                      return Center(
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                            Text("no contents :(",
                                style: theme.textTheme.headline3!)
                          ]));
                    }
                  });
            } else {
              return Center(
                  child: Image.asset('assets/images/indicator.gif',
                      width: 100, height: 100));
            }
          })
        ]),
      )));
    });
  }
}
