part of 'store_cubit.dart';

class StoreState extends Equatable {
  const StoreState({
    this.products,
    this.mainCollections,
    this.bannerCollections,
    this.selectedMenu,
    this.collections,
    this.subCollections,
    this.count = 0,
    this.previous,
    this.next,
    this.page = 1,
    this.maxIndex = false,
    this.isLoading = true,
    this.isLoaded = false,
    this.error,
  });

  final List<Product>? products;
  final List<dynamic>? mainCollections;
  final List<BannerCollection>? bannerCollections;
  final Collection? selectedMenu;
  final List<Menu>? collections;
  final List<Collection>? subCollections;
  final int? count;
  final String? previous;
  final String? next;
  final int? page;
  final bool? maxIndex;
  final bool isLoading;
  final bool isLoaded;
  final NetworkExceptions? error;

  @override
  List<Object?> get props => [
        products,
        mainCollections,
        bannerCollections,
        selectedMenu,
        collections,
        subCollections,
        count,
        previous,
        next,
        page,
        maxIndex,
        isLoaded,
        isLoading,
        error,
      ];

  StoreState copyWith({
    List<Product>? products,
    List<dynamic>? mainCollections,
    List<BannerCollection>? bannerCollections,
    Collection? selectedMenu,
    List<Menu>? collections,
    List<Collection>? subCollections,
    int? count,
    String? previous,
    String? next,
    int? page,
    bool? maxIndex,
    bool? isLoading,
    bool? isLoaded,
    NetworkExceptions? error,
  }) {
    return StoreState(
      products: products ?? this.products,
      mainCollections: mainCollections ?? this.mainCollections,
      bannerCollections: bannerCollections ?? this.bannerCollections,
      selectedMenu: selectedMenu ?? this.selectedMenu,
      collections: collections ?? this.collections,
      subCollections: subCollections ?? this.subCollections,
      count: count ?? this.count,
      previous: previous ?? this.previous,
      next: next ?? this.next,
      page: page ?? this.page,
      maxIndex: maxIndex ?? this.maxIndex,
      isLoading: isLoading ?? this.isLoading,
      isLoaded: isLoaded ?? this.isLoaded,
      error: error ?? this.error,
    );
  }
}
