import 'package:turtlz/modules/store/coupon/cubit/coupon_cubit.dart';
import 'package:turtlz/repositories/coupon_repository/models/coupon.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:turtlz/support/style/theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';

import 'components/coupon_tile_widget.dart';

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
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("COUPON", style: theme.textTheme.headline4)
                        ]),
                    SingleChildScrollView(
                        padding: EdgeInsets.symmetric(vertical: 30),
                        child: Column(
                            children: List.generate(
                                coupons.length,
                                (index) => GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          selected = index;
                                        });
                                      },
                                      child: couponTile(_couponCubit,
                                          coupons[index]!, selected == index),
                                    ))))
                  ]),
                  if (widget.isMypage == false)
                    Align(
                        alignment: Alignment.bottomCenter,
                        child: GestureDetector(
                            onTap: () async {
                              Navigator.pop(context, coupons[selected]!.Id!);
                            },
                            child: Container(
                                height: Adaptive.h(10),
                                width: 300,
                                color: Colors.black,
                                alignment: Alignment.center,
                                child: Text("설정완료",
                                    style: theme.textTheme.button!
                                        .copyWith(color: Colors.white)))))
                ]);
              } else {
                return Center(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                      Container(
                        child: SvgPicture.asset(
                          'assets/images/empty_cart.svg',
                          height: 80,
                          color: theme.accentColor,
                        ),
                      ),
                      Text("아무것도 없어요!",
                          style: theme.textTheme.headline2!.copyWith(height: 2))
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
