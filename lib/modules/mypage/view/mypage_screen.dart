import 'package:turtlz/modules/authentication/bloc/authentication_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'mypage_page.dart';

class MyMyPageScreen extends StatefulWidget {
  static String routeName = '/my_page_screen';

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => MyMyPageScreen());
  }

  @override
  State<MyMyPageScreen> createState() => _MyMyPageScreen();
}

class _MyMyPageScreen extends State<MyMyPageScreen> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.dark));

    return BlocProvider.value(
        value: BlocProvider.of<AuthenticationBloc>(context),
        child: Scaffold(
            backgroundColor: Colors.black,
            body: SafeArea(child: SingleChildScrollView(child: MyPage()))));
  }
}
