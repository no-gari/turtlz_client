import 'package:turtlz/repositories/address_repository/models/address.dart';
import 'package:turtlz/repositories/cart_repository/models/cart.dart';
import 'package:turtlz/repositories/coupon_repository/models/coupon.dart';
import 'package:turtlz/repositories/order_repository/models/models.dart';
import 'package:turtlz/repositories/order_repository/models/order_item.dart';
import 'package:turtlz/repositories/order_repository/models/order_temp.dart';
import 'package:turtlz/repositories/order_repository/src/order_repository.dart';
import 'package:turtlz/support/networks/api_result.dart';
import 'package:turtlz/support/networks/network_exceptions.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  OrderCubit(this._orderRepository) : super(const OrderState());

  final OrderRepository _orderRepository;

  void setAgreed() {
    emit(state.copyWith(agreed: !state.agreed));
  }

  void setDeliveryMessage(String message) {
    emit(state.copyWith(
        orderTemp: state.orderTemp!.copyWith(
            request: state.orderTemp!.request!
                .copyWith(additionalRequest: message))));
  }

  void setShippingRequest(ShippingRequest shippingRequest) {
    emit(state.copyWith(selectedShippingRequest: shippingRequest));
  }

  void updateAddress(Address updateAddress) {
    emit(state.copyWith(
        orderTemp: state.orderTemp!.copyWith(address: updateAddress)));
  }

  Future cancelOrder(String? orderId, String? reason) async {
    ApiResult apiResult = await _orderRepository.cancelOrder(orderId, reason);

    apiResult.when(success: (dynamic response) {
      return response;
    }, failure: (NetworkExceptions? error) {
      emit(state.copyWith(error: error));
    });
  }

  Future<Coupon?> getCoupon(dynamic couponId) async {
    ApiResult<Coupon> apiResult = await _orderRepository.getCoupon(couponId);

    apiResult.when(success: (Coupon? response) {
      emit(state.copyWith(
        orderTemp: state.orderTemp!.copyWith(coupon: response),
        isLoading: false,
        isLoaded: true,
      ));
      return response;
    }, failure: (NetworkExceptions? error) {
      emit(state.copyWith(error: error));
    });
  }

  Future<void> createOrder(List<Cart> carts) async {
    List<OrderItem> orderItems = carts
        .map((e) => OrderItem(
            brand: e.brand,
            productId: e.productId,
            productName: e.productName,
            productThumbnail: e.productThumbnail,
            variantId: e.variantId,
            variantName: e.variantName,
            salePrice: e.salePrice!.toInt(),
            quantity: e.quantity!.toInt(),
            Id: e.Id))
        .toList();

    ApiResult<OrderTemp> apiResult =
        await _orderRepository.createOrderTemp(orderItems);

    apiResult.when(success: (OrderTemp? response) {
      emit(state.copyWith(
        orderTemp: response,
        isLoaded: true,
        isLoading: false,
      ));
    }, failure: (NetworkExceptions? error) {
      emit(state.copyWith(
        error: error,
        errorMessage: NetworkExceptions.getErrorMessage(error!),
      ));
    });
  }
}
