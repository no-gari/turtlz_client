import 'package:turtlz/modules/store/product/product_detail/view/product_detail_screen.dart';
import 'package:turtlz/repositories/authentication_repository/authentication_repository.dart';
import 'package:turtlz/modules/authentication/bloc/authentication_bloc.dart';
import 'package:turtlz/modules/productList/view/product_list_screen.dart';
import 'package:turtlz/repositories/product_repository/models/brand.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart' as Svg;
import '../../../repositories/product_repository/models/product.dart';
import 'package:turtlz/support/base_component/login_needed.dart';
import 'package:turtlz/support/base_component/company_info.dart';
import 'package:flutter_swiper_plus/flutter_swiper_plus.dart';
import 'package:turtlz/modules/store/cubit/store_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:turtlz/support/style/format_unit.dart';
import 'package:turtlz/support/style/theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class StorePage extends StatefulWidget {
  @override
  _StorePageState createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {
  late StoreCubit _storeCubit;
  final productList = [];

  @override
  void initState() {
    super.initState();
    _storeCubit = BlocProvider.of<StoreCubit>(context);
    _storeCubit.getCollections();
    _storeCubit.getSubCollection();
    _storeCubit.getMainCollection();
    _storeCubit.getPopupCollection();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocBuilder<StoreCubit, StoreState>(builder: (context, state) {
      if (state.isLoaded &&
          state.popupCollections != null &&
          state.popupCollections!.isNotEmpty) {
        Future.delayed(
            Duration.zero,
            () => showDialogIfFirstLoaded(
                context,
                state.popupCollections![0].thumbnail,
                state.popupCollections![0].Id));
      }

      if (state.isLoaded) {
        return SingleChildScrollView(
            child: SafeArea(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SvgPicture.asset("assets/images/turtlz.svg",
                            width: 100),
                        IconButton(
                            onPressed: () {},
                            icon: const ImageIcon(
                                Svg.Svg("assets/icons/noti.svg"),
                                color: Colors.white))
                      ])),
              const SizedBox(height: 10),
              BlocBuilder<AuthenticationBloc, AuthenticationState>(
                  builder: (context, state) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: SizedBox(
                      height: (maxWidth(context) - 40) * 1131 / 1252,
                      width: double.maxFinite,
                      child: Swiper(
                          autoplay: false,
                          pagination: const SwiperPagination(
                              alignment: Alignment.bottomCenter,
                              builder: DotSwiperPaginationBuilder(
                                  color: Colors.black54,
                                  activeColor: Colors.white)),
                          scrollDirection: Axis.horizontal,
                          onTap: (int index) {
                            if (index == 0) {
                              state.status == AuthenticationStatus.authenticated
                                  ? Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ProductListScreen(
                                                  collectionId: '',
                                                  collectionName: '전체보기',
                                                  thumbnail: '')))
                                  : showSocialLoginNeededDialog(context);
                            } else {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ProductListScreen(
                                          collectionId: '',
                                          collectionName: '전체보기',
                                          thumbnail: '')));
                            }
                          },
                          itemBuilder: (BuildContext context, int index) =>
                              ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.asset(
                                      'assets/images/main_page_${index + 1}.png')),
                          itemCount: 2)),
                );
              }),
              const SizedBox(height: 20),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(children: [
                          GestureDetector(
                              onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ProductListScreen(
                                          collectionId: '',
                                          collectionName: '전체보기',
                                          thumbnail: ''))),
                              child: CircleAvatar(
                                  backgroundColor: Colors.transparent,
                                  radius: maxWidth(context) * 0.08,
                                  child: Image.asset(
                                      'assets/images/new_products.png'))),
                          const SizedBox(height: 5),
                          Text('#NEW', style: theme.textTheme.headline6)
                        ]),
                        Column(children: [
                          GestureDetector(
                              onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ProductListScreen(
                                          collectionId: 'CSQMZK7U8WGE',
                                          collectionName: '화로/스토브',
                                          thumbnail:
                                              'https://cdn.clayful.io/stores/ZCJ4P8CZH2UR.GZ5QLVHQY5XQ/images/2VAYYENZ27FT/v1/Ellipse_63.png'))),
                              child: CircleAvatar(
                                  backgroundColor: Colors.transparent,
                                  radius: maxWidth(context) * 0.08,
                                  child:
                                      Image.asset('assets/images/fire.png'))),
                          const SizedBox(height: 5),
                          Text('#불멍', style: theme.textTheme.headline6)
                        ]),
                        GestureDetector(
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ProductListScreen(
                                        collectionId: 'VWLAH5XCDFSY',
                                        collectionName: '캠핑소품',
                                        thumbnail:
                                            'https://cdn.clayful.io/stores/ZCJ4P8CZH2UR.GZ5QLVHQY5XQ/images/G2DQQG53PD3G/v1/Ellipse_61.png'))),
                            child: Column(children: [
                              CircleAvatar(
                                backgroundColor: Colors.transparent,
                                radius: maxWidth(context) * 0.08,
                                child:
                                    Image.asset('assets/images/sensible.png'),
                              ),
                              const SizedBox(height: 5),
                              Text('#감성캠핑', style: theme.textTheme.headline6)
                            ])),
                        GestureDetector(
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ProductListScreen(
                                        collectionId: '',
                                        collectionName: '전체보기',
                                        thumbnail: ''))),
                            child: Column(children: [
                              CircleAvatar(
                                  backgroundColor: Colors.transparent,
                                  radius: maxWidth(context) * 0.08,
                                  child: Image.asset(
                                      'assets/images/shipping.png')),
                              const SizedBox(height: 5),
                              Text('#무료배송', style: theme.textTheme.headline6)
                            ]))
                      ])),
              const SizedBox(height: 20),
              BlocBuilder<StoreCubit, StoreState>(builder: (context, state) {
                if (state.isLoaded == true && state.mainCollections != null) {
                  for (var i = 0; i < state.mainCollections!.length; i++) {
                    List<Product> newProductList = List<Product>.from(state
                        .mainCollections![i]['products']
                        .map((model) => Product(
                            Id: model['Id'],
                            name: model['name'],
                            rating: model['rating'],
                            originalPrice: model['originalPrice'],
                            discountPrice: model['discountPrice'],
                            discountRate: model['discountRate'],
                            thumbnail: model['thumbnail'],
                            brand: Brand(name: model['brand']))));
                    productList.add(newProductList);
                  }

                  return ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.all(0),
                    itemCount: productList.length,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                          height: 350,
                          padding: const EdgeInsets.only(left: 20),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: 10),
                                      Text(
                                          state.mainCollections![index]
                                              ['collection']['name'],
                                          style: theme.textTheme.headline5),
                                      const SizedBox(height: 10)
                                    ]),
                                SizedBox(
                                    height: 300,
                                    child: SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Wrap(
                                            direction: Axis.horizontal,
                                            spacing: 30,
                                            children: List.generate(
                                                productList[index].length,
                                                (newIndex) => Container(
                                                    width: 175,
                                                    child: collectionProduct(
                                                        context,
                                                        productList[index]
                                                            [newIndex]))))))
                              ]));
                    },
                  );
                }
                return Container();
              }),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: CompanyInfo(),
              )
            ])));
      } else {
        return Center(
            child: Image.asset('assets/images/indicator.gif',
                width: 100, height: 100));
      }
    }));
  }
}

