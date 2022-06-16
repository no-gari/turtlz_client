part of 'coupon_cubit.dart';

class CouponState extends Equatable {
  const CouponState(
      {this.coupons,
      this.isLoaded = false,
      this.isLoading = false,
      this.error});

  final List<Coupon>? coupons;
  final bool isLoading;
  final bool isLoaded;
  final NetworkExceptions? error;

  @override
  List<Object?> get props => [coupons, error, isLoaded, isLoading];

  CouponState copyWith({
    List<Coupon>? coupons,
    NetworkExceptions? error,
    bool? isLoading,
    bool? isLoaded,
  }) {
    return CouponState(
      coupons: coupons ?? this.coupons,
      error: error ?? this.error,
      isLoaded: isLoaded ?? this.isLoaded,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
