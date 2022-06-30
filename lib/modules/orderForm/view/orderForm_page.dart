import 'package:turtlz/repositories/order_repository/models/order_form.dart';
import 'package:turtlz/modules/orderForm/cubit/orderForm_cubit.dart';
import 'package:turtlz/support/style/theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'components/components.dart';

class OrderFormPage extends StatefulWidget {
  OrderFormPage(this.orderId, this.viewingNavigator);

  final String orderId;
  final bool viewingNavigator;

  @override
  State<StatefulWidget> createState() => _OrderFormPageState();
}

class _OrderFormPageState extends State<OrderFormPage>
    with SingleTickerProviderStateMixin {
  String get orderId => this.widget.orderId;

  bool get viewingNavigator => this.widget.viewingNavigator;

  late OrderFormCubit _orderFormCubit;
  late OrderForm orderForm;

  @override
  void initState() {
    super.initState();
    _orderFormCubit = BlocProvider.of<OrderFormCubit>(context);
    _orderFormCubit.getOrderFormById(orderId);
  }

  @override
  void dispose() {
    super.dispose();
    _orderFormCubit.getOrderForm();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);

    return Scaffold(
        appBar: viewingNavigator
            ? AppBar(
                backgroundColor: Colors.white,
                elevation: 0,
                iconTheme: const IconThemeData(color: Colors.black))
            : AppBar(
                backgroundColor: Colors.white,
                elevation: 0,
                centerTitle: false,
                title: GestureDetector(
                    child: const Icon(Icons.arrow_back_ios_outlined,
                        color: Colors.black),
                    onTap: () {
                      Navigator.pushNamed(context, '');
                    })),
        body: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: BlocBuilder<OrderFormCubit, OrderFormState>(
                builder: (context, state) {
              if (state.isLoaded) {
                orderForm = _orderFormCubit.state.orderForm!.first;
                return Wrap(runSpacing: 10, children: [
                  Container(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                        Text("${orderForm.orderDate}",
                            style: theme.textTheme.bodyText1!
                                .copyWith(fontWeight: FontWeight.w700)),
                        Text("주문번호 ${orderForm.Id}",
                            style: TextStyle(color: Color(0xFF606060))),
                        Container(
                            height: 1,
                            width: double.maxFinite,
                            color: Colors.black,
                            margin: EdgeInsets.only(top: 5))
                      ])),
                  orderFormOrderItemsWidget(orderForm.itemsInfo!),
                  orderFormPaymentsWidget(orderForm.paymentInfo!),
                  orderFormCustomerWidget(orderForm.customerInfo!),
                  orderFormAddressWidget(orderForm.addressInfo!)
                ]);
              } else {
                return Center(
                    child: Image.asset('assets/images/indicator.gif',
                        width: 100, height: 100));
              }
            })));
  }
}
