import 'package:turtlz/modules/orderForm/cubit/orderForm_cubit.dart';
import 'package:turtlz/support/style/format_unit.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:turtlz/support/style/theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'orderForm_page.dart';

class OrderFormListPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _OrderFormListPageState();
}

class _OrderFormListPageState extends State<OrderFormListPage> {
  late OrderFormCubit _orderFormCubit;
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _orderFormCubit = BlocProvider.of<OrderFormCubit>(context);
    _scrollController.addListener(_onScroll);
    _orderFormCubit.getOrderForm();
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll == 0) {
      _orderFormCubit.getOrderForm();
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);

    return BlocBuilder<OrderFormCubit, OrderFormState>(
        builder: (context, state) {
      return BlocBuilder<OrderFormCubit, OrderFormState>(
          builder: (context, state) {
        if (state.isLoaded) {
          if (state.orderForm!.length > 0) {
            return ListView.builder(
                controller: _scrollController,
                shrinkWrap: true,
                itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("${state.orderForm![index].orderDate}",
                              style: theme.textTheme.headline5!
                                  .copyWith(color: Color(0xFF606060))),
                          SizedBox(height: 10),
                          Wrap(
                              runSpacing: 10,
                              children: List.generate(
                                  state.orderForm![index].itemsInfo!.length,
                                  (i) => orderTileWidget(
                                      context, state, index, i))),
                        ])),
                itemCount: state.orderForm!.length);
          } else {
            return Center(
                child: Text("no orders :(", style: theme.textTheme.headline3));
          }
        } else {
          return Center(
              child: Image.asset('assets/images/indicator.gif',
                  width: 100, height: 100));
        }
      });
    });
  }

  GestureDetector orderTileWidget(
      BuildContext context, OrderFormState state, int index, int i) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => BlocProvider<OrderFormCubit>.value(
                      value: _orderFormCubit,
                      child:
                          OrderFormPage(state.orderForm![index].Id!, true))));
        },
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          Container(
              width: maxWidth(context),
              child:
                  Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Container(
                    width: 85,
                    height: 85,
                    margin: const EdgeInsets.only(right: 10),
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(
                                "${state.orderForm![index].itemsInfo![i].productThumbnail}"),
                            fit: BoxFit.cover))),
                Expanded(
                    flex: 3,
                    child: Stack(children: [
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                                "${state.orderForm![index].itemsInfo![i].status}",
                                style: theme.textTheme.headline6!
                                    .copyWith(color: theme.accentColor)),
                            SizedBox(height: 8),
                            Text(
                                "${state.orderForm![index].itemsInfo![i].productName}",
                                style: theme.textTheme.headline6,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis),
                            Text(
                                "${state.orderForm![index].itemsInfo![i].variantName}",
                                style: theme.textTheme.subtitle2,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis),
                            SizedBox(height: 8),
                            Text(
                                "수량 : ${state.orderForm![index].itemsInfo![i].quantity}개",
                                style: theme.textTheme.subtitle2)
                          ]),
                      Align(
                          alignment: Alignment.bottomRight,
                          child: Text(
                              "${currencyFromString(state.orderForm![index].itemsInfo![i].salePrice.toString())}",
                              style: theme.textTheme.headline6))
                    ]))
              ])),
          SizedBox(height: 10)
        ]));
  }
}
