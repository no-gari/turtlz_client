part of 'order_cubit.dart';

class OrderState extends Equatable {
  const OrderState({
    this.orderTemp,
    this.selectedShippingRequest,
    this.error,
    this.agreed = false,
    this.isLoaded = false,
    this.isLoading = true,
    this.errorMessage,
  });

  final OrderTemp? orderTemp;
  final ShippingRequest? selectedShippingRequest;
  final bool agreed;
  final bool isLoaded;
  final bool isLoading;
  final NetworkExceptions? error;
  final String? errorMessage;

  @override
  List<Object?> get props => [
        orderTemp,
        selectedShippingRequest,
        error,
        agreed,
        isLoaded,
        isLoading,
        errorMessage,
      ];

  OrderState copyWith({
    OrderTemp? orderTemp,
    ShippingRequest? selectedShippingRequest,
    bool? agreed,
    NetworkExceptions? error,
    bool? isLoading,
    bool? isLoaded,
    String? errorMessage,
  }) {
    return OrderState(
      orderTemp: orderTemp ?? this.orderTemp,
      selectedShippingRequest:
          selectedShippingRequest ?? this.selectedShippingRequest,
      agreed: agreed ?? this.agreed,
      error: error ?? this.error,
      isLoading: isLoading ?? this.isLoading,
      isLoaded: isLoaded ?? this.isLoaded,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
