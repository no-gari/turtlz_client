import 'package:turtlz/modules/store/product/product_detail/view/product_detail_page.dart';
import 'package:turtlz/repositories/product_repository/src/product_repository.dart';
import 'package:turtlz/modules/brands/brand_detail/cubit/brand_detail_cubit.dart';
import 'package:turtlz/repositories/brand_repository/src/brand_repository.dart';
import 'package:turtlz/modules/authentication/bloc/authentication_bloc.dart';
import 'package:turtlz/modules/store/product/cubit/product_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:vrouter/vrouter.dart';

class ProductDetailScreen extends StatefulWidget {
  static String routeName = '/product_detail_screen';

  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final productId = context.vRouter.pathParameters['productId'];

    return BlocProvider.value(
        value: BlocProvider.of<AuthenticationBloc>(context),
        child: MultiBlocProvider(providers: [
          BlocProvider<ProductCubit>(
              create: (_) => ProductCubit(
                  RepositoryProvider.of<ProductRepository>(context))),
          BlocProvider<BrandDetailCubit>(
              create: (_) => BrandDetailCubit(
                  RepositoryProvider.of<BrandRepository>(context)))
        ], child: ProductDetailPage(productId: productId)));
  }
}
