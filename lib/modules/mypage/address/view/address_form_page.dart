import 'package:flutter_multi_formatter/formatters/masked_input_formatter.dart';
import 'package:turtlz/repositories/address_repository/models/address.dart';
import 'package:turtlz/modules/mypage/address/cubit/address_cubit.dart';
import 'package:turtlz/support/style/format_unit.dart';
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
        appBar: AppBar(automaticallyImplyLeading: true),
        body:
            BlocBuilder<AddressCubit, AddressState>(builder: (context, state) {
          return SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 20),
                      child: Text("address.", style: theme.textTheme.headline3),
                    ),
                    Form(
                        key: _formKey,
                        child: Wrap(runSpacing: 30, children: [
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text("받는 분"),
                                TextFormField(
                                    autofocus: true,
                                    onChanged: (value) {
                                      setState(() {
                                        address = address.copyWith(name: value);
                                      });
                                    },
                                    decoration: InputDecoration(
                                        enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Theme.of(context)
                                                    .primaryColor)),
                                        focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Theme.of(context)
                                                    .primaryColor)),
                                        border: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Theme.of(context)
                                                    .primaryColor)),
                                        hintText: '성함을 입력해 주세요.')),
                              ]),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("휴대폰 번호"),
                              TextFormField(
                                  keyboardType: TextInputType.phone,
                                  onChanged: (value) {
                                    setState(() {
                                      address =
                                          address.copyWith(phoneNumber: value);
                                    });
                                  },
                                  decoration: InputDecoration(
                                      enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Theme.of(context)
                                                  .primaryColor)),
                                      focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Theme.of(context)
                                                  .primaryColor)),
                                      border: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Theme.of(context)
                                                  .primaryColor)),
                                      hintText: '번호를 입력해 주세요.'),
                                  inputFormatters: [
                                    MaskedInputFormatter('000-0000-0000',
                                        allowedCharMatcher: RegExp('[0-9]'))
                                  ]),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("배송지"),
                              Row(children: [
                                Expanded(
                                  child: SizedBox(
                                    child: GestureDetector(
                                        onTap: () async {
                                          await Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (_) => KpostalView(
                                                      useLocalServer: false,
                                                      callback:
                                                          (Kpostal result) {
                                                        setState(() {
                                                          address = address.copyWith(
                                                              postalCode: result
                                                                  .postCode,
                                                              bigAddress: result
                                                                  .address);
                                                        });
                                                      })));
                                        },
                                        child: Container(
                                            height: 50,
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 15),
                                            alignment: Alignment.center,
                                            width: 50,
                                            decoration: BoxDecoration(
                                                border: Border(
                                                    bottom: BorderSide(
                                                        color:
                                                            theme.primaryColor,
                                                        width: 1))),
                                            child: Text(address.postalCode ==
                                                    null
                                                ? ""
                                                : "${address.postalCode}"))),
                                  ),
                                ),
                                GestureDetector(
                                    onTap: () async {
                                      await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) => KpostalView(
                                                  useLocalServer: false,
                                                  callback: (Kpostal result) {
                                                    setState(() {
                                                      address =
                                                          address.copyWith(
                                                              postalCode: result
                                                                  .postCode,
                                                              bigAddress: result
                                                                  .address);
                                                    });
                                                  })));
                                    },
                                    child: Container(
                                        alignment: Alignment.center,
                                        margin: const EdgeInsets.only(left: 10),
                                        height: 50,
                                        width: 100,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: theme.primaryColor),
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        child: Text("우편번호 검색",
                                            style: theme.textTheme.button!
                                                .copyWith(
                                                    color:
                                                        theme.primaryColor))))
                              ]),
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
                                                      postalCode:
                                                          result.postCode,
                                                      bigAddress:
                                                          result.address);
                                                });
                                              })));
                                },
                                child: Container(
                                    height: 50,
                                    alignment: Alignment.centerLeft,
                                    width: maxWidth(context),
                                    decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                color: theme.primaryColor,
                                                width: 1))),
                                    child: Text(address.bigAddress == null
                                        ? ""
                                        : "${address.bigAddress}")),
                              ),
                              TextFormField(
                                  onChanged: (value) {
                                    setState(() {
                                      address =
                                          address.copyWith(smallAddress: value);
                                    });
                                  },
                                  decoration: InputDecoration(
                                      enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Theme.of(context)
                                                  .primaryColor)),
                                      focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Theme.of(context)
                                                  .primaryColor)),
                                      border: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Theme.of(context)
                                                  .primaryColor)),
                                      hintText: '상세 주소를 입력해 주세요.')),
                            ],
                          ),
                          Row(children: [
                            GestureDetector(
                                onTap: () {
                                  setState(() {
                                    address = address.copyWith(
                                        isDefault: !address.isDefault!);
                                  });
                                },
                                child: Icon(address.isDefault!
                                    ? Icons.check_box_rounded
                                    : Icons.check_box_outline_blank_rounded)),
                            const SizedBox(width: 10),
                            const Text("기본 배송지로 설정하기")
                          ])
                        ])),
                    const SizedBox(height: 10),
                    GestureDetector(
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
                                      title: const Text("주소 정보를 모두 입력해주세요."),
                                      actions: [
                                        MaterialButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: const Text("확인"))
                                      ]);
                                });
                          } else {
                            _addressCubit.createAddress(address);
                            Navigator.pop(context);
                          }
                        },
                        child: Container(
                            height: 60,
                            width: maxWidth(context),
                            decoration: BoxDecoration(
                                color: theme.primaryColor,
                                border: Border.all(color: theme.primaryColor),
                                borderRadius: BorderRadius.circular(20)),
                            alignment: Alignment.center,
                            child: Text("추가하기",
                                style: theme.textTheme.headline5!
                                    .copyWith(color: Colors.white)))),
                    const SizedBox(height: 20),
                  ]));
        }));
  }
}
