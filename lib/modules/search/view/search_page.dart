import 'package:turtlz/repositories/authentication_repository/authentication_repository.dart';
import 'package:turtlz/modules/authentication/bloc/authentication_bloc.dart';
import 'package:turtlz/support/base_component/company_info.dart';
import 'package:turtlz/support/base_component/login_needed.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:turtlz/modules/search/cubit/search_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:vrouter/vrouter.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _textEditingController = TextEditingController();

  late SearchCubit _searchCubit;

  @override
  void initState() {
    super.initState();
    _searchCubit = BlocProvider.of<SearchCubit>(context);
    _searchCubit.getKeywords();
  }

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
                                  icon: ImageIcon(Svg("assets/icons/noti.svg"),
                                      color: Theme.of(context).primaryColor))
                            ]),
                        const SizedBox(height: 20),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextField(
                                  textInputAction: TextInputAction.go,
                                  onSubmitted: (value) {
                                    if (value.trim() != '') {
                                      context.vRouter.toNamed('/search_result',
                                          pathParameters: {
                                            'keyword':
                                                _textEditingController.text
                                          });
                                      _textEditingController.clear();
                                    }
                                  },
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
                                        icon: const Icon(Icons.clear),
                                        color: Colors.black,
                                        onPressed: () =>
                                            _textEditingController.clear(),
                                      ))),
                              const SizedBox(height: 30),
                              Text('추천 검색어',
                                  style: Theme.of(context).textTheme.headline4),
                              const SizedBox(height: 10),
                              BlocBuilder<SearchCubit, SearchState>(
                                  builder: (context, state) {
                                if (state.isLoaded == true) {
                                  return Column(children: [
                                    if (state.keywords != null &&
                                        state.keywords!.isNotEmpty)
                                      for (var i = 0;
                                          i < state.keywords!.length;
                                          i++)
                                        ListTile(
                                            onTap: () {
                                              context.vRouter.toNamed(
                                                  '/search_result',
                                                  pathParameters: {
                                                    'keyword': state
                                                        .keywords![i].keywords!
                                                  });
                                            },
                                            leading: Text((i + 1).toString(),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline4),
                                            title: Text(
                                                state.keywords![i].keywords!,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline5))
                                  ]);
                                }
                                return Container(color: Colors.transparent);
                              })
                            ])
                      ]))));
    });
  }
}
