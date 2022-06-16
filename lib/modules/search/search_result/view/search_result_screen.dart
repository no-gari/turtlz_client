import 'package:turtlz/modules/search/search_result/cubit/search_result_cubit.dart';
import 'package:turtlz/modules/search/search_result/view/search_result_page.dart';
import 'package:turtlz/repositories/search_repository/src/search_repository.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class SearchResultScreen extends StatefulWidget {
  static String routeName = '/search_result_screen';

  @override
  _SearchResultScreenState createState() => _SearchResultScreenState();
}

class _SearchResultScreenState extends State<SearchResultScreen> {
  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments as Map;
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);

    return MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) => SearchResultCubit(
                  RepositoryProvider.of<SearchRepository>(context)))
        ],
        child: Scaffold(
            appBar: AppBar(
                elevation: 0,
                backgroundColor: Colors.white,
                automaticallyImplyLeading: true,
                iconTheme: IconThemeData(color: Colors.black)),
            body: SearchResultPage(keyword: arguments['keyword'])));
  }
}
