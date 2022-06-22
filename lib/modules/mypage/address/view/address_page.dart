import 'package:turtlz/modules/mypage/address/view/components/address_tile_widget.dart';
import 'package:turtlz/repositories/address_repository/models/address.dart';
import 'package:turtlz/modules/mypage/address/view/address_form_page.dart';
import 'package:turtlz/modules/mypage/address/cubit/address_cubit.dart';
import 'package:turtlz/support/style/format_unit.dart';
import 'package:turtlz/support/style/theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddressPage extends StatefulWidget {
  final bool isOrdering;

  const AddressPage({Key? key, required this.isOrdering}) : super(key: key);

  @override
  State<AddressPage> createState() => _AddressPage();
}

class _AddressPage extends State<AddressPage>
    with SingleTickerProviderStateMixin {
  bool get isOrdering => this.widget.isOrdering;

  late AddressCubit _addressCubit;

  int selected = 0;

  @override
  void initState() {
    super.initState();
    _addressCubit = BlocProvider.of<AddressCubit>(context);
    _addressCubit.getAddressList();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddressCubit, AddressState>(builder: (context, state) {
      if (state.isLoaded) {
        return BlocSelector<AddressCubit, AddressState, List<Address?>>(
            selector: (state) => state.addresses!,
            builder: (context, addresses) {
              if (addresses != null && addresses.isNotEmpty) {
                return SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("address.", style: theme.textTheme.headline3),
                          GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) =>
                                            BlocProvider<AddressCubit>.value(
                                                value: _addressCubit,
                                                child: AddressFormPage())));
                              },
                              child: Text("배송지 추가",
                                  style: theme.textTheme.headline5!.copyWith(
                                      decoration: TextDecoration.underline)))
                        ]),
                    Column(children: [
                      Column(
                          children: List.generate(
                              addresses.length,
                              (index) => GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selected = index;
                                    });
                                  },
                                  child: addressTile(_addressCubit,
                                      addresses[index]!, selected == index)))),
                      const SizedBox(height: 20),
                      GestureDetector(
                          onTap: () {
                            if (isOrdering) {
                              Navigator.pop(
                                  context, state.addresses![selected]);
                            } else {
                              _addressCubit.updateDefaultAddress(
                                  state.addresses![selected].id!);
                            }
                          },
                          child: Container(
                              width: maxWidth(context),
                              height: 60,
                              decoration: BoxDecoration(
                                  color: theme.primaryColor,
                                  borderRadius: BorderRadius.circular(20)),
                              child: Center(
                                  child: Text(isOrdering ? "선택하기" : "설정 완료",
                                      style: theme.textTheme.headline5!
                                          .copyWith(color: Colors.white)))))
                    ])
                  ]),
                );
              } else {
                return Center(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                      Container(
                          child: Text("no address :(",
                              style: theme.textTheme.headline2!
                                  .copyWith(height: 2))),
                      GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) =>
                                        BlocProvider<AddressCubit>.value(
                                            value: _addressCubit,
                                            child: AddressFormPage())));
                          },
                          child: Text("배송지를 추가해 주세요.",
                              style: theme.textTheme.headline5!.copyWith(
                                  decoration: TextDecoration.underline)))
                    ]));
              }
            });
      } else {
        return Center(
            child: Image.asset('assets/images/indicator.gif',
                width: 100, height: 100));
      }
    });
  }
}
