import 'package:turtlz/repositories/brand_repository/src/brand_repository.dart';
import 'package:turtlz/modules/brands/brand_home/cubit/brand_cubit.dart';
import 'package:turtlz/modules/brands/brand_home/view/brand_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class BrandScreen extends StatefulWidget {
  static String routeName = 'brand_screen';

  @override
  _BrandScreenState createState() => _BrandScreenState();
}

class _BrandScreenState extends State<BrandScreen> {
  @override
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(
          create: (context) =>
              BrandCubit(RepositoryProvider.of<BrandRepository>(context))),
    ], child: BrandPage());
  }
}
