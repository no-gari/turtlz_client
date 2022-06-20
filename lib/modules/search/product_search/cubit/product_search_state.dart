part of 'product_search_cubit.dart';

class ProductSearchState extends Equatable {
  const ProductSearchState({
    this.products,
    this.isLoaded = false,
    this.isLoading = true,
    this.count,
    this.next,
    this.previous,
    this.page = 1,
    this.maxIndex,
    this.error,
    this.errorMessage,
  });

  final List<dynamic>? products;
  final bool isLoaded;
  final bool isLoading;
  final int? count;
  final String? next;
  final String? previous;
  final int page;
  final bool? maxIndex;
  final NetworkExceptions? error;
  final String? errorMessage;

  @override
  List<Object?> get props => [
        products,
        isLoaded,
        isLoading,
        count,
        next,
        previous,
        page,
        maxIndex,
        error,
        errorMessage,
      ];

  ProductSearchState copyWith({
    List<dynamic>? products,
    NetworkExceptions? error,
    bool? isLoading,
    bool? isLoaded,
    int? count,
    String? next,
    String? previous,
    int? page,
    bool? maxIndex,
    String? errorMessage,
  }) {
    return ProductSearchState(
      products: products ?? this.products,
      error: error ?? this.error,
      isLoading: isLoading ?? this.isLoading,
      isLoaded: isLoaded ?? this.isLoaded,
      count: count ?? this.count,
      next: next ?? this.next,
      page: page ?? this.page,
      previous: previous ?? this.previous,
      maxIndex: maxIndex ?? this.maxIndex,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
