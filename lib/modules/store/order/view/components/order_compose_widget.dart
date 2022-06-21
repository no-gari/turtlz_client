import 'package:turtlz/support/style/theme.dart';
import 'package:flutter/material.dart';

Widget orderCompose({String? title, Widget? child, bool? isRequired}) {
  return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    RichText(
        text: TextSpan(style: theme.textTheme.headline4, children: [
      TextSpan(text: "$title", style: theme.textTheme.headline4),
      TextSpan(
          text: isRequired != null && isRequired ? "*" : "",
          style: TextStyle(color: theme.accentColor))
    ])),
    child != null ? child : SizedBox(height: 0),
  ]);
}
