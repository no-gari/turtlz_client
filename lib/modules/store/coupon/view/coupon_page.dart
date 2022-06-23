import 'package:turtlz/repositories/coupon_repository/models/coupon.dart';
import 'package:turtlz/modules/store/coupon/cubit/coupon_cubit.dart';
import 'package:turtlz/support/style/format_unit.dart';
import 'package:turtlz/support/style/theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'components/coupon_tile_widget.dart';
import 'package:flutter/material.dart';

class CouponPage extends StatefulWidget {
  final bool? isMypage;

  CouponPage({this.isMypage});

  @override
  State<CouponPage> createState() => _CouponPage();
}

class _CouponPage extends State<CouponPage> {
  late CouponCubit _couponCubit;

  int selected = 0;

  @override
  void initState() {
    super.initState();
    _couponCubit = BlocProvider.of<CouponCubit>(context);
    _couponCubit.getCouponList();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CouponCubit, CouponState>(builder: (context, state) {
      if (state.isLoaded) {
        return BlocSelector<CouponCubit, CouponState, List<Coupon?>>(
            selector: (state) => state.coupons!,
            builder: (context, coupons) {
              if (coupons != null && coupons.isNotEmpty) {
                return Stack(children: [
                  Column(children: [
                    Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("coupons.", style: theme.textTheme.headline3)
                            ])),
                    SingleChildScrollView(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 30),
                        child: Column(children: [
                          Column(
                              children: List.generate(
                                  coupons.length,
                                  (index) => GestureDetector(
                                      onTap: () {
                                        setState(() => selected = index);
                                      },
                                      child: couponTile(
                                          _couponCubit,
                                          coupons[index]!,
                                          selected == index,
                                          widget.isMypage!,
                                          context)))),
                          const SizedBox(height: 20),
                          if (widget.isMypage == false)
                            GestureDetector(
                                onTap: () async {
                                  Navigator.pop(
                                      context, coupons[selected]!.Id!);
                                },
                                child: Container(
                                    height: 60,
                                    width: maxWidth(context),
                                    decoration: BoxDecoration(
                                        color: theme.primaryColor,
                                        border: Border.all(
                                            color: theme.primaryColor),
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    alignment: Alignment.center,
                                    child: Text("설정완료",
                                        style: theme.textTheme.headline5!
                                            .copyWith(color: Colors.white))))
                        ]))
                  ]),
                ]);
              } else {
                return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.4),
                      Center(
                          child: Text('no coupons :(',
                              style: theme.textTheme.headline3))
                    ]);
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