Widget collectionProduct(BuildContext context, Product product) {
  return GestureDetector(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  ProductDetailScreen(productId: product.Id))),
      child: Column(children: [
        ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(product.thumbnail!,
                fit: BoxFit.cover, height: (maxWidth(context) - 45) / 2)),
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              RichText(
                  text: TextSpan(children: [
                WidgetSpan(
                    child: Text("${product.brand!.name}",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2!
                            .copyWith(fontWeight: FontWeight.bold),
                        maxLines: 1)),
                TextSpan(text: "\n", style: theme.textTheme.subtitle1),
                WidgetSpan(
                    child: Text("${product.name}",
                        style: theme.textTheme.subtitle1!
                            .copyWith(fontWeight: FontWeight.w500),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis))
              ])),
              const SizedBox(height: 5),
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
      ]));
}

showDialogIfFirstLoaded(BuildContext context, String? url, String? id) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool? isFirstLoaded = prefs.getBool('keyIsFirstLoaded');
  if (isFirstLoaded == null) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              elevation: 0,
              contentPadding: const EdgeInsets.all(0),
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(32.0))),
              content: GestureDetector(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              ProductDetailScreen(productId: id!))),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(32),
                      child: Image.network(url!))),
              actions: <Widget>[
                MaterialButton(
                    child: const Text("다시는 이 창을 보지 않습니다."),
                    onPressed: () {
                      prefs.setBool('keyIsFirstLoaded', false);
                      Navigator.of(context).pop();
                    })
              ]);
        });
  }
}
