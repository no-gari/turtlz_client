
part of 'address_cubit.dart';

class AddressState extends Equatable {
  const AddressState({
    this.addresses,
    this.isLoaded = false,
    this.isLoading = true,
    this.error,
  });

  final List<Address>? addresses;
  final bool isLoading;
  final bool isLoaded;
  final NetworkExceptions? error;

  @override
  List<Object?> get props => [
    addresses,
        error,
        isLoaded,
        isLoading,
      ];


  AddressState copyWith({
    List<Address>? addresses,
    NetworkExceptions? error,
    bool? isLoading,
    bool? isLoaded,
  }) {
    return AddressState(
      addresses: addresses ?? this.addresses,
      error: error ?? this.error,
      isLoaded: isLoaded ?? this.isLoaded,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
