import 'package:turtlz/repositories/coupon_repository/coupon_repository.dart';
import 'package:turtlz/repositories/coupon_repository/models/coupon.dart';
import 'package:turtlz/support/networks/network_exceptions.dart';
import 'package:turtlz/support/networks/api_result.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'coupon_state.dart';

class CouponCubit extends Cubit<CouponState> {
  CouponCubit(this._couponRepository) : super(const CouponState());

  final CouponRepository _couponRepository;

  Future<void> getCouponList() async {
    ApiResult<List> apiResult = await _couponRepository.getCouponList();

    apiResult.when(success: (List? listResponse) {
      emit(state.copyWith(
        coupons:
            listResponse!.map((coupon) => Coupon.fromJson(coupon)).toList(),
        isLoading: false,
        isLoaded: true,
      ));
    }, failure: (NetworkExceptions? error) {
      emit(state.copyWith(error: error));
    });
  }
}
