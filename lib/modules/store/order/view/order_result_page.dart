import 'package:facebook_app_events/facebook_app_events.dart';
import 'package:turtlz/support/style/format_unit.dart';
import 'package:turtlz/modules/main/main_screen.dart';
import 'package:turtlz/support/style/theme.dart';
import 'package:flutter/material.dart';
import 'package:vrouter/vrouter.dart';

class OrderResultPage extends StatelessWidget {
  static String routeName = '/order_result_page';

  static final facebookAppEvents = FacebookAppEvents();

  OrderResultPage(this.result);

  final Map<String, String> result;

  bool getIsSuccessed(Map<String, String> result) {
    if (result['imp_success'] == 'true') {
      facebookAppEvents.logPurchase(
          amount: double.parse(result['amount']!), currency: 'KRW');
      return true;
    }
    if (result['success'] == 'true') {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    bool isSuccessed = getIsSuccessed(result);

    return Scaffold(
        appBar: AppBar(
            elevation: 0,
            iconTheme: const IconThemeData(color: Colors.black),
            backgroundColor: Colors.white),
        body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                  margin: const EdgeInsets.only(top: 200),
                  child: Center(
                      child: Text(isSuccessed ? 'order success! :)' : '주문 실패!',
                          style: theme.textTheme.headline1!
                              .copyWith(height: 1.5)))),
              GestureDetector(
                  onTap: () => context.vRouter
                      .to(MainScreen.routeName, isReplacement: true),
                  child: Container(
                      alignment: Alignment.center,
                      width: maxWidth(context) - 40,
                      decoration: BoxDecoration(
                          border:
                              Border.all(color: theme.primaryColor, width: 2),
                          borderRadius: BorderRadius.circular(25)),
                      margin: const EdgeInsets.only(bottom: 50),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: Text('더 둘러보기', style: theme.textTheme.headline4)))
            ]));
  }
}
