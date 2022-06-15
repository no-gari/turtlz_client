import 'package:turtlz/repositories/authentication_repository/authentication_repository.dart';
import 'package:turtlz/modules/authentication/bloc/authentication_bloc.dart';
import 'package:turtlz/support/base_component/login_needed.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyPageScreen extends StatefulWidget {
  static String routeName = '/home_screen';

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => MyPageScreen());
  }

  @override
  State<MyPageScreen> createState() => _MyPageScreen();
}

class _MyPageScreen extends State<MyPageScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
      if (state.status == AuthenticationStatus.authenticated) {
        return Scaffold(
            body: Center(
                child: Column(children: [
          SizedBox(height: 300),
          Text(state.user.nickname.toString()),
          CircleAvatar(
              backgroundImage:
                  NetworkImage(state.user.profileImage.toString())),
          Text(state.user.points.toString()),
          CupertinoButton(
              child: Text('로그아웃'),
              onPressed: () =>
                  RepositoryProvider.of<AuthenticationRepository>(context)
                      .logOut())
        ])));
      }
      return Center(
          child: CupertinoButton(
              color: Colors.black,
              onPressed: () => showLoginNeededDialog(context),
              child: Text('로그인')));
    });
  }
}
