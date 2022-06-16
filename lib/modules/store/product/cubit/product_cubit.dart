import 'package:turtlz/repositories/product_repository/product_repository.dart';
import 'package:turtlz/repositories/cart_repository/models/cart_temp.dart';
import 'package:turtlz/support/networks/network_exceptions.dart';
import 'package:turtlz/support/networks/api_result.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit(this._productRepository) : super(const ProductState());

  final ProductRepository _productRepository;

  Future<void> getProductDetail(String productId) async {
    ApiResult<Product> apiResult =
        await _productRepository.getProductDetail(productId);

    apiResult.when(success: (Product? productResponse) {
      print("product ${productResponse!}");
      emit(state.copyWith(
        products: [productResponse],
        isLoaded: true,
        isLoading: false,
      ));
    }, failure: (NetworkExceptions? error) {
      emit(state.copyWith(error: error));
    });
  }

  Future<List?> createCard(Product product, List<CartTemp> cartTemp) async {
    List<dynamic> body = cartTemp
        .map((temp) => {
              "product": product.Id,
              "variant": temp.variants!.Id,
              "quantity": temp.quantity
            })
        .toList();

    ApiResult<List> apiResult = await _productRepository.createCard(body);

    apiResult.when(success: (List? listResponse) {
      // return listResponse!.map((e) => e[]);
      return [];
      // List<String> newCartIds = mapResponse!.
    }, failure: (NetworkExceptions? error) {
      emit(state.copyWith(error: error));
    });
  }
}
// [{product: HS3QRF3RPGHK, variant: 2FQRP8P8H7NA, quantity: 1}, {product: HS3QRF3RPGHK, variant: G8PMPUDXYSWP, quantity: 1}]
