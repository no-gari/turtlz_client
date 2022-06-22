import 'package:turtlz/modules/store/product/product_detail/components/product_sale_bottom_navigator.dart';
import 'package:turtlz/repositories/authentication_repository/authentication_repository.dart';
import 'package:turtlz/modules/brands/brand_detail/view/brand_detail_screen.dart';
import 'package:turtlz/modules/authentication/bloc/authentication_bloc.dart';
import 'package:turtlz/repositories/product_repository/models/product.dart';
import 'package:turtlz/modules/store/product/cubit/product_cubit.dart';
import 'package:turtlz/support/base_component/login_needed.dart';
import 'package:wrapped_korean_text/wrapped_korean_text.dart';
import 'package:turtlz/modules/cart/view/cart_screen.dart';
import 'package:turtlz/support/style/format_unit.dart';
import 'package:turtlz/support/style/theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ProductDetailPage extends StatefulWidget {
  ProductDetailPage({this.productId});

  final String? productId;

  @override
  State<StatefulWidget> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage>
    with SingleTickerProviderStateMixin {
  String get _productId => this.widget.productId!;

  late ProductCubit _productCubit;
  late Product product;

  @override
  void initState() {
    super.initState();
    _productCubit = BlocProvider.of<ProductCubit>(context);

    _productCubit.getProductDetail(_productId).whenComplete(() {
      product = _productCubit.state.products!.first;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
      return Scaffold(
        bottomNavigationBar: productSaleBottomNavigator(context, _productCubit,
            state.status == AuthenticationStatus.authenticated),
        body:
            BlocBuilder<ProductCubit, ProductState>(builder: (context, state) {
          if (state.isLoaded == true) {
            return bodyWidget(context);
          } else {
            return Container();
          }
        }),
        // floatingActionButton: FloatingActionButton(
        //     backgroundColor: theme.primaryColor,
        //     child: SvgPicture.asset("assets/icons/cart.svg",
        //         color: Colors.white),
        //     onPressed: () =>
        //         state.status == AuthenticationStatus.authenticated
        //             ? Navigator.pushNamed(context, CartScreen.routeName)
        //             : showSocialLoginNeededDialog(context))
      );
    });
  }

  CustomScrollView bodyWidget(BuildContext context) {
    return CustomScrollView(slivers: <Widget>[
      appBarWidget(context),
      SliverToBoxAdapter(child: firstPage())
    ]);
  }

  SliverAppBar appBarWidget(BuildContext context) {
    return SliverAppBar(
        automaticallyImplyLeading: false,
        centerTitle: false,
        pinned: false,
        floating: true,
        snap: false,
        toolbarHeight: maxWidth(context),
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        flexibleSpace: FlexibleSpaceBar(
            background: Stack(clipBehavior: Clip.none, children: [
          Image.network(product.thumbnail!,
              fit: BoxFit.cover,
              height: maxWidth(context),
              width: maxWidth(context)),
          Positioned(
              height: 100,
              width: maxWidth(context),
              bottom: 47,
              child: Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: FractionalOffset.topCenter,
                          end: FractionalOffset.bottomCenter,
                          colors: [
                    Colors.white.withOpacity(0),
                    Colors.white.withOpacity(1)
                  ])))),
          Positioned(
              bottom: 0,
              child: Container(
                  width: maxWidth(context),
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                            onTap: () => Navigator.pushNamed(
                                context, BrandDetailScreen.routeName,
                                arguments: {'Id': product.brand!.Id!}),
                            child: Row(children: [
                              Container(
                                  width: 20,
                                  height: 20,
                                  margin: EdgeInsets.only(right: 10),
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                          image: NetworkImage(
                                              product.brand!.url!)))),
                              Text("${product.brand!.name}",
                                  style: theme.textTheme.headline5)
                            ])),
                        const SizedBox(height: 10),
                        WrappedKoreanText("${product.name}",
                            style: theme.textTheme.headline5),
                        if (product.summary != '') SizedBox(height: 3),
                        if (product.summary != '')
                          WrappedKoreanText("${product.summary}"),
                        Align(
                            alignment: Alignment.bottomRight,
                            child: Text(
                                '${currencyFromString(product.discountPrice.toString())}',
                                style: Theme.of(context)
                                    .textTheme
                                    .headline4!
                                    .copyWith(color: theme.primaryColor)))
                      ]))),
          Container(
              padding: EdgeInsets.symmetric(
                  vertical: AppBar().preferredSize.height, horizontal: 18),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                        child: Icon(Icons.arrow_back_ios_outlined,
                            color: Colors.black54),
                        onTap: () => Navigator.pop(context))
                  ]))
        ])));
  }

  Column firstPage() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const SizedBox(height: 20),
      Html(data: product.description, shrinkWrap: true, customImageRenders: {
        networkSourceMatcher(): networkImageRender(
            loadingWidget: () =>
                Container(color: Theme.of(context).scaffoldBackgroundColor))
      })
    ]);
  }
}
