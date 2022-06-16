part of 'payment_cubit.dart';

class PaymentState extends Equatable {
  const PaymentState({
    this.order,
    this.isLoaded = false,
    this.isLoading = true,
    this.error,
    this.errorMessage,
  });

  final Order? order;
  final bool isLoaded;
  final bool isLoading;
  final NetworkExceptions? error;
  final String? errorMessage;

  @override
  List<Object?> get props => [
        error,
        isLoaded,
        isLoading,
        errorMessage,
      ];

  PaymentState copyWith(
      {Order? order,
      bool? isLoading,
      bool? isLoaded,
      NetworkExceptions? error,
      String? errorMessage}) {
    return PaymentState(
      order: order ?? this.order,
      error: error ?? this.error,
      isLoading: isLoading ?? this.isLoading,
      isLoaded: isLoaded ?? this.isLoaded,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
