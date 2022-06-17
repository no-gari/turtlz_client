import 'package:turtlz/support/base_component/web_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CompanyInfo extends StatefulWidget {
  @override
  State<CompanyInfo> createState() => _CompanyInfoState();
}

class _CompanyInfoState extends State<CompanyInfo> {
  bool isOpened = false;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        color: Colors.black,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Image.asset('assets/images/aroundus.png', height: 15),
                  SizedBox(height: 10),
                  Row(children: [
                    GestureDetector(
                        onTap: () => isWebRouter(context,
                            'https://www.instagram.com/ustain.official/'),
                        child: SvgPicture.asset('assets/icons/instagram.svg',
                            height: 15)),
                    SizedBox(width: 10),
                    GestureDetector(
                        onTap: () =>
                            isWebRouter(context, 'https://app.ustain.be/'),
                        child: SvgPicture.asset('assets/icons/website.svg',
                            height: 15))
                  ])
                ]),
                GestureDetector(
                    onTap: () => setState(() => isOpened = !isOpened),
                    child: Wrap(children: [
                      Text('사업자 정보',
                          style: TextStyle(color: Colors.white, fontSize: 15)),
                      Icon(
                          isOpened == true
                              ? Icons.arrow_drop_up
                              : Icons.arrow_drop_down,
                          color: Colors.white,
                          size: 15)
                    ]))
              ]),
          if (isOpened == true)
            Column(children: [
              SizedBox(height: 20),
              RichText(
                  text: TextSpan(
                      style: TextStyle(color: Colors.white, height: 1.5),
                      children: [
                    TextSpan(text: '어라운드어스\n'),
                    TextSpan(text: '사업자등록번호: 211-36-08033 '),
                    WidgetSpan(
                        child: GestureDetector(
                            onTap: () => isWebRouter(context,
                                'http://www.ftc.go.kr/bizCommPop.do?wrkr_no=2113608033/'),
                            child: Text('정보 확인',
                                style: TextStyle(
                                    color: Colors.white,
                                    decoration: TextDecoration.underline)))),
                    TextSpan(text: '\n사업장 주소: 서울시 마포구 성지길 25-11 지층 5호\n'),
                    WidgetSpan(
                        child: GestureDetector(
                      onTap: () => isWebRouter(
                          context, 'https://aroundusprivacypolicy.oopy.io/'),
                      child: Text('개인정보 처리방침',
                          style: TextStyle(
                              color: Colors.white,
                              height: 1.5,
                              decoration: TextDecoration.underline)),
                    )),
                    WidgetSpan(
                        child:
                            Text(' 및 ', style: TextStyle(color: Colors.white))),
                    WidgetSpan(
                        child: GestureDetector(
                      onTap: () =>
                          isWebRouter(context, 'https://arounduspp2.oopy.io/'),
                      child: Text('서비스 이용약관',
                          style: TextStyle(
                              color: Colors.white,
                              height: 1.5,
                              decoration: TextDecoration.underline)),
                    )),
                    TextSpan(text: '\n개인정보 관리 책임자: 김은지\n'),
                    TextSpan(text: '대표 : 노종혁\n\n'),
                    TextSpan(
                        text:
                            '어라운드어스는 통신판매 중개자로서 통신 판매의 당사자가 아니므로 개별 판매자가 등록한 상품 정보에 대해서 책임을 지지 않습니다.',
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2!
                            .copyWith(color: Colors.grey, fontSize: 10))
                  ]))
            ]),
          SizedBox(height: 20)
        ]));
  }
}
