import 'package:turtlz/repositories/order_repository/models/customer_requests.dart';
import 'package:turtlz/modules/store/order/cubit/order_cubit.dart';
import 'package:turtlz/support/style/format_unit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget orderDelivery(BuildContext context, CustomerRequests customerRequests,
    OrderCubit orderCubit) {
  int _result = 0;
  return Wrap(runSpacing: 15, children: [
    GestureDetector(
        onTap: () {
          showCupertinoModalPopup(
              context: context,
              semanticsDismissible: true,
              builder: (context) => Container(
                  height: 200.0,
                  child: CupertinoPicker(
                      backgroundColor: Colors.white,
                      itemExtent: 50,
                      onSelectedItemChanged: (int index) {
                        orderCubit.setShippingRequest(
                            customerRequests.shippingRequest![index]);
                      },
                      scrollController:
                          FixedExtentScrollController(initialItem: _result),
                      children: List.generate(
                          customerRequests.shippingRequest!.length,
                          (index) => Center(
                              child: Text(
                                  "${customerRequests.shippingRequest![index].content}",
                                  style: const TextStyle(
                                      color: Colors.black)))))));
        },
        child: Container(
            width: maxWidth(context),
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            decoration: const BoxDecoration(
                border: Border(
                    bottom: BorderSide(width: 2, color: Color(0xFF37521C)))),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                      orderCubit.state.selectedShippingRequest == null
                          ? "배송 요청사항을 선택해주세요."
                          : orderCubit.state.selectedShippingRequest!.content,
                      style: Theme.of(context)
                          .textTheme
                          .subtitle1!
                          .copyWith(color: Colors.black54)),
                  const Icon(Icons.keyboard_arrow_down,
                      color: Color(0xFF37521C))
                ]))),
    TextField(
        onChanged: (value) {
          orderCubit.setDeliveryMessage(value);
        },
        decoration: const InputDecoration(
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xFF37521C), width: 2)),
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xFF37521C), width: 2)),
            border: UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xFF37521C), width: 2)),
            hintText: '추가 요청 사항을 입력해주세요.')),
    const Padding(padding: EdgeInsets.symmetric(vertical: 20), child: Divider())
  ]);
}
