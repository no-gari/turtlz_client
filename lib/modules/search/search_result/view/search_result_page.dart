import 'package:turtlz/modules/search/search_result/cubit/search_result_cubit.dart';
import 'package:turtlz/modules/brands/brand_home/components/brand_list_tile.dart';
import 'package:turtlz/repositories/brand_repository/models/brand_list.dart';
import 'package:turtlz/repositories/product_repository/models/product.dart';
import 'package:turtlz/modules/store/components/store_product_widget.dart';
import 'package:turtlz/repositories/product_repository/models/brand.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:vrouter/vrouter.dart';

class SearchResultPage extends StatefulWidget {
  SearchResultPage({required this.keyword});

  final String keyword;

  @override
  _SearchResultPageState createState() => _SearchResultPageState();
}

class _SearchResultPageState extends State<SearchResultPage> {
  late SearchResultCubit _searchResultCubit;
  int _page = 1;

  @override
  void initState() {
    super.initState();
    _searchResultCubit = BlocProvider.of<SearchResultCubit>(context);
    _searchResultCubit.search(widget.keyword, _page);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: BlocBuilder<SearchResultCubit, SearchResultState>(
            builder: (context, state) {
          if (state.isLoaded == true) {
            var products = state.products as List;
            var brands = state.brands as List;

            List<Product> productList = List<Product>.from(products.map(
                (model) => Product(
                    Id: model['Id'],
                    name: model['name'],
                    rating: model['rating'],
                    originalPrice: model['originalPrice'],
                    discountPrice: model['discountPrice'],
                    discountRate: model['discountRate'],
                    thumbnail: model['thumbnail'],
                    brand: Brand(name: model['brand']))));

            List<BrandList> brandList = List<BrandList>.from(
                brands.map((model) => BrandList(model['Id'], model['name'])));

            return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('brands.', style: Theme.of(context).textTheme.headline3),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('검색하신 브랜드 목록입니다.',
                            style: Theme.of(context).textTheme.headline5),
                        GestureDetector(
                            onTap: () {
                              if (brandList.isNotEmpty) {
                                context.vRouter.toNamed('/search_brand_result',
                                    pathParameters: {
                                      'keyword': widget.keyword
                                    });
                              }
                            },
                            child: Text('더 보기',
                                style: Theme.of(context)
                                    .textTheme
                                    .headline5!
                                    .copyWith(
                                        decoration: TextDecoration.underline)))
                      ]),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (brandList.isNotEmpty)
                          for (var brand in brandList)
                            BrandListTile(Id: brand.Id, name: brand.name),
                        if (brandList.isEmpty)
                          Container(
                              color: Colors.white,
                              height: 100,
                              child:
                                  const Center(child: Text('검색된 브랜드가 없습니다.')))
                      ]),
                  Text('products.',
                      style: Theme.of(context).textTheme.headline3),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('검색하신 상품 목록입니다.',
                            style: Theme.of(context).textTheme.headline5),
                        GestureDetector(
                            onTap: () {
                              if (productList.isNotEmpty) {
                                context.vRouter.toNamed(
                                    '/search_product_result',
                                    pathParameters: {
                                      'keyword': widget.keyword
                                    });
                              }
                            },
                            child: Text('더 보기',
                                style: Theme.of(context)
                                    .textTheme
                                    .headline5!
                                    .copyWith(
                                        decoration: TextDecoration.underline)))
                      ]),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (productList.isNotEmpty) Container(height: 20),
                        productList.isNotEmpty
                            ? GridView.count(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                crossAxisCount: 2,
                                crossAxisSpacing: 5,
                                mainAxisSpacing: 0,
                                childAspectRatio: (4 / 7),
                                children: List.generate(
                                    state.products!.length,
                                    (index) => storeProduct(
                                        context, productList[index])))
                            : Container(
                                color: Colors.white,
                                height: 100,
                                child:
                                    const Center(child: Text('검색된 상품이 없습니다.')))
                      ])
                ]);
          } else {
            return Container(
                color: Colors.white,
                child: Center(
                    child: Image.asset('assets/images/indicator.gif',
                        width: 100, height: 100)));
          }
        }));
  }
}
