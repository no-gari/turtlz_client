import 'package:turtlz/modules/notification/view/notification_screen.dart';
import 'package:extended_tabs/extended_tabs.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';
import 'package:vrouter/vrouter.dart';
import 'dart:math' as math;

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: [
      Container(
        child: Text('터틀즈가 처음이라면? 첫 구매 할인 쿠폰 받으세요'),
      ),
      Row(
        children: [],
      )
    ]));
  }
}
