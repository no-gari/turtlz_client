import 'package:turtlz/support/networks/api_result.dart';
import 'package:turtlz/support/networks/dio_client.dart';
import 'package:turtlz/support/networks/network_exceptions.dart';

class CountGetFailure implements Exception {}

class CartRepository {
  CartRepository(this._dioClient);

  final DioClient _dioClient;

  Future<int> getCartCount() async {
    try {
      var response =
          await _dioClient.getWithAuth('/api/v1/commerce/cart/count-items/');

      return response;
    } on Exception {
      throw CountGetFailure();
    }
  }

  Future<ApiResult<List>> getCartList() async {
    try {
      var response = await _dioClient.getWithAuth('/api/v1/commerce/cart/');

      return ApiResult.success(data: response);
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  Future<ApiResult<bool>> deleteAllCart() async {
    try {
      var response = await _dioClient.delete('/api/v1/commerce/cart/empty/');

      return ApiResult.success(data: true);
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  Future<ApiResult<bool>> deleteCart(List body) async {
    try {
      var response = await _dioClient
          .delete('/api/v1/commerce/cart/delete-item/', data: body);

      return ApiResult.success(data: true);
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }
}
