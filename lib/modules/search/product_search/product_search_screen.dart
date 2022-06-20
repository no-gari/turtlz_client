import 'package:turtlz/modules/search/product_search/cubit/product_search_cubit.dart';
import 'package:turtlz/repositories/search_repository/src/search_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:vrouter/vrouter.dart';
import 'product_search_page.dart';

class ProductSearchScreen extends StatefulWidget {
  static String routeName = '/product_search_screen';

  @override
  _ProductSearchScreenState createState() => _ProductSearchScreenState();
}

class _ProductSearchScreenState extends State<ProductSearchScreen> {
  @override
  Widget build(BuildContext context) {
    final keyword = context.vRouter.pathParameters['keyword'];

    return MultiBlocProvider(providers: [
      BlocProvider(
          create: (_) => ProductSearchCubit(
              RepositoryProvider.of<SearchRepository>(context)))
    ], child: ProductSearchPage(keyword: keyword));
  }
}
