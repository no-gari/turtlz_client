import 'package:flutter_multi_formatter/formatters/masked_input_formatter.dart';
import 'package:turtlz/repositories/address_repository/models/address.dart';
import 'package:turtlz/modules/mypage/address/cubit/address_cubit.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:turtlz/support/style/theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kpostal/kpostal.dart';

class AddressFormPage extends StatefulWidget {
  @override
  State<AddressFormPage> createState() => _AddressFormPage();
}

class _AddressFormPage extends State<AddressFormPage> {
  late AddressCubit _addressCubit;

  final _formKey = GlobalKey<FormState>();

  Address address = Address();

  @override
  void initState() {
    super.initState();
    _addressCubit = BlocProvider.of<AddressCubit>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
        ),
        bottomNavigationBar: GestureDetector(
            onTap: () {
              if (address.bigAddress == null ||
                  address.postalCode == null ||
                  address.phoneNumber == null ||
                  address.name == null ||
                  address.smallAddress == null) {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                          title: Text("주소 정보를 모두 입력해주세요."),
                          actions: [
                            MaterialButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text("확인"))
                          ]);
                    });
              } else {
                _addressCubit.createAddress(address);
                Navigator.pop(context);
              }
            },
            child: Container(
                height: Adaptive.h(10),
                width: 300,
                color: Colors.black,
                alignment: Alignment.center,
                child: Text("추가하기",
                    style: theme.textTheme.button!
                        .copyWith(color: Colors.white)))),
        body:
            BlocBuilder<AddressCubit, AddressState>(builder: (context, state) {
          return SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                Container(
                  margin: EdgeInsets.only(bottom: 30),
                  child: Text("ADDRESS", style: theme.textTheme.headline4),
                ),
                Form(
                    key: _formKey,
                    child: Wrap(runSpacing: 10, children: [
                      Text("받는 분"),
                      TextFormField(onChanged: (value) {
                        setState(() {
                          address = address.copyWith(name: value);
                        });
                      }),
                      Text("휴대폰 번호"),
                      TextFormField(
                          keyboardType: TextInputType.phone,
                          onChanged: (value) {
                            setState(() {
                              address = address.copyWith(phoneNumber: value);
                            });
                          },
                          inputFormatters: [
                            MaskedInputFormatter('000-0000-0000',
                                allowedCharMatcher: RegExp('[0-9]'))
                          ]),
                      Text("배송지"),
                      Row(children: [
                        Container(
                            height: 50,
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            alignment: Alignment.center,
                            width: 50,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            child: Text(address.postalCode == null
                                ? ""
                                : "${address.postalCode}")),
                        GestureDetector(
                            onTap: () async {
                              await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => KpostalView(
                                          useLocalServer: false,
                                          callback: (Kpostal result) {
                                            setState(() {
                                              address = address.copyWith(
                                                  postalCode: result.postCode,
                                                  bigAddress: result.address);
                                            });
                                          })));
                            },
                            child: Container(
                                alignment: Alignment.center,
                                margin: EdgeInsets.only(left: 10),
                                height: 50,
                                width: 100,
                                color: Colors.black,
                                child: Text("우편번호 검색",
                                    style: theme.textTheme.button!
                                        .copyWith(color: Colors.white))))
                      ]),
                      Container(
                          height: 50,
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          alignment: Alignment.centerLeft,
                          width: 300,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: Text(address.bigAddress == null
                              ? ""
                              : "${address.bigAddress}")),
                      TextFormField(
                          onChanged: (value) {
                            setState(() {
                              address = address.copyWith(smallAddress: value);
                            });
                          },
                          decoration: InputDecoration(labelText: '상세 주소')),
                      Row(children: [
                        IconButton(
                            onPressed: () {
                              setState(() {
                                address = address.copyWith(
                                    isDefault: !address.isDefault!);
                              });
                            },
                            icon: Icon(address.isDefault!
                                ? Icons.check_box_rounded
                                : Icons.check_box_outline_blank_rounded)),
                        Text("기본 배송지로 설정하기")
                      ])
                    ]))
              ]));
        }));
  }
}
