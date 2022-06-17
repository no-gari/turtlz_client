import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:flutter/material.dart';
import 'package:vrouter/vrouter.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
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
                            onPressed: () =>
                                context.vRouter.toNamed('/notification'),
                            icon: const ImageIcon(Svg("assets/icons/noti.svg")))
                      ])
                ]))));
  }
}
