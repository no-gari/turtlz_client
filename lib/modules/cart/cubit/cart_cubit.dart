import 'package:turtlz/repositories/cart_repository/cart_repository.dart';
import 'package:turtlz/repositories/cart_repository/models/cart.dart';
import 'package:turtlz/support/networks/api_result.dart';
import 'package:turtlz/support/networks/network_exceptions.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit(this._cartRepository) : super(const CartState());

  final CartRepository _cartRepository;

  Future<void> getCartList() async {
    ApiResult<List> apiResult = await _cartRepository.getCartList();

    apiResult.when(success: (List? listResponse) {
      emit(state.copyWith(
        carts: listResponse!
            .map((cart) => Cart.fromJson(cart).copyWith(isChecked: true))
            .toList(),
        isLoading: false,
        isLoaded: true,
      ));
    }, failure: (NetworkExceptions? error) {
      emit(state.copyWith(error: error));
    });
  }

  void allSelectedCart(bool selected) {
    emit(state.copyWith(
        carts:
            state.carts!.map((e) => e.copyWith(isChecked: selected)).toList()));
  }

  void selectedCart(Cart cart) {
    emit(state.copyWith(
        carts: state.carts!
            .map((e) =>
                e == cart ? cart.copyWith(isChecked: !cart.isChecked!) : e)
            .toList()));
  }

  Future<void> deleteCart(List<Cart> selectedCarts) async {
    ApiResult<bool> apiResult;

    bool allDelete = listEquals(selectedCarts, state.carts);

    if (allDelete) {
      apiResult = await _cartRepository.deleteAllCart();
    } else {
      List body = List.generate(selectedCarts.length,
          (index) => {"item_id": selectedCarts[index].Id!});

      apiResult = await _cartRepository.deleteCart(body);
    }

    apiResult.when(success: (bool? result) {
      List<Cart> updateCarts = state.carts!.fold(
          [], (pre, cart) => selectedCarts.contains(cart) ? pre : pre + [cart]);
      emit(state.copyWith(carts: updateCarts));
    }, failure: (NetworkExceptions? error) {
      emit(state.copyWith(error: error));
    });
  }
}
