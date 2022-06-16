import 'package:turtlz/repositories/product_repository/models/product.dart';
import 'package:turtlz/support/networks/api_result.dart';
import 'package:turtlz/support/networks/dio_client.dart';
import 'package:turtlz/support/networks/network_exceptions.dart';

class ProductRepository {
  ProductRepository(this._dioClient);

  final DioClient _dioClient;

  Future<ApiResult<Product>> getProductDetail(String productId) async {
    try {
      var response =
          await _dioClient.get('/api/v1/commerce/product/detail/$productId');

      return ApiResult.success(data: Product.fromJson(response));
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  Future<ApiResult<List>> createCard(List<dynamic> body) async {
    try {
      var response =
          await _dioClient.post('/api/v1/commerce/cart/add/', data: body);

      return ApiResult.success(data: response["data"]);
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }
}
