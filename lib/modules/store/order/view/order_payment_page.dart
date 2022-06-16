import 'package:turtlz/modules/store/order/view/order_cancel_page.dart';
import 'package:turtlz/modules/store/order/cubit/payment_cubit.dart';
import 'package:turtlz/modules/store/order/cubit/order_cubit.dart';
import 'package:turtlz/support/style/theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

/* 아임포트 결제 모듈을 불러옵니다. */
import 'package:iamport_flutter/iamport_payment.dart';
import 'order_result_page.dart';

/* 아임포트 결제 데이터 모델을 불러옵니다. */
// import 'package:iamport_flutter/model/payment_data.dart' as \;

class OrderPaymentPage extends StatefulWidget {
  OrderPaymentPage({@required this.method});

  final String? method;

  @override
  State<StatefulWidget> createState() => _OrderPaymentPageState();
}

class _OrderPaymentPageState extends State<OrderPaymentPage> {
  late OrderCubit _orderCubit;
  late PaymentCubit _paymentCubit;

  late Map<String, dynamic> orderTemp;

  @override
  void initState() {
    super.initState();
    _orderCubit = BlocProvider.of<OrderCubit>(context);
    _paymentCubit = BlocProvider.of<PaymentCubit>(context);
    orderTemp = {
      "products": _orderCubit.state.orderTemp!.products!
          .map((p) => p.toJson())
          .toList(),
      "address": _orderCubit.state.orderTemp!.address!.toJson(),
      "request": {
        "shippingRequest": _orderCubit.state.selectedShippingRequest!.toJson(),
        "additionalRequest":
            _orderCubit.state.orderTemp!.request!.additionalRequest
      },
      "coupon": _orderCubit.state.orderTemp!.coupon!.toJson(),
      "agreed": _orderCubit.state.agreed
    };

    print(orderTemp);

    _paymentCubit
        .createOrder(orderTemp)
        .catchError((error) => _paymentCubit.failureOrder(error));
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);

    return BlocBuilder<PaymentCubit, PaymentState>(builder: (context, state) {
      if (state.isLoaded) {
        return SafeArea(
            child: IamportPayment(
                appBar: AppBar(
                    backgroundColor: Colors.white,
                    iconTheme: IconThemeData(color: Colors.black),
                    elevation: 0,
                    title: Text('결제 페이지',
                        style: Theme.of(context).textTheme.headline6),
                    leading: IconButton(
                        onPressed: () {
                          showDialog(
                              useRootNavigator: false,
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                    title: Text("결제를 취소합니다."),
                                    actions: [
                                      MaterialButton(
                                          onPressed: () {
                                            _orderCubit.cancelOrder(
                                                state.order!.merchantUid,
                                                '...');
                                            Navigator.pushNamedAndRemoveUntil(
                                                context,
                                                OrderCancelPage.routeName,
                                                (route) => false);
                                          },
                                          child: Text("확인")),
                                      MaterialButton(
                                          onPressed: () =>
                                              Navigator.pop(context),
                                          child: Text("취소"))
                                    ]);
                              });
                        },
                        icon: Icon(Icons.arrow_back_ios_rounded))),
                initialChild: Container(
                    child: Center(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                      Container(
                          padding: EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 0.0),
                          child: Text('잠시만 기다려주세요...',
                              style: TextStyle(fontSize: 20.0)))
                    ]))),
                userCode: 'imp03489525',
                // 가맹점 식별코드

                /* [필수입력] 결제 데이터 */
                data: PaymentData(
                  pg: 'uplus',
                  // PG사
                  payMethod: widget.method!,
                  // 결제수단
                  name: '${state.order!.name}',
                  // 주문명
                  merchantUid: '${state.order!.merchantUid}',
                  // 주문번호
                  amount: state.order!.amount!.toInt(),
                  // 결제금액
                  buyerName: '${state.order!.buyerName}',
                  // 구매자 이름
                  buyerTel: '${state.order!.buyerTel}',
                  // 구매자 연락처
                  buyerEmail: '${state.order!.buyerEmail}',
                  // 구매자 이메일
                  buyerAddr:
                      '${_orderCubit.state.orderTemp!.address!.bigAddress}',
                  // 구매자 주소
                  buyerPostcode:
                      '${_orderCubit.state.orderTemp!.address!.postalCode}',
                  // 구매자 우편번호
                  appScheme: 'aroundus', // 앱 URL scheme
                ),
                /* [필수입력] 콜백 함수 */
                callback: (Map<String, String> result) {
                  print("아임포트 result ---- $result");
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => OrderResultPage(result)));
                }));
      } else {
        if (state.errorMessage != null) {
          return buildScaffold(state, context);
        } else {
          return Center(
              child: Image.asset('assets/images/indicator.gif',
                  width: 100, height: 100));
        }
      }
    });
  }

  Scaffold buildScaffold(PaymentState state, BuildContext context) {
    return Scaffold(
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
          Container(
              margin: EdgeInsets.only(bottom: 20),
              child: Text("${state.errorMessage}",
                  style: theme.textTheme.headline4)),
          MaterialButton(
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, "", (route) => false);
              },
              child: Text("홈 화면으로 이동"))
        ])));
  }
}
