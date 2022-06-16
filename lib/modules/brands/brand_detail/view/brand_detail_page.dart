import 'package:turtlz/modules/brands/brand_detail/cubit/brand_detail_cubit.dart';
import 'package:turtlz/modules/store/components/store_product_widget.dart';
import 'package:turtlz/repositories/product_repository/models/brand.dart';
import 'package:turtlz/repositories/product_repository/models/product.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class BrandDetailPage extends StatefulWidget {
  BrandDetailPage({@required this.Id});

  final String? Id;

  @override
  _BrandDetailPageState createState() => _BrandDetailPageState();
}

class _BrandDetailPageState extends State<BrandDetailPage> {
  late BrandDetailCubit _brandDetailCubit;

  @override
  void initState() {
    super.initState();
    _brandDetailCubit = BlocProvider.of<BrandDetailCubit>(context);
    _brandDetailCubit.getBrandDetail(widget.Id!);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BrandDetailCubit, BrandDetailState>(
        builder: (context, state) {
      if (state.isLoaded == true) {
        var products = state.products as List;
        List<Product> productList = List<Product>.from(products.map((model) =>
            Product(
                Id: model['Id'],
                name: model['name'],
                rating: model['rating'],
                originalPrice: model['originalPrice'],
                discountPrice: model['discountPrice'],
                discountRate: model['discountRate'],
                thumbnail: model['thumbnail'],
                brand: Brand(name: model['brand']))));

        return SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
              padding: EdgeInsets.only(top: 20, left: 20, right: 20),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                      CircleAvatar(
                          backgroundImage: NetworkImage(state.logo!),
                          radius: 20),
                      SizedBox(width: 10),
                      Text(state.name!,
                          style: Theme.of(context).textTheme.headline5)
                    ]),
                    SizedBox(height: 20),
                    Text(state.description!),
                    Divider(height: Adaptive.h(5))
                  ])),
          Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('PRODUCTS',
                        style: Theme.of(context).textTheme.headline5),
                    SizedBox(height: 20),
                    productList.length != 0
                        ? GridView.count(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            crossAxisCount: 2,
                            crossAxisSpacing: 20,
                            mainAxisSpacing: 15,
                            childAspectRatio: (4 / 7.5),
                            children: List.generate(
                                state.products!.length,
                                (index) =>
                                    storeProduct(context, productList[index])))
                        : Container(
                            color: Colors.white,
                            height: Adaptive.h(20),
                            child: Center(child: Text('아직 등록된 상품이 없습니다.')))
                  ]))
        ]));
      }
      return Center(
          child: Image.asset('assets/images/indicator.gif',
              width: 100, height: 100));
    });
  }
}
