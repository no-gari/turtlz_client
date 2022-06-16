part of 'cart_cubit.dart';

class CartState extends Equatable {
  const CartState(
      {this.carts, this.error, this.isLoaded = false, this.isLoading = true});

  final List<Cart>? carts;
  final bool isLoaded;
  final bool isLoading;
  final NetworkExceptions? error;

  @override
  List<Object?> get props => [
        carts,
        error,
        isLoaded,
        isLoading,
      ];

  CartState copyWith({
    List<Cart>? carts,
    NetworkExceptions? error,
    bool? isLoading,
    bool? isLoaded,
  }) {
    return CartState(
        carts: carts ?? this.carts,
        error: error ?? this.error,
        isLoaded: isLoaded ?? this.isLoaded,
        isLoading: isLoading ?? this.isLoading);
  }
}
