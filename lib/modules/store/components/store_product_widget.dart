import 'package:turtlz/modules/store/product/product_detail/view/product_detail_screen.dart';
import 'package:turtlz/repositories/product_repository/product_repository.dart';
import 'package:turtlz/repositories/product_repository/models/product.dart';
import 'package:turtlz/support/style/format_unit.dart';
import 'package:turtlz/support/style/theme.dart';
import 'package:flutter/material.dart';

Widget storeProduct(BuildContext context, Product product) {
  return GestureDetector(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  ProductDetailScreen(productId: product.Id))),
      child: GridTile(
          child: Column(children: [
        ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(product.thumbnail!,
                fit: BoxFit.cover, height: 170)),
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              RichText(
                  text: TextSpan(children: [
                WidgetSpan(
                    child: Text("${product.brand!.name}",
                        style: Theme.of(context).textTheme.bodyText2!.copyWith(
                            fontWeight: FontWeight.bold, fontSize: 10),
                        maxLines: 1)),
                TextSpan(text: "\n", style: theme.textTheme.subtitle1),
                WidgetSpan(
                    child: Text("${product.name}",
                        style: theme.textTheme.subtitle2!.copyWith(
                            fontWeight: FontWeight.w500, color: Colors.black),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis))
              ])),
              const SizedBox(height: 3),
              RichText(
                  text: TextSpan(children: [
                TextSpan(
                    text: "${product.discountRate}%\n",
                    style: theme.textTheme.headline5!
                        .copyWith(color: theme.primaryColor)),
                WidgetSpan(
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                      Text(
                          "${currencyFromString(product.discountPrice.toString())}\t",
                          style: Theme.of(context).textTheme.headline5),
                      Text(currencyFromString(product.originalPrice.toString()),
                          style: theme.textTheme.bodyText2!.copyWith(
                              decoration: TextDecoration.lineThrough,
                              fontSize: 10))
                    ]))
              ]))
            ]))
      ])));
}
