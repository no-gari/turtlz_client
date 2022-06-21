import 'package:turtlz/modules/authentication/bloc/authentication_bloc.dart';
import 'package:turtlz/modules/menu/view/menu_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class ProductListScreen extends StatefulWidget {
  static String routeName = '/product_list_screen';

  @override
  _ProductListScreenState createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
        value: BlocProvider.of<AuthenticationBloc>(context),
        child: MultiBlocProvider(providers: [
          // BlocProvider<StoreCubit>(StoreCubit
          //     create: (_) =>
          //         StoreCubit(RepositoryProvider.of<StoreRepository>(context))),
          // BlocProvider<BrandCubit>(
          //     create: (_) =>
          //         BrandCubit(RepositoryProvider.of<BrandRepository>(context)))
        ], child: MenuPage()));
  }
}
