part of 'brand_detail_cubit.dart';

class BrandDetailState extends Equatable {
  const BrandDetailState(
      {required this.isLoaded,
      required this.isLoading,
      this.error,
      this.products,
      this.magazines,
      this.name,
      this.description,
      this.logo,
      this.Id});

  final bool isLoading;
  final bool isLoaded;
  final NetworkExceptions? error;
  final List? magazines;
  final List? products;
  final String? Id, description, logo, name;

  @override
  List<Object?> get props => [
        error,
        isLoaded,
        isLoading,
        magazines,
        products,
        Id,
        name,
        logo,
        description
      ];

  BrandDetailState copyWith(
      {String? Id,
      String? name,
      String? logo,
      String? description,
      List? products,
      List? magazines,
      NetworkExceptions? error,
      bool? isLoading,
      bool? isLoaded}) {
    return BrandDetailState(
      error: error ?? this.error,
      isLoaded: isLoaded ?? this.isLoaded,
      isLoading: isLoading ?? this.isLoading,
      Id: Id ?? this.Id,
      name: name ?? this.name,
      logo: logo ?? this.logo,
      description: description ?? this.description,
      magazines: magazines ?? this.magazines,
      products: products ?? this.products,
    );
  }
}
