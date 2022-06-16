import 'package:turtlz/modules/store/product/product_detail/view/product_detail_page.dart';
import 'package:turtlz/modules/brands/brand_detail/cubit/brand_detail_cubit.dart';
import 'package:turtlz/repositories/brand_repository/src/brand_repository.dart';
import 'package:turtlz/repositories/product_repository/product_repository.dart';
import 'package:turtlz/modules/authentication/bloc/authentication_bloc.dart';
import 'package:turtlz/repositories/product_repository/models/product.dart';
import 'package:turtlz/modules/store/product/cubit/product_cubit.dart';
import 'package:turtlz/support/style/format_unit.dart';
import 'package:turtlz/support/style/theme.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

Widget storeProduct(BuildContext context, Product product) {
  return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => BlocProvider.value(
                      value: BlocProvider.of<AuthenticationBloc>(context),
                      child: MultiBlocProvider(providers: [
                        BlocProvider<ProductCubit>(
                            create: (_) => ProductCubit(
                                RepositoryProvider.of<ProductRepository>(
                                    context))),
                        BlocProvider<BrandDetailCubit>(
                            create: (_) => BrandDetailCubit(
                                RepositoryProvider.of<BrandRepository>(
                                    context)))
                      ], child: ProductDetailPage(product.Id!)),
                    )));
      },
      child: GridTile(
          child: Container(),
          header: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(product.thumbnail!,
                  fit: BoxFit.cover, height: 150)),
          footer: Container(
              height: 100,
              padding:
                  EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                        text: TextSpan(children: [
                      WidgetSpan(
                          child: Text("${product.brand!.name}",
                              style: theme.textTheme.subtitle1!.copyWith(
                                  fontSize: Adaptive.dp(10),
                                  color: Color(0xFF979797)),
                              maxLines: 1)),
                      TextSpan(
                          text: "\n",
                          style: theme.textTheme.subtitle1!
                              .copyWith(fontSize: Adaptive.dp(10))),
                      WidgetSpan(
                          child: Text("${product.name}",
                              style: theme.textTheme.bodyText2,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis))
                    ])),
                    SizedBox(height: Adaptive.dp(5)),
                    RichText(
                        text: TextSpan(children: [
                      TextSpan(
                          text: "${product.discountRate}%\n",
                          style: theme.textTheme.bodyText2!.copyWith(
                              color: theme.accentColor,
                              fontWeight: FontWeight.w700)),
                      WidgetSpan(
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                            Text(
                                "${currencyFromString(product.discountPrice.toString())}\t"),
                            Text(
                                "${currencyFromString(product.originalPrice.toString())}",
                                style: theme.textTheme.bodyText2!.copyWith(
                                    decoration: TextDecoration.lineThrough,
                                    fontSize: Adaptive.dp(8)))
                          ]))
                    ]))
                  ]))));
}
