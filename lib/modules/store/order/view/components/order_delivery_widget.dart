import 'package:turtlz/modules/store/order/cubit/order_cubit.dart';
import 'package:turtlz/repositories/order_repository/models/customer_requests.dart';
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
                                  style: TextStyle(color: Colors.black)))))));
        },
        child: Container(
            width: 300,
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(orderCubit.state.selectedShippingRequest == null
                      ? "배송 요청사항을 선택해주세요."
                      : orderCubit.state.selectedShippingRequest!.content),
                  Icon(Icons.keyboard_arrow_down)
                ]))),
    TextField(
        onChanged: (value) {
          orderCubit.setDeliveryMessage(value);
        },
        decoration: InputDecoration(labelText: "추가 요청 사항을 입력해주세요."))
  ]);
}
