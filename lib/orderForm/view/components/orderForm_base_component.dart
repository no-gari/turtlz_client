import 'package:turtlz/support/style/theme.dart';
import 'package:flutter/material.dart';

Widget orderFormBaseComponent(
    {String? title, List<Widget>? children, bool? isExpansion = false}) {
  return Theme(
      data: theme.copyWith(dividerColor: Colors.transparent),
      child: Container(
          decoration:
              BoxDecoration(border: Border(bottom: BorderSide(width: 4))),
          child: ListTileTheme(
              dense: true,
              child: ExpansionTile(
                  title: Text("$title", style: theme.textTheme.headline5),
                  children: children!,
                  childrenPadding: EdgeInsets.zero,
                  tilePadding: EdgeInsets.zero,
                  initiallyExpanded: isExpansion!))));
}
