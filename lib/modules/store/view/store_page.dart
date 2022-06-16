import 'package:flutter_svg_provider/flutter_svg_provider.dart' as Svg;
import 'package:flutter_swiper_plus/flutter_swiper_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:turtlz/support/style/format_unit.dart';

class StorePage extends StatefulWidget {
  @override
  _StorePageState createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20),
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
                  SizedBox(height: 20),
                  Container(
                      height: (maxWidth(context) - 40) * 1131 / 1252,
                      width: double.maxFinite,
                      child: Swiper(
                          autoplay: false,
                          control: SwiperControl(color: Colors.white),
                          scrollDirection: Axis.horizontal,
                          onTap: (int index) {},
                          itemBuilder: (BuildContext context, int index) =>
                              Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.grey)),
                          itemCount: 5)),
                  SizedBox(height: 20),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(children: [
                          CircleAvatar(radius: maxWidth(context) * 0.07),
                          Text('df')
                        ]),
                        Column(children: [
                          CircleAvatar(radius: maxWidth(context) * 0.07),
                          Text('df')
                        ]),
                        Column(children: [
                          CircleAvatar(radius: maxWidth(context) * 0.07),
                          Text('df')
                        ]),
                        Column(children: [
                          CircleAvatar(radius: maxWidth(context) * 0.07),
                          Text('df')
                        ]),
                        Column(children: [
                          CircleAvatar(radius: maxWidth(context) * 0.07),
                          Text('df')
                        ])
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
                  Text('고민될 땐, 다른 캠퍼들이 탐내는 상품을 살펴보아요.')
                ]))));
  }
}
