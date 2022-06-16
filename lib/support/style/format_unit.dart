import 'package:flutter/cupertino.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

String currencyFromString(String value) {
  return toCurrencyString(value, mantissaLength: 0, trailingSymbol: "원");
}

double maxWidth(context) {
  return MediaQuery.of(context).size.width > 475
      ? 475
      : MediaQuery.of(context).size.width;
}
