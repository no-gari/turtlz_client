import 'package:turtlz/support/base_component/web_router.dart';
import 'package:turtlz/support/style/theme.dart';
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
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const SizedBox(height: 20),
      Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(children: [
                GestureDetector(
                    onTap: () => isWebRouter(
                        context, 'https://www.instagram.com/turtlz_official/'),
                    child: SvgPicture.asset('assets/icons/instagram.svg',
                        height: 20, color: theme.primaryColor)),
                const SizedBox(width: 15),
                GestureDetector(
                    onTap: () =>
                        isWebRouter(context, 'https://loonshot.company'),
                    child: SvgPicture.asset('assets/icons/website.svg',
                        height: 20, color: theme.primaryColor))
              ])
            ]),
            GestureDetector(
                onTap: () => setState(() => isOpened = !isOpened),
                child: Wrap(children: [
                  Text('사업자 정보',
                      style: Theme.of(context)
                          .textTheme
                          .headline5!
                          .copyWith(color: theme.primaryColor)),
                  Icon(
                      isOpened == true
                          ? Icons.arrow_drop_up
                          : Icons.arrow_drop_down,
                      color: theme.primaryColor,
                      size: 20)
                ]))
          ]),
      if (isOpened == true)
        Column(children: [
          SizedBox(height: 10),
          RichText(
              text: TextSpan(
                  style: theme.textTheme.bodyText2!
                      .copyWith(color: theme.primaryColor),
                  children: [
                const TextSpan(text: '(주)룬샷컴퍼니\n'),
                const TextSpan(
                    text: '사업장 주소: 경기도 성남시 판교역로192번길 16 판교타워 806호\n'),
                const TextSpan(text: '사업자등록번호: 407-81-32513'),
                const TextSpan(text: '\n통신판매업신고번호: 2021-성남분당A-0655'),
                const TextSpan(text: '\n이메일: contact@loonshot.company'),
                const TextSpan(text: '\n입금계좌: 우리은행 1005-004-261257\n'),
                WidgetSpan(
                    child: GestureDetector(
                        onTap: () => isWebRouter(
                            context, 'https://turtlz.co/personal_policy/'),
                        child: Text('개인정보 처리방침',
                            style: theme.textTheme.bodyText2!.copyWith(
                                color: theme.primaryColor,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline)))),
                WidgetSpan(
                    child: Text(' 및 ',
                        style: theme.textTheme.bodyText2!
                            .copyWith(color: theme.primaryColor))),
                WidgetSpan(
                    child: GestureDetector(
                  onTap: () =>
                      isWebRouter(context, 'https://turtlz.co/agreement/'),
                  child: Text('서비스 이용약관',
                      style: theme.textTheme.bodyText2!.copyWith(
                          color: theme.primaryColor,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline)),
                )),
                const TextSpan(text: '\n개인정보 관리 책임자: 홍정완\n'),
                const TextSpan(text: '대표 : 홍정완\n\n'),
                TextSpan(
                    text:
                        '(주)룬샷컴퍼니는 통신판매 중개자로서 통신 판매의 당사자가 아니므로 개별 판매자가 등록한 상품 정보에 대해서 책임을 지지 않습니다.',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2!
                        .copyWith(color: Colors.grey, fontSize: 10))
              ]))
        ]),
      SizedBox(height: 20)
    ]);
  }
}
