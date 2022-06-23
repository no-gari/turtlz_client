import 'package:turtlz/repositories/store_repository/src/store_repository.dart';
import 'package:turtlz/modules/authentication/bloc/authentication_bloc.dart';
import 'package:turtlz/modules/productList/view/product_list_page.dart';
import 'package:turtlz/modules/store/cubit/store_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class ProductListScreen extends StatefulWidget {
  static String routeName = '/product_list_screen';

  ProductListScreen({this.collectionId, this.collectionName});

  final String? collectionId;
  final String? collectionName;

  @override
  _ProductListScreenState createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
        value: BlocProvider.of<AuthenticationBloc>(context),
        child: MultiBlocProvider(providers: [
          BlocProvider<StoreCubit>(
              create: (_) =>
                  StoreCubit(RepositoryProvider.of<StoreRepository>(context))),
        ], child: ProductListPage(collectionId: widget.collectionId, collectionName: widget.collectionName)));
  }
}
