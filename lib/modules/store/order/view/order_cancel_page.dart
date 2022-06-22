import 'package:flutter/material.dart';
import 'package:turtlz/modules/main/main_screen.dart';
import 'package:turtlz/support/style/format_unit.dart';
import 'package:turtlz/support/style/theme.dart';
import 'package:vrouter/vrouter.dart';

class OrderCancelPage extends StatelessWidget {
  static String routeName = '/order_cancel_page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
          Container(
              margin: const EdgeInsets.only(bottom: 20),
              child: Text("결제가 취소되었습니다.",
                  style: Theme.of(context).textTheme.headline4)),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: GestureDetector(
              onTap: () =>
                  context.vRouter.to(MainScreen.routeName, isReplacement: true),
              child: Container(
                  margin: const EdgeInsets.only(top: 10),
                  width: maxWidth(context),
                  height: 60,
                  decoration: BoxDecoration(
                      color: theme.primaryColor,
                      borderRadius: BorderRadius.circular(20)),
                  child: Center(
                      child: Text("홈 화면으로 이동",
                          style: theme.textTheme.headline5!
                              .copyWith(color: Colors.white)))),
            ),
          )
        ])));
  }
}
