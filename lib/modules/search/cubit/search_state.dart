part of 'search_cubit.dart';

class BrandListState extends Equatable {
  const BrandListState(
      {this.keywords,
      this.count,
      this.next,
      this.previous,
      this.error,
      required this.page,
      required this.maxIndex,
      required this.isLoaded,
      required this.isLoading});

  final List<RecommendedKeyword>? keywords;
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
        keywords,
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
    List<RecommendedKeyword>? keywords,
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
        keywords: keywords ?? this.keywords,
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
