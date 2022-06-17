import 'package:turtlz/repositories/notification_repository/src/notification_repository.dart';
import 'package:turtlz/modules/search/search_result/cubit/search_result_cubit.dart';
import 'package:turtlz/repositories/search_repository/src/search_repository.dart';
import 'package:turtlz/modules/authentication/bloc/authentication_bloc.dart';
import 'package:turtlz/modules/notification/cubit/notification_cubit.dart';
import 'package:turtlz/modules/search/search/view/search_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  static String routeName = '/search_screen';

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
        value: BlocProvider.of<AuthenticationBloc>(context),
        child: MultiBlocProvider(providers: [
          BlocProvider<NotificationCubit>(
              create: (_) => NotificationCubit(
                  RepositoryProvider.of<NotificationRepository>(context))),
          BlocProvider<SearchResultCubit>(
              create: (_) => SearchResultCubit(
                  RepositoryProvider.of<SearchRepository>(context)))
        ], child: SearchPage()));
  }
}
