import 'package:turtlz/modules/cart/view/cart_page.dart';
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
    return CartPage();
  }
}
