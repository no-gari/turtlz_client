import 'package:turtlz/modules/notification/view/notification_screen.dart';
import 'package:extended_tabs/extended_tabs.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';
import 'package:vrouter/vrouter.dart';
import 'dart:math' as math;

class MenuPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<MenuPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: SafeArea(
          child: Column(children: [
            Container(),
            Row(
              children: [],
            )
          ]),
        ));
  }
}
