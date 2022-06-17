import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:flutter/material.dart';
import 'package:turtlz/modules/authentication/bloc/authentication_bloc.dart';
import 'package:turtlz/repositories/authentication_repository/authentication_repository.dart';
import 'package:turtlz/support/base_component/login_needed.dart';
import 'package:vrouter/vrouter.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _textEditingController = TextEditingController();

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
      return Scaffold(
          body: SafeArea(
              child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('search.',
                                  style: Theme.of(context).textTheme.headline3),
                              IconButton(
                                  onPressed: () => state.status ==
                                          AuthenticationStatus.authenticated
                                      ? context.vRouter.toNamed('/notification')
                                      : showSocialLoginNeededDialog(context),
                                  icon: const ImageIcon(
                                      Svg("assets/icons/noti.svg")))
                            ]),
                        const SizedBox(height: 20),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextField(
                                  textInputAction: TextInputAction.search,
                                  autofocus: true,
                                  controller: _textEditingController,
                                  decoration: InputDecoration(
                                      enabledBorder: const UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.black)),
                                      focusedBorder: const UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.black)),
                                      border: const UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.black)),
                                      hintText: '브랜드 혹은 상품을 검색하세요.',
                                      suffixIcon: IconButton(
                                        icon: Icon(Icons.clear),
                                        color: Colors.black,
                                        onPressed: () =>
                                            _textEditingController.clear(),
                                      ))),
                              SizedBox(height: 30),
                              Text('최근 검색어',
                                  style: Theme.of(context).textTheme.headline4),
                              SizedBox(height: 10),
                              Column(children: [
                                ListTile(
                                    title: Text('캠박'),
                                    trailing: Icon(Icons.clear)),
                                ListTile(
                                    title: Text('캠박'),
                                    trailing: Icon(Icons.clear)),
                                ListTile(
                                    title: Text('캠박'),
                                    trailing: Icon(Icons.clear)),
                                ListTile(
                                    title: Text('캠박'),
                                    trailing: Icon(Icons.clear)),
                              ])
                            ])
                      ]))));
    });
  }
}
