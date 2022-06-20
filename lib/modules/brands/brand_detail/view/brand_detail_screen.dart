import 'package:turtlz/modules/brands/brand_detail/cubit/brand_detail_cubit.dart';
import 'package:turtlz/modules/brands/brand_detail/view/brand_detail_page.dart';
import 'package:turtlz/repositories/brand_repository/src/brand_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:vrouter/vrouter.dart';

class BrandDetailScreen extends StatefulWidget {
  static String routeName = '/brand_detail_screen';

  @override
  _BrandDetailScreenState createState() => _BrandDetailScreenState();
}

class _BrandDetailScreenState extends State<BrandDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final Id = context.vRouter.pathParameters['Id'];

    return MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) => BrandDetailCubit(
                  RepositoryProvider.of<BrandRepository>(context)))
        ],
        child: Scaffold(
            appBar: AppBar(automaticallyImplyLeading: true),
            body: BrandDetailPage(Id: Id)));
  }
}
