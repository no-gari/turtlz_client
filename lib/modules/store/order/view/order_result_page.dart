import 'package:turtlz/support/style/theme.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OrderResultPage extends StatelessWidget {
  static String routeName = '/order_result_page';

  OrderResultPage(this.result);

  final Map<String, String> result;

  bool getIsSuccessed(Map<String, String> result) {
    if (result['imp_success'] == 'true') {
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
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);

    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
        ),
        body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                  margin: EdgeInsets.only(top: Adaptive.h(25)),
                  child: Column(children: [
                    SvgPicture.asset(
                        isSuccessed
                            ? 'assets/icons/success.svg'
                            : 'assets/icons/error.svg',
                        color: theme.accentColor),
                    Text(isSuccessed ? '주문 완료!' : '주문 실패!',
                        style: theme.textTheme.headline1!.copyWith(height: 1.5))
                  ])),
              Container(
                  child: Column(children: [
                MaterialButton(
                    onPressed: () => Navigator.pushNamedAndRemoveUntil(
                        context, '', (route) => false),
                    child: Text('더 둘러보기'),
                    textColor: theme.accentColor,
                    color: Colors.white),
                SizedBox(height: Adaptive.h(10))
              ]))
            ]));
  }
}
