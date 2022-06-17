import 'package:turtlz/repositories/order_repository/models/order_form.dart';
import 'package:turtlz/repositories/order_repository/src/order_repository.dart';
import 'package:turtlz/support/networks/network_exceptions.dart';
import 'package:turtlz/support/networks/page_response.dart';
import 'package:turtlz/support/networks/api_result.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'orderForm_state.dart';

class OrderFormCubit extends Cubit<OrderFormState> {
  OrderFormCubit(this._orderRepository) : super(const OrderFormState());

  final OrderRepository _orderRepository;

  Future<void> getOrderForm() async {
    emit(state.copyWith(
      orderForm: [],
      isLoaded: false,
      isLoading: true,
    ));

    ApiResult<PageResponse> apiResult =
        await _orderRepository.getOrderForm(state.page);

    apiResult.when(success: (PageResponse? pageResponse) {
      emit(state.copyWith(
        orderForm:
            pageResponse!.results!.map((e) => OrderForm.fromJson(e)).toList(),
        count: pageResponse.count,
        page: state.page + 1,
        next: pageResponse.next,
        previous: pageResponse.previous,
        maxIndex: pageResponse.next == null ? true : false,
        isLoading: false,
        isLoaded: true,
      ));
    }, failure: (NetworkExceptions? error) {
      emit(state.copyWith(
        error: error,
        errorMessage: NetworkExceptions.getErrorMessage(error!),
      ));
    });
  }

  Future<void> getOrderFormById(String orderId) async {
    ApiResult<OrderForm> apiResult =
        await _orderRepository.getOrderFormById(orderId);

    apiResult.when(success: (OrderForm? response) {
      emit(state
          .copyWith(orderForm: [response!], isLoading: false, isLoaded: true));
    }, failure: (NetworkExceptions? error) {
      emit(state.copyWith(
        error: error,
        errorMessage: NetworkExceptions.getErrorMessage(error!),
      ));
    });
  }

  Future<void> approveOrder(String orderId) async {
    emit(state.copyWith(isLoaded: false, isLoading: true));
    ApiResult apiResult = await _orderRepository.approveOrder(orderId);

    apiResult.when(success: (dynamic response) {
      emit(state.copyWith(isLoaded: true, isLoading: false));
    }, failure: (NetworkExceptions? error) {
      emit(state.copyWith(
        error: error,
        errorMessage: NetworkExceptions.getErrorMessage(error!),
      ));
    });
  }
}
