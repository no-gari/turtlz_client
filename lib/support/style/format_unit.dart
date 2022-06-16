import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';

String currencyFromString(String value) {
  return toCurrencyString(value, mantissaLength: 0, trailingSymbol: "원");
}
