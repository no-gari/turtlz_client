import 'package:turtlz/modules/menu/view/menu_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class MenuScreen extends StatefulWidget {
  static String routeName = '/home_screen';

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => MenuScreen());
  }

  @override
  State<MenuScreen> createState() => _MenuScreen();
}

class _MenuScreen extends State<MenuScreen> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return MenuPage();
  }
}
