import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

String currencyFromString(String value) {
  return toCurrencyString(value, mantissaLength: 0, trailingSymbol: "원");
}

double maxWidth() {
  return Adaptive.w(100) > 475 ? 475 : Adaptive.w(100);
}
