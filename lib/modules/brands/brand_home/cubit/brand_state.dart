part of 'brand_cubit.dart';

class BrandListState extends Equatable {
  const BrandListState(
      {this.brands,
      this.count,
      this.next,
      this.previous,
      this.error,
      required this.page,
      required this.maxIndex,
      required this.isLoaded,
      required this.isLoading});

  final List<BrandList>? brands;
  final int? count;
  final String? next;
  final String? previous;
  final NetworkExceptions? error;
  final int page;
  final bool maxIndex;
  final bool isLoaded;
  final bool isLoading;

  @override
  List<Object?> get props => [
        brands,
        maxIndex,
        isLoaded,
        isLoading,
        error,
        count,
        next,
        previous,
        page,
      ];

  BrandListState copyWith({
    List<BrandList>? brands,
    int? count,
    String? next,
    String? previous,
    NetworkExceptions? error,
    bool? maxIndex,
    bool? isLoading,
    bool? isLoaded,
    int? page,
  }) {
    return BrandListState(
        brands: brands ?? this.brands,
        count: count ?? this.count,
        next: next ?? this.next,
        page: page ?? this.page,
        previous: previous ?? this.previous,
        error: error ?? this.error,
        maxIndex: maxIndex ?? this.maxIndex,
        isLoaded: isLoaded ?? this.isLoaded,
        isLoading: isLoading ?? this.isLoading);
  }
}
