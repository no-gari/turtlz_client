import 'package:turtlz/modules/search/brand_search/cubit/brand_search_cubit.dart';
import 'package:turtlz/repositories/search_repository/src/search_repository.dart';
import 'package:turtlz/modules/search/brand_search/brand_search_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:vrouter/vrouter.dart';

class BrandSearchScreen extends StatefulWidget {
  static String routeName = '/Brand_search_screen';

  @override
  _BrandSearchScreenState createState() => _BrandSearchScreenState();
}

class _BrandSearchScreenState extends State<BrandSearchScreen> {
  @override
  Widget build(BuildContext context) {
    final keyword = context.vRouter.pathParameters['keyword'];

    return MultiBlocProvider(providers: [
      BlocProvider(
          create: (_) => BrandSearchCubit(
              RepositoryProvider.of<SearchRepository>(context)))
    ], child: BrandSearchPage(keyword: keyword));
  }
}
