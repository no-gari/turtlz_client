part of 'mypage_cubit.dart';

class MypageState extends Equatable {
  const MypageState(
      {this.user,
      this.orderReviews,
      this.orderDone,
      this.magReviews,
      this.error,
      this.isLoaded,
      this.isLoading});

  final Map<String, dynamic>? user;
  final int? orderDone;
  final int? magReviews;
  final int? orderReviews;
  final NetworkExceptions? error;
  final bool? isLoaded;
  final bool? isLoading;

  @override
  List<Object?> get props =>
      [user, orderDone, magReviews, orderReviews, error, isLoaded, isLoading];

  MypageState copyWith({
    Map<String, dynamic>? user,
    int? orderDone,
    int? magReviews,
    int? orderReviews,
    NetworkExceptions? error,
    bool? isLoaded,
    bool? isLoading,
  }) {
    return MypageState(
      user: user ?? this.user,
      orderDone: orderDone ?? this.orderDone,
      magReviews: magReviews ?? this.magReviews,
      orderReviews: orderReviews ?? this.orderReviews,
      error: error ?? this.error,
      isLoaded: isLoaded ?? this.isLoaded,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
