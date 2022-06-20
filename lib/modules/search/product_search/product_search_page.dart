import 'package:turtlz/modules/search/product_search/cubit/product_search_cubit.dart';
import 'package:turtlz/repositories/product_repository/models/product.dart';
import 'package:turtlz/modules/store/components/store_product_widget.dart';
import 'package:turtlz/repositories/product_repository/models/brand.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class ProductSearchPage extends StatefulWidget {
  ProductSearchPage({this.keyword});

  final String? keyword;

  @override
  _ProductSearchPageState createState() => _ProductSearchPageState();
}

class _ProductSearchPageState extends State<ProductSearchPage> {
  late ProductSearchCubit _productSearchCubit;
  int _page = 1;

  @override
  void initState() {
    super.initState();
    _productSearchCubit = BlocProvider.of<ProductSearchCubit>(context);
    _productSearchCubit.productSearch(widget.keyword!, _page);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: true,
            title: Text('상품 / ${widget.keyword.toString()}',
                style: Theme.of(context).textTheme.headline5)),
        body: SafeArea(
            child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: BlocBuilder<ProductSearchCubit, ProductSearchState>(
                    builder: (context, state) {
                  if (state.isLoaded) {
                    List<Product> productList = List<Product>.from(
                        state.products!.map((model) => Product(
                            Id: model['Id'],
                            name: model['name'],
                            rating: model['rating'],
                            originalPrice: model['originalPrice'],
                            discountPrice: model['discountPrice'],
                            discountRate: model['discountRate'],
                            thumbnail: model['thumbnail'],
                            brand: Brand(name: model['brand']))));

                    return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (productList.isNotEmpty) Container(height: 20),
                          if (productList.isNotEmpty)
                            GridView.count(
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
                        ]);
                  }
                  return Center(
                      child: Image.asset('assets/images/indicator.gif',
                          width: 100, height: 100));
                }))));
  }
}
