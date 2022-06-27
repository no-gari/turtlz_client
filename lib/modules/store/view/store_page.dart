import 'package:turtlz/repositories/authentication_repository/src/authentication_repository.dart';
import 'package:turtlz/modules/authentication/bloc/authentication_bloc.dart';
import 'package:turtlz/modules/productList/view/product_list_screen.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart' as Svg;
import 'package:turtlz/support/base_component/company_info.dart';
import 'package:turtlz/support/base_component/login_needed.dart';
import 'package:flutter_swiper_plus/flutter_swiper_plus.dart';
import 'package:turtlz/modules/store/cubit/store_cubit.dart';
import 'package:turtlz/support/style/format_unit.dart';
import 'package:turtlz/support/style/theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vrouter/vrouter.dart';

class StorePage extends StatefulWidget {
  @override
  _StorePageState createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {
  late StoreCubit _storeCubit;

  @override
  void initState() {
    super.initState();
    _storeCubit = BlocProvider.of<StoreCubit>(context);
    _storeCubit.getCollections();
    _storeCubit.getSubCollection();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocBuilder<StoreCubit, StoreState>(builder: (context, state) {
      if (state.isLoaded) {
        return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SafeArea(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SvgPicture.asset("assets/images/turtlz.svg",
                            width: 100),
                        BlocBuilder<AuthenticationBloc, AuthenticationState>(
                            builder: (context, state) {
                          return IconButton(
                              onPressed: () {},
                              icon: const ImageIcon(
                                  Svg.Svg("assets/icons/noti.svg"),
                                  color: Colors.white));
                        })
                      ]),
                  const SizedBox(height: 10),
                  SizedBox(
                      height: (maxWidth(context) - 40) * 1131 / 1252,
                      width: double.maxFinite,
                      child: Swiper(
                          autoplay: false,
                          pagination: SwiperPagination(
                              alignment: Alignment.bottomCenter,
                              builder: DotSwiperPaginationBuilder(
                                  color: Colors.black54,
                                  activeColor: Theme.of(context).primaryColor)),
                          scrollDirection: Axis.horizontal,
                          onTap: (int index) {},
                          itemBuilder: (BuildContext context, int index) =>
                              Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.grey)),
                          itemCount: 5)),
                  const SizedBox(height: 20),
                  Row(
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
                          SizedBox(height: 5),
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
                              child: Image.asset('assets/images/fire.png'),
                            ),
                          ),
                          SizedBox(height: 5),
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
                              child: Image.asset('assets/images/sensible.png'),
                            ),
                            SizedBox(height: 5),
                            Text('#감성캠핑', style: theme.textTheme.headline6)
                          ]),
                        ),
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
                                child:
                                    Image.asset('assets/images/shipping.png'),
                              ),
                              SizedBox(height: 5),
                              Text('#무료배송', style: theme.textTheme.headline6)
                            ]))
                      ]),
                  SizedBox(height: 20),
                  CompanyInfo()
                ])));
      } else {
        return Center(
            child: Image.asset('assets/images/indicator.gif',
                width: 100, height: 100));
      }
    }));
  }
}
