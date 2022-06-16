part of 'search_result_cubit.dart';

class SearchResultState extends Equatable {
  const SearchResultState(
      {required this.isLoaded,
      required this.isLoading,
      this.error,
      this.page,
      this.products,
      this.brands});

  final bool isLoading, isLoaded;
  final NetworkExceptions? error;
  final List? products, brands;
  final int? page;

  @override
  List<Object?> get props =>
      [error, page, isLoaded, isLoading, products, brands];

  SearchResultState copyWith(
      {String? keyword,
      List? products,
      List? brands,
      NetworkExceptions? error,
      bool? isLoading,
      int? page,
      bool? isLoaded}) {
    return SearchResultState(
      error: error ?? this.error,
      isLoaded: isLoaded ?? this.isLoaded,
      isLoading: isLoading ?? this.isLoading,
      brands: brands ?? this.brands,
      page: page ?? this.page,
      products: products ?? this.products,
    );
  }
}
