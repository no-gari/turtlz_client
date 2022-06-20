part of 'brand_search_cubit.dart';

class BrandSearchState extends Equatable {
  const BrandSearchState({
    this.brands,
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

  final List<dynamic>? brands;
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
        brands,
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

  BrandSearchState copyWith({
    List<dynamic>? brands,
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
    return BrandSearchState(
      brands: brands ?? this.brands,
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
