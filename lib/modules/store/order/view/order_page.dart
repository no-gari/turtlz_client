import 'package:turtlz/repositories/order_repository/src/order_repository.dart';
import 'package:turtlz/repositories/order_repository/models/order_temp.dart';
import 'package:turtlz/repositories/order_repository/models/models.dart';
import 'package:turtlz/modules/mypage/address/cubit/address_cubit.dart';
import 'package:turtlz/modules/store/coupon/cubit/coupon_cubit.dart';
import 'package:turtlz/modules/store/order/cubit/payment_cubit.dart';
import 'package:turtlz/modules/store/order/cubit/order_cubit.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:turtlz/support/style/theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'views.dart';

class OrderPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  late OrderCubit _orderCubit;
  late AddressCubit _addressCubit;
  late CouponCubit _couponCubit;

  String payMethod = 'card';

  @override
  void initState() {
    super.initState();
    _orderCubit = BlocProvider.of<OrderCubit>(context);
    _addressCubit = BlocProvider.of<AddressCubit>(context);
    _couponCubit = BlocProvider.of<CouponCubit>(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderCubit, OrderState>(builder: (context, state) {
      if (state.isLoaded) {
        return BlocSelector<OrderCubit, OrderState, OrderTemp>(
            selector: (state) => state.orderTemp!,
            builder: (context, orderTemp) {
              return Stack(children: [
                SingleChildScrollView(
                    padding: EdgeInsets.only(bottom: Adaptive.h(10)),
                    child: Wrap(children: [
                      orderCompose(
                          title: "주문상품 (${orderTemp.products!.length}건)",
                          child: Column(
                              children: List.generate(
                                  orderTemp.products!.length,
                                  (index) => orderItemTile(_orderCubit,
                                      orderTemp.products![index])))),
                      orderCompose(
                          title: "쿠폰 사용",
                          child: orderCoupon(context, orderTemp.coupon,
                              _couponCubit, _orderCubit)),
                      orderCompose(
                          title: "배송지/주문자 정보",
                          child: orderAddress(
                              context, orderTemp.address!, _orderCubit)),
                      orderCompose(
                          title: "배송 요청사항",
                          child: orderDelivery(
                              context, orderTemp.request!, _orderCubit),
                          isRequired: true),
                      orderCompose(
                          title: "결제 정보",
                          child: orderPayment(
                              context, orderTemp.products!, _orderCubit)),
                      orderCompose(
                          title: "결제 방식",
                          child: Column(children: [
                            Row(children: [
                              payMethodContainer(context, '카드 결제', 'card'),
                              payMethodContainer(context, '계좌 이체', 'trans')
                            ])
                          ])),
                      Column(children: [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("주문 내역 확인 동의 및 결제 동의 (필수)",
                                  style: theme.textTheme.bodyText2),
                              IconButton(
                                  onPressed: () => _orderCubit.setAgreed(),
                                  icon: Icon(
                                      state.agreed
                                          ? Icons.check_box_rounded
                                          : Icons
                                              .check_box_outline_blank_rounded,
                                      color: Color(0xFFC4C4C4)))
                            ]),
                        Text("주문 상품의 상세 정보, 가격, 환불정책 등을  확인하였으며, 이에 동의합니다.",
                            style: TextStyle(
                                color: Color(0xFFC4C4C4),
                                fontWeight: FontWeight.w400,
                                fontSize: Adaptive.dp(12))),
                        Container(
                            padding: EdgeInsets.only(top: Adaptive.h(1)),
                            child: Column(children: [
                              agreeRow(title: '개인정보 수집/이용 동의'),
                              agreeRow(title: '개인정보 제3자 제공 동의'),
                              agreeRow(
                                  title: '결제대행 서비스 이용 약관',
                                  url:
                                      'https://pages.tosspayments.com/terms/onboarding')
                            ])),
                        SizedBox(height: Adaptive.h(5))
                      ])
                    ])),
                Align(
                    alignment: Alignment.bottomCenter,
                    child: GestureDetector(
                        onTap: () {
                          if (state.agreed &&
                              state.selectedShippingRequest != null &&
                              state.orderTemp!.address!.id != null) {
                            // Order 생성 페이지로 이동

                            print(state.orderTemp!.address);
                            print(state.orderTemp!.address!.id != null);

                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => MultiBlocProvider(
                                            providers: [
                                              BlocProvider<OrderCubit>.value(
                                                  value: _orderCubit),
                                              BlocProvider(
                                                  create: (_) => PaymentCubit(
                                                      RepositoryProvider.of<
                                                              OrderRepository>(
                                                          context)))
                                            ],
                                            child: OrderPaymentPage(
                                                method: payMethod))),
                                (route) => false);
                            // OrderResultPage
                          } else {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                      title: Text("필수 항목을 채워주세요."),
                                      actions: [
                                        MaterialButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text("확인"))
                                      ]);
                                });
                          }
                        },
                        child: Container(
                            height: 80,
                            width: 300,
                            color: Colors.black,
                            alignment: Alignment.center,
                            child: Text("결제하기",
                                style: theme.textTheme.button!
                                    .copyWith(color: Colors.white)))))
              ]);
            });
      } else {
        return Center(
            child: Image.asset('assets/images/indicator.gif',
                width: 100, height: 100));
      }
    });
  }

  GestureDetector payMethodContainer(context, String title, String method) {
    return GestureDetector(
        onTap: () {
          setState(() {
            payMethod = method;
          });
        },
        child: Container(
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                color: method == payMethod ? Colors.black : Colors.white),
            width: Adaptive.w(45),
            height: Adaptive.w(15),
            child: Center(
                child: Text(title,
                    style: Theme.of(context).textTheme.headline6!.copyWith(
                        color: method == payMethod
                            ? Colors.white
                            : Colors.black)))));
  }
}

class agreeRow extends StatelessWidget {
  const agreeRow({this.title, this.url = 'https://www.naver.com'});

  final String? title;
  final String? url;

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text(title!,
          style:
              TextStyle(color: Color(0xFFC4C4C4), fontSize: Adaptive.dp(12))),
      GestureDetector(
          onTap: () {
            showModalBottomSheet(
                isScrollControlled: false,
                isDismissible: true,
                backgroundColor: Colors.white,
                context: context,
                builder: (context) => WebView(
                    gestureRecognizers: Set()
                      ..add(Factory<VerticalDragGestureRecognizer>(
                          () => VerticalDragGestureRecognizer())),
                    initialUrl: url!,
                    javascriptMode: JavascriptMode.unrestricted));
          },
          child: Text('확인',
              style: TextStyle(
                  fontSize: Adaptive.dp(12),
                  decoration: TextDecoration.underline)))
    ]);
  }
}
