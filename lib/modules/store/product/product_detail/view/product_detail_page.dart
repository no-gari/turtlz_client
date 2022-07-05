import 'package:turtlz/modules/store/product/product_detail/components/product_sale_bottom_navigator.dart';
import 'package:turtlz/repositories/authentication_repository/authentication_repository.dart';
import 'package:turtlz/modules/authentication/bloc/authentication_bloc.dart';
import 'package:turtlz/repositories/product_repository/models/product.dart';
import 'package:turtlz/modules/store/product/cubit/product_cubit.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:wrapped_korean_text/wrapped_korean_text.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:turtlz/support/style/format_unit.dart';
import 'package:turtlz/support/style/theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter/material.dart';

class ProductDetailPage extends StatefulWidget {
  ProductDetailPage({this.productId});

  final String? productId;

  @override
  State<StatefulWidget> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage>
    with SingleTickerProviderStateMixin {
  String get _productId => this.widget.productId!;
  bool _result = true;
  late ProductCubit _productCubit;
  late Product product;
  late FeedTemplate defaultFeed;

  @override
  void initState() async {
    super.initState();
    _productCubit = BlocProvider.of<ProductCubit>(context);
    _productCubit.getProductDetail(_productId).whenComplete(() {
      product = _productCubit.state.products!.first;
    });
    // _result = await LinkClient.instance.isKakaoLinkAvailable();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, authState) {
      return BlocBuilder<ProductCubit, ProductState>(builder: (context, state) {
        if (state.isLoaded) {
          setState(() {
            defaultFeed = FeedTemplate(
                content: Content(
                  title: product.name!,
                  imageUrl: Uri.parse(product.thumbnail!),
                  link: Link(
                      webUrl: Uri.parse('https://developers.kakao.com'),
                      mobileWebUrl: Uri.parse('https://developers.kakao.com')),
                ),
                buttons: [
                  Button(
                      title: '앱으로보기',
                      link: Link(androidExecutionParams: {
                        'key1': 'value1',
                        'key2': 'value2'
                      }, iosExecutionParams: {
                        'key1': 'value1',
                        'key2': 'value2'
                      }))
                ]);
          });
        }

        return Scaffold(
            // floatingActionButton: state.isLoaded
            //     ? FloatingActionButton(
            //         onPressed: () async {
            //           if (_result == true) {
            //             Uri uri = await LinkClient.instance
            //                 .defaultTemplate(template: defaultFeed);
            //             await LinkClient.instance.launchKakaoTalk(uri);
            //           } else {
            //             Uri uri = await WebSharerClient.instance
            //                 .defaultTemplateUri(template: defaultFeed);
            //             await launchBrowserTab(uri);
            //           }
            //         },
            //         child: const Icon(Icons.ios_share_outlined))
            //     : null,
            bottomNavigationBar: productSaleBottomNavigator(
                context,
                _productCubit,
                authState.status == AuthenticationStatus.authenticated),
            body: state.isLoaded == true ? bodyWidget(context) : Container());
      });
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
        floating: false,
        snap: false,
        toolbarHeight: maxWidth(context),
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        flexibleSpace: FlexibleSpaceBar(
            background:
                Stack(fit: StackFit.expand, clipBehavior: Clip.none, children: [
          Image.network(product.thumbnail!,
              fit: BoxFit.cover,
              height: maxWidth(context),
              width: maxWidth(context)),
          Positioned(
              height: 100,
              width: maxWidth(context),
              bottom: 0,
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
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(children: [
                          Text("${product.brand!.name}",
                              style: theme.textTheme.headline5)
                        ]),
                        const SizedBox(height: 10),
                        WrappedKoreanText("${product.name}",
                            style: theme.textTheme.headline5),
                        if (product.summary != '') const SizedBox(height: 3),
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
          Positioned(
            left: 0,
            top: 0,
            child: Container(
                padding: EdgeInsets.symmetric(
                    vertical: AppBar().preferredSize.height, horizontal: 18),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                          child: const Icon(Icons.arrow_back_ios_outlined,
                              color: Colors.black),
                          onTap: () => Navigator.pop(context))
                    ])),
          )
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
