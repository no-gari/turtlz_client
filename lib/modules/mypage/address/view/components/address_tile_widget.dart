import 'package:turtlz/repositories/address_repository/models/address.dart';
import 'package:turtlz/modules/mypage/address/cubit/address_cubit.dart';
import 'package:turtlz/support/style/theme.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:flutter/material.dart';

Widget addressTile(
    AddressCubit addressCubit, Address address, bool isSelected) {
  return Padding(
    padding: const EdgeInsets.only(top: 20),
    child: Column(children: [
      Card(
          color: Colors.transparent,
          shadowColor: Colors.transparent,
          child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Flexible(
                child: isSelected
                    ? const Icon(Icons.radio_button_checked)
                    : const Icon(Icons.radio_button_off)),
            // 브랜드 정보
            Flexible(
                flex: 15,
                child: Container(
                    padding: const EdgeInsets.all(15),
                    margin: const EdgeInsets.only(left: 15),
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 3,
                              offset: Offset(1, 1))
                        ],
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.black),
                        color: Colors.white),
                    child: Wrap(runSpacing: 15, children: [
                      Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(children: [
                              Text("${address.name}",
                                  style: theme.textTheme.subtitle1),
                              address.isDefault!
                                  ? Container(
                                      margin: const EdgeInsets.only(left: 10),
                                      padding: const EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(25),
                                          border: Border.all(
                                              color: theme.accentColor)),
                                      child: Text("기본 배송지",
                                          style: theme.textTheme.subtitle2!
                                              .copyWith(
                                                  color: theme.accentColor)))
                                  : SizedBox(height: 1)
                            ]),
                            GestureDetector(
                                onTap: () =>
                                    addressCubit.deleteAddress(address.id!),
                                child: const Icon(Icons.clear))
                          ]),
                      // 상품 정보
                      Wrap(runSpacing: 10, children: [
                        Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  margin: const EdgeInsets.only(right: 10),
                                  child: const Text("주소")),
                              Flexible(
                                  child: Text(
                                      "${address.bigAddress}\n${address.smallAddress}"))
                            ]),
                        Row(children: [
                          Container(
                              margin: EdgeInsets.only(right: 10),
                              child: Text("번호")),
                          Text("${address.phoneNumber}")
                        ])
                      ])
                    ])))
          ]))
    ]),
  );
}
