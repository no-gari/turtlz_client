import 'package:turtlz/modules/productList/view/product_list_screen.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart' as Svg;
import 'package:turtlz/support/base_component/company_info.dart';
import 'package:flutter_swiper_plus/flutter_swiper_plus.dart';
import 'package:turtlz/modules/store/cubit/store_cubit.dart';
import 'package:turtlz/support/style/format_unit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
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
                        IconButton(
                            onPressed: () {},
                            icon: ImageIcon(Svg.Svg("assets/icons/noti.svg"),
                                color: Theme.of(context).primaryColor))
                      ]),
                  const SizedBox(height: 10),
                  // Text('events.',
                  //     style: Theme.of(context)
                  //         .textTheme
                  //         .headline4!
                  //         .copyWith(color: Theme.of(context).primaryColor)),
                  // const Text('어디에도 없는 터틀즈 만의 혜택'),
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
                          // control: new SwiperControl(
                          //   color: Color(0xff38547C),
                          // ),
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
                          Text('#NEW')
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
                          Text('#불멍')
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
                            Text('#감성캠핑')
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
                              Text('#무료배송')
                            ]))
                      ]),
                  SizedBox(height: 20),
                  Text('실시간 BEST 10',
                      style: Theme.of(context).textTheme.headline4),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('오늘의 신규 상품',
                                style: Theme.of(context).textTheme.headline4),
                            Text('따끈따끈한 신상 한 눈에 모아보기'),
                          ]),
                      Text('더보기')
                    ],
                  ),
                  SizedBox(height: 20),
                  Text("놓쳐서는 안되는 MD's PICK",
                      style: Theme.of(context).textTheme.headline4),
                  Text('캠핑 횟수 100회 이상 터틀즈 MD가 엄선한 제품들'),
                  SizedBox(height: 20),
                  Text('기획전 모음집', style: Theme.of(context).textTheme.headline4),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('오늘의 신규 상품',
                                style: Theme.of(context).textTheme.headline4),
                            Text('따끈따끈한 신상 한 눈에 모아보기'),
                          ]),
                      Text('더보기')
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            RichText(
                                text: TextSpan(
                                    style:
                                        Theme.of(context).textTheme.headline4,
                                    children: [
                                  TextSpan(text: '텐트 인테리어는\n'),
                                  TextSpan(text: '내가 책임진다')
                                ])),
                            RichText(
                                text: TextSpan(
                                    style:
                                        Theme.of(context).textTheme.bodyText2,
                                    children: [
                                  TextSpan(text: '텐트가 준비 되었다면\n'),
                                  TextSpan(text: '다음은 저희가 책임질게요')
                                ])),
                          ],
                        ),
                        Text('더보기')
                      ]),
                  SizedBox(height: 20),
                  RichText(
                      text: TextSpan(
                          style: Theme.of(context).textTheme.headline4,
                          children: [
                        TextSpan(text: '지금 캠퍼들은?\n'),
                        TextSpan(text: '이런 상품들을 보고 있어요')
                      ])),
                  Text('고민될 땐, 다른 캠퍼들이 탐내는 상품을 살펴보아요.'),
                  CompanyInfo()
                ]))));
  }
}
