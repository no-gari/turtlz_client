import 'package:turtlz/repositories/store_repository/src/store_repository.dart';
import 'package:turtlz/repositories/brand_repository/src/brand_repository.dart';
import 'package:turtlz/modules/authentication/bloc/authentication_bloc.dart';
import 'package:turtlz/modules/brands/brand_home/cubit/brand_cubit.dart';
import 'package:turtlz/modules/store/cubit/store_cubit.dart';
import 'package:turtlz/modules/menu/view/menu_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class MenuScreen extends StatefulWidget {
  static String routeName = '/home_screen';

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => MenuScreen());
  }

  @override
  State<MenuScreen> createState() => _MenuScreen();
}

class _MenuScreen extends State<MenuScreen> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
        value: BlocProvider.of<AuthenticationBloc>(context),
        child: MultiBlocProvider(providers: [
          BlocProvider<StoreCubit>(
              create: (_) =>
                  StoreCubit(RepositoryProvider.of<StoreRepository>(context))),
          BlocProvider<BrandCubit>(
              create: (_) =>
                  BrandCubit(RepositoryProvider.of<BrandRepository>(context)))
        ], child: MenuPage()));
  }
}
