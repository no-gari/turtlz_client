import 'package:flutter/material.dart';

final theme = ThemeData(
  appBarTheme: const AppBarTheme(
      color: const Color(0xFF37521C),
      foregroundColor: Colors.white,
      elevation: 0),
  dividerColor: Colors.black,
  fontFamily: '',
  bottomAppBarColor: const Color(0xFF37521C),
  backgroundColor: const Color(0xFFFFFFFF),
  focusColor: const Color(0xFF37521C),
  scaffoldBackgroundColor: const Color(0xFFFFFFFF),
  accentColor: const Color(0xFF37521C),
  primaryColor: const Color(0xFF37521C),
  inputDecorationTheme: InputDecorationTheme(
    contentPadding: EdgeInsets.only(left: 11, bottom: 10, top: 10, right: 11),
    labelStyle:
        TextStyle(fontFamily: 'Montserrat', fontWeight: FontWeight.w300),
    border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(width: 1)),
    focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(width: 1, color: const Color(0xFF37521C))),
  ),
  textTheme: TextTheme(
      headline1: TextStyle(
        fontFamily: 'Montserrat',
        fontSize: 35,
        fontWeight: FontWeight.w900,
        color: Color(0xFF37521C),
      ),
      headline2: TextStyle(
          fontFamily: 'Montserrat',
          fontSize: 30,
          fontWeight: FontWeight.w900,
          color: Color(0xFF37521C)),
      headline3: TextStyle(
          fontFamily: 'Montserrat',
          fontSize: 25,
          fontWeight: FontWeight.w900,
          color: Color(0xFF37521C)),
      headline4: TextStyle(
          fontFamily: 'Montserrat',
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: Colors.black),
      headline5: TextStyle(
          fontFamily: 'Montserrat',
          fontSize: 15,
          fontWeight: FontWeight.w700,
          color: Colors.black),
      headline6: TextStyle(
          fontFamily: 'Montserrat',
          fontSize: 12,
          fontWeight: FontWeight.w700,
          color: Colors.black),
      subtitle1: TextStyle(
          fontFamily: 'Montserrat',
          fontSize: 15,
          fontWeight: FontWeight.w700,
          color: Colors.black),
      subtitle2: TextStyle(
          fontFamily: 'Montserrat',
          fontSize: 12,
          fontWeight: FontWeight.w700,
          color: Color(0xFFB6B6B6)),
      bodyText1: TextStyle(
          fontFamily: 'Montserrat',
          fontSize: 15,
          fontWeight: FontWeight.w500,
          color: Colors.black),
      bodyText2: TextStyle(
          fontFamily: 'Montserrat',
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: Colors.black),
      button: TextStyle(
          fontFamily: 'Montserrat',
          fontSize: 15,
          fontWeight: FontWeight.w700,
          color: Colors.black)),
  // textTheme:
);

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}
