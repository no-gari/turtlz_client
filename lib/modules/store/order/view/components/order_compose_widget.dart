import 'package:turtlz/support/style/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

Widget orderCompose({String? title, Widget? child, bool? isRequired}) {
  return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    RichText(
      text: TextSpan(style: theme.textTheme.headline4, children: [
        TextSpan(text: "$title"),
        TextSpan(
            text: isRequired != null && isRequired ? "*" : "",
            style: TextStyle(color: theme.accentColor)),
      ]),
    ),
    child != null ? child : SizedBox(height: 0),
    Padding(
        padding: EdgeInsets.symmetric(vertical: Adaptive.h(2)),
        child: Divider(color: Colors.grey))
  ]);
}
