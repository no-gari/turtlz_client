import 'package:turtlz/repositories/coupon_repository/src/coupon_repository.dart';
import 'package:turtlz/modules/store/coupon/cubit/coupon_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'coupon_page.dart';

class CouponScreen extends StatefulWidget {
  static String routeName = '/coupon_screen';
  final bool? isMypage;

  CouponScreen({this.isMypage = false});

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => CouponScreen());
  }

  @override
  State<CouponScreen> createState() => _CouponScreen();
}

class _CouponScreen extends State<CouponScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(automaticallyImplyLeading: true),
        body: BlocProvider<CouponCubit>(
            create: (context) =>
                CouponCubit(RepositoryProvider.of<CouponRepository>(context)),
            child: CouponPage(isMypage: widget.isMypage)));
  }
}
