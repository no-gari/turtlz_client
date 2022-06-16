part of 'product_cubit.dart';

class ProductState extends Equatable {
  const ProductState(
      {this.products,
      this.count = 0,
      this.previous,
      this.next,
      this.page = 1,
      this.maxIndex = false,
      this.error,
      this.isLoaded = false,
      this.isLoading = true});

  final List<Product>? products;

  final int count;
  final String? next;
  final String? previous;
  final int page;
  final bool maxIndex;

  final bool isLoaded;
  final bool isLoading;
  final NetworkExceptions? error;

  @override
  List<Object?> get props => [
        products,
        count,
        next,
        previous,
        maxIndex,
        page,
        error,
        isLoaded,
        isLoading,
      ];

  ProductState copyWith({
    List<Product>? products,
    int? page,
    int? count,
    String? next,
    String? previous,
    bool? maxIndex,
    NetworkExceptions? error,
    bool? isLoading,
    bool? isLoaded,
  }) {
    return ProductState(
        products: products ?? this.products,
        count: count ?? this.count,
        next: next ?? this.next,
        page: page ?? this.page,
        previous: previous ?? this.previous,
        maxIndex: maxIndex ?? this.maxIndex,
        error: error ?? this.error,
        isLoaded: isLoaded ?? this.isLoaded,
        isLoading: isLoading ?? this.isLoading);
  }
}
