import 'package:turtlz/repositories/authentication_repository/authentication_repository.dart';
import 'package:turtlz/modules/authentication/bloc/authentication_bloc.dart';
import 'package:turtlz/support/base_component/login_needed.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:vrouter/vrouter.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
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
                              onPressed: () => state.status ==
                                      AuthenticationStatus.authenticated
                                  ? context.vRouter.toNamed('/notification')
                                  : showSocialLoginNeededDialog(context),
                              icon:
                                  const ImageIcon(Svg("assets/icons/noti.svg")))
                        ])
                  ]))));
    });
  }
}
