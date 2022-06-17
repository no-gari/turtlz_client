import 'package:flutter/material.dart';

class OrderFormListTile extends StatelessWidget {
  OrderFormListTile({this.trailing, this.title});

  final Widget? title;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return ListTile(
        visualDensity: VisualDensity(horizontal: 0, vertical: -4),
        contentPadding: EdgeInsets.zero,
        title: title,
        trailing: trailing);
  }
}
